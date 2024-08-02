import 'dart:ui';

import 'package:automatize_app/core/database/dao/client_dao.dart';
import 'package:automatize_app/core/error/failure.dart';
import 'package:automatize_app/core/network/network_info.dart';
import 'package:automatize_app/core/utils/constaints/messages.dart';
import 'package:automatize_app/feature/data/datasource/remote/client_remote_datasource.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:dartz/dartz.dart';

abstract interface class ClientRepository {
  Stream<List<Client>> watchAll();

  Future<Either<Failure, List<Client>>> getAll();

  Future<Either<Failure, Client>> insert(Client client);

  Future<Either<Failure, Client>> update(Client client);
}

final class ClientRepositoryImpl implements ClientRepository {
  final NetworkInfo _networkInfo;
  final ClientRemoteDatasource _clientRemoteDatasource;
  final ClientDao _clientDao;

  const ClientRepositoryImpl(
    this._networkInfo,
    this._clientRemoteDatasource,
    this._clientDao,
  );

  @override
  Stream<List<Client>> watchAll() {
    getAll();
    return _clientDao.watchAll();
  }

  @override
  Future<Either<Failure, List<Client>>> getAll() async {
    if (await _networkInfo.isConnected) {
      final remoteData = await _clientRemoteDatasource.getAll();

      // _clientDao.deleteAll();
      await _clientDao.insertBatch(remoteData);

      return Right(await _clientDao.getAll());
    }

    return const Left(InternetFailure(message: noConnection));
  }

  @override
  Future<Either<Failure, Client>> insert(Client client) async {
    if (await _networkInfo.isConnected) {
      final clientResponse = await _clientRemoteDatasource.insert(client);
      await _clientDao.insert(clientResponse);
      return Right(clientResponse);
    }

    return const Left(InternetFailure(message: noConnection));
  }

  @override
  Future<Either<Failure, Client>> update(Client client) async {
    if (await _networkInfo.isConnected) {
      return Right(await _clientRemoteDatasource.insert(client));
    }

    return const Left(InternetFailure(message: noConnection));
  }
}
