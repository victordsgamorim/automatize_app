import 'package:automatize_app/core/error/failure.dart';
import 'package:automatize_app/core/network/network_info.dart';
import 'package:automatize_app/core/utils/constaints/messages.dart';
import 'package:automatize_app/feature/data/datasource/local/client_local_datasource.dart';
import 'package:automatize_app/feature/data/datasource/remote/client_remote_datasource.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:dartz/dartz.dart';

abstract interface class ClientRepository {
  Future<Either<Failure, List<Client>>> getAll();

  Future<Either<Failure, Client>> insert(Client client);

  Future<Either<Failure, Client>> update(Client client);
}

final class ClientRepositoryImpl implements ClientRepository {
  final NetworkInfo _networkInfo;
  final ClientRemoteDatasource _clientRemoteDatasource;
  final ClientLocalDatasource _clientLocalDatasource;

  const ClientRepositoryImpl(
    this._networkInfo,
    this._clientRemoteDatasource,
    this._clientLocalDatasource,
  );

  @override
  Future<Either<Failure, List<Client>>> getAll() async {
    if (await _networkInfo.isConnected) {
      final data = await _clientRemoteDatasource.getAll();
      await _clientLocalDatasource.insertBatch(data);
      return Right(await _clientLocalDatasource.getAll());
    }

    return const Left(InternetFailure(message: noConnection));
  }

  @override
  Future<Either<Failure, Client>> insert(Client client) async {
    if (await _networkInfo.isConnected) {
      return Right(await _clientRemoteDatasource.insert(client));
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
