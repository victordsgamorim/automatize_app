import 'package:automatize_app/core/database/app_database.dart';
import 'package:automatize_app/core/database/dao/address_dao.dart';
import 'package:automatize_app/core/database/dao/client_dao.dart';
import 'package:automatize_app/core/database/dao/phone_dao.dart';
import 'package:automatize_app/feature/model/client.dart';

abstract interface class ClientLocalDatasource {
  Future<List<Client>> getAll();

  Future<void> insertBatch(List<Client> clients);
}

final class ClientLocalDatasourceImpl implements ClientLocalDatasource {
  final ClientDao _clientDao;
  final AddressDao _addressDao;
  final PhoneDao _phoneDao;

  const ClientLocalDatasourceImpl(
    this._clientDao,
    this._addressDao,
    this._phoneDao,
  );

  @override
  Future<List<Client>> getAll() async {
    return await _clientDao.getAll();
  }

  @override
  Future<void> insertBatch(List<Client> clients) async {
    _clientDao.insetBatch(
      clients.map<ClientTableCompanion>((client) => client.toTable()).toList(),
    );

    for (var client in clients) {
      final addresses = client.addresses
          .map((address) => address.toTable(client.id))
          .toList();

      final phones =
          client.phones.map((phone) => phone.toTable(client.id)).toList();
      _addressDao.insetBatch(addresses);
      _phoneDao.insetBatch(phones);
    }
  }
}
