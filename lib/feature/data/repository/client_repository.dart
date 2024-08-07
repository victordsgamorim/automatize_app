import 'dart:async';

import 'package:automatize_app/core/database/dao/client_dao.dart';
import 'package:automatize_app/core/error/failure.dart';
import 'package:automatize_app/core/network/network_info.dart';
import 'package:automatize_app/core/utils/constaints/messages.dart';
import 'package:automatize_app/feature/data/datasource/local/update_local_datasource.dart';
import 'package:automatize_app/feature/data/datasource/remote/client_remote_datasource.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/model/no_param.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ClientRepository {
  Future<Either<Failure, List<Client>>> getAll({String? search});

  Future<Either<Failure, Client?>> getClientById(String id);

  Future<Either<Failure, NoParam>> syncDatabase({DateTime? from});

  Future<Either<Failure, Client>> create(Client client);

  Future<Either<Failure, Client>> update(Client client);

  Future<Either<Failure, String>> deleteById(String id);
}

final class ClientRepositoryImpl implements ClientRepository {
  final NetworkInfo _networkInfo;
  final ClientRemoteDatasource _clientRemoteDatasource;
  final ClientDao _clientDao;
  final UpdateLocalDatasource _updateLocalDatasource;

  const ClientRepositoryImpl(
    this._networkInfo,
    this._clientRemoteDatasource,
    this._clientDao,
    this._updateLocalDatasource,
  );

  @override
  Future<Either<Failure, NoParam>> syncDatabase({DateTime? from}) async {
    if (await _networkInfo.isConnected) {
      final remoteData = await _clientRemoteDatasource.getAllByDate(from: from);
      await _clientDao.insertBatch(remoteData);
      return const Right(NoParam());
    }

    return const Left(InternetFailure(message: noConnection));
  }

  @override
  Future<Either<Failure, List<Client>>> getAll({String? search}) async {
    if (search == null) {
      final date = await _updateLocalDatasource.getUpdatedTime();
      await syncDatabase(from: null);
      await _updateLocalDatasource.setUpdatedTime(DateTime.now());
    }

    return Right(await _clientDao.getAll(search: search ?? ''));
  }

  @override
  Future<Either<Failure, Client?>> getClientById(String id) async {
    try {
      if (await _networkInfo.isConnected) {
        final remoteData = await _clientRemoteDatasource.getClientById(id);
        if (remoteData != null) await _clientDao.insert(remoteData);
        return Right(remoteData);
      }
    } on TimeoutException {
      return const Left(ServerFailure(message: serverConnection));
    } on PostgrestException catch(e){
      return const Left(ServerFailure(message: notFound));
    }

    return const Left(InternetFailure(message: noConnection));
  }

  @override
  Future<Either<Failure, Client>> create(Client client) async {
    try {
      if (await _networkInfo.isConnected) {
        final clientResponse = await _clientRemoteDatasource.insert(client);
        await _clientDao.insert(clientResponse);
        return Right(clientResponse);
      }
    } on TimeoutException {
      return const Left(ServerFailure(message: serverConnection));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(
        message: e.code == duplicatedCode.toString()
            ? '$duplicatedClient ${client.id}'
            : serverConnection,
      ));
    }

    return const Left(InternetFailure(message: noConnection));
  }

  @override
  Future<Either<Failure, Client>> update(Client client) async {
    try {
      if (await _networkInfo.isConnected) {
        final remoteData = await _clientRemoteDatasource.update(client);
        await _clientDao.insert(remoteData);
        return Right(remoteData);
      }
    } on TimeoutException{
      return const Left(ServerFailure(message: serverConnection));
    } on PostgrestException catch (e) {
      return Left(ServerFailure(
          message: e.code == nullValueCode.toString() ? nullValue : notFound));
    }

    return const Left(InternetFailure(message: noConnection));
  }

  @override
  Future<Either<Failure, String>> deleteById(String id) async {
    if (await _networkInfo.isConnected) {
      final idRemote = await _clientRemoteDatasource.deleteById(id);
      await _clientDao.updateToDelete(idRemote);
      return Right(idRemote);
    }

    return const Left(InternetFailure(message: noConnection));
  }
}
