import 'package:automatize_app/core/database/dao/client_dao.dart';
import 'package:automatize_app/feature/model/client.dart';

abstract interface class ClientLocalDatasource {
  Future<List<Client>> getAll();

  Future<void> insertBatch(List<Client> clients);
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
    _clientDao.insetBatch(clients);
  }
}
