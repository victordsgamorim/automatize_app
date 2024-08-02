import 'package:automatize_app/core/database/dao/client_dao.dart';
import 'package:automatize_app/feature/model/client.dart';

abstract interface class ClientLocalDatasource {
  Stream<List<Client>> watchAll();

  Future<List<Client>> getAll();

  Future<void> insertBatch(List<Client> clients);

  Future<void> insert(Client client);
}

final class ClientLocalDatasourceImpl implements ClientLocalDatasource {
  final ClientDao _clientDao;

  const ClientLocalDatasourceImpl(
    this._clientDao,
  );

  @override
  Future<List<Client>> getAll() async {
    return await _clientDao.getAll();
  }

  @override
  Future<void> insertBatch(List<Client> clients) async {
    _clientDao.insetClientBatch(clients);
  }

  @override
  Stream<List<Client>> watchAll() {
    return _clientDao.watchAll();
  }

  @override
  Future<void> insert(Client client) async {
     _clientDao.insert(client);
  }
}
