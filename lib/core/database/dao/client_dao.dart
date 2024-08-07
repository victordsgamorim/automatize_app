import 'package:automatize_app/feature/model/address.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/model/phone.dart';
import 'package:sqflite/sqflite.dart';

class ClientDao {
  final Database _db;

  ClientDao(this._db);

  static const _clientTableName = 'clients';
  static const _addressTableName = 'addresses';
  static const _phonesTableName = 'phones';

  static const String _clientId = "id";
  static const String _name = "name";
  static const String _clientType = "type";
  static const String _isActive = "is_active";
  static const String _updatedAt = "updated_at";

  static const String _addressId = 'id';
  static const String _street = 'street';
  static const String _addressNumber = 'number';
  static const String _area = 'area';
  static const String _postalCode = 'postal_code';
  static const String _city = 'city';
  static const String _state = 'state';

  static const String _phoneId = "id";
  static const String _phoneNumber = "number";
  static const String _phoneType = "type";

  static const String _foreignClientId = "client_id";

  static const String clientTable = '''
          CREATE TABLE $_clientTableName (
            $_clientId TEXT PRIMARY KEY,
            $_name TEXT NOT NULL,
            $_clientType TEXT NOT NULL,
            $_isActive INTEGER NOT NULL,
            $_updatedAt TEXT NOT NULL
          )
        ''';

  static const String addressTable = '''
  CREATE TABLE $_addressTableName (
    $_addressId TEXT PRIMARY KEY,
    $_street TEXT NOT NULL,
    $_addressNumber TEXT NOT NULL,
    $_area TEXT NOT NULL,
    $_postalCode TEXT NOT NULL,
    $_city TEXT NOT NULL,
    $_state TEXT NOT NULL CHECK(LENGTH(state) = 2),
    $_foreignClientId TEXT NOT NULL,
    FOREIGN KEY ($_foreignClientId) REFERENCES $_clientTableName($_clientId) ON DELETE CASCADE
  )
''';

  static const String phoneTable = '''
    CREATE TABLE $_phonesTableName (
      $_phoneId TEXT PRIMARY KEY,
      $_phoneNumber TEXT NOT NULL,
      $_phoneType TEXT NOT NULL CHECK(LENGTH(type) = 1),
      $_foreignClientId TEXT NOT NULL,
      FOREIGN KEY ($_foreignClientId) REFERENCES $_clientTableName($_clientId) ON DELETE CASCADE
    )
  ''';

  Future<List<Client>> getAll({String search = ''}) async {
    final searchText = "%$search%";
    const String addressId = "address_id";
    const String phoneId = "phone_id";

    final dbClients = await _db.rawQuery('''
      SELECT 
        c.$_clientId as id,  c.$_name, c.$_clientType as client_type, c.$_isActive, c.$_updatedAt, 
        a.$_addressId as $addressId, a.$_street, a.$_addressNumber as address_number, a.$_area, a.$_postalCode, a.$_city, a.$_state, a.$_foreignClientId as address_client,
        p.$_phoneId as $phoneId, p.$_phoneNumber as phone_number, p.$_phoneType as phone_type, p.$_foreignClientId as phone_client
      FROM $_clientTableName c
      INNER JOIN $_addressTableName a ON c.id = a.$_foreignClientId
      INNER JOIN $_phonesTableName p ON c.id = p.$_foreignClientId
      WHERE c.$_isActive = 1 AND (c.$_name LIKE ? OR a.$_street LIKE ? OR a.$_city LIKE ? OR a.$_area LIKE ?)  
      ORDER BY c.$_name     
    ''', [searchText, searchText, searchText, searchText]);

    final Map<String, Client> clientsMap = {};
    final Map<String, Address> addressesMap = {};
    final Map<String, Phone> phonesMap = {};

    for (var c in dbClients) {
      final id = (c[_clientId] as String?) ?? "";

      if (!clientsMap.containsKey(id)) {
        Client client = Client.fromSQL(c);
        final address = Address.fromSQL(c);
        final phone = Phone.fromSQL(c);
        addressesMap[address.id!] = address;
        phonesMap[phone.id!] = phone;

        client = client.copyWith(
          addresses: [address],
          phones: [phone],
        );

        clientsMap[id] = client;
      } else {
        Client client = clientsMap[id]!;
        final aId = c[addressId];
        final pId = c[phoneId];
        List<Address>? addresses;
        List<Phone>? phones;
        if (!addressesMap.containsKey(aId)) {
          addresses = List.from(client.addresses)..add(Address.fromSQL(c));
        }

        if (!phonesMap.containsKey(pId)) {
          phones = List.from(client.phones)..add(Phone.fromSQL(c));
        }

        client = client.copyWith(addresses: addresses, phones: phones);
        clientsMap[id] = client;
      }
    }

    return List.from(clientsMap.values);
  }

  Future<void> insert(Client client) async {
    _db.insert(
      _clientTableName,
      client.toSQL(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final batch = _db.batch();
    for (Address address in client.addresses) {
      batch.insert(
        _addressTableName,
        address.toSQL(client.id),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    for (Phone phone in client.phones) {
      batch.insert(
        _phonesTableName,
        phone.toSQL(client.id),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit();
  }

  Future<void> insertBatch(List<Client> clients) async {
    final batch = _db.batch();
    for (Client client in clients) {
      batch.insert(
        _clientTableName,
        client.toSQL(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      for (Address address in client.addresses) {
        batch.insert(
          _addressTableName,
          address.toSQL(client.id),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }

      for (Phone phone in client.phones) {
        batch.insert(
          _phonesTableName,
          phone.toSQL(client.id),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    }
    await batch.commit();
  }

  Future<void> updateToDelete(String id) async {
    _db.update(_clientTableName, {_isActive: 0},
        where: '$_clientId = ?', whereArgs: [id]);
  }
}
