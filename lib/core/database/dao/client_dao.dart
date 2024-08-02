import 'package:automatize_app/core/database/app_database.dart';
import 'package:automatize_app/feature/model/address.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/model/phone.dart';
import 'package:drift/drift.dart';
import 'package:go_router/go_router.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [ClientTable, AddressTable, PhoneTable])
class ClientDao extends DatabaseAccessor<AppDatabase> with _$ClientDaoMixin {
  ClientDao(super.attachedDatabase);

  Future<void> insertBatch(List<Client> clients) async {
    await insetClientBatch(clients);

    for (var client in clients) {
      await insertAddressBatch(
        clientId: client.id,
        addresses: client.addresses,
      );

      await insertPhoneBatch(
        clientId: client.id,
        phones: client.phones,
      );
    }
  }

  Future<void> insetClientBatch(List<Client> clients) async {
    await batch((batch) async {
      batch.insertAll(
        clientTable,
        clients
            .map<ClientTableCompanion>((client) => client.toTable())
            .toList(),
        mode: InsertMode.replace,
      );
    });
  }

  Future<void> insertAddressBatch({
    required String clientId,
    required List<Address> addresses,
  }) async {
    await batch((batch) async {
      batch.insertAll(
        addressTable,
        addresses
            .map<AddressTableCompanion>((address) => address.toTable(clientId))
            .toList(),
        mode: InsertMode.replace,
      );
    });
  }

  Future<void> insertPhoneBatch({
    required String clientId,
    required List<Phone> phones,
  }) async {
    await batch((batch) async {
      batch.insertAll(
        phoneTable,
        phones
            .map<PhoneTableCompanion>((phone) => phone.toTable(clientId))
            .toList(),
        mode: InsertMode.replace,
      );
    });
  }

  Future<void> insert(Client client) async {
    await transaction(() async {
      await into(clientTable).insert(client.toTable());

      await batch((batch) {
        batch.insertAll(
          addressTable,
          client.addresses
              .map<AddressTableCompanion>(
                  (address) => address.toTable(client.id))
              .toList(),
        );

        batch.insertAll(
          phoneTable,
          client.phones
              .map<PhoneTableCompanion>((phone) => phone.toTable(client.id))
              .toList(),
        );
      });
    });
  }

  Future<List<Client>> getAll() async {
    final query = select(clientTable).join(
      [
        leftOuterJoin(
          addressTable,
          addressTable.clientId.equalsExp(clientTable.id),
        ),
        leftOuterJoin(
          phoneTable,
          phoneTable.clientId.equalsExp(clientTable.id),
        ),
      ],
    );

    final rows = await query.get();

    Map<String, Client> clientsMap = {};
    Map<String, List<Address>> addressesMap = {};
    Map<String, List<Phone>> phonesMap = {};

    for (var row in rows) {
      final clientRow = row.readTable(clientTable);
      final addressRow = row.readTableOrNull(addressTable);
      final phoneRow = row.readTableOrNull(phoneTable);

      if (!clientsMap.containsKey(clientRow.id)) {
        clientsMap[clientRow.id] = Client.fromTable(clientRow);
        addressesMap[clientRow.id] = [];
        phonesMap[clientRow.id] = [];
      }

      if (addressRow != null) {
        addressesMap[clientRow.id]!.add(Address.fromTable(addressRow));
      }

      if (phoneRow != null) {
        phonesMap[clientRow.id]!.add(Phone.fromTable(phoneRow));
      }
    }

    return clientsMap.values.map((client) {
      return client.copyWith(
        addresses: addressesMap[client.id] ?? [],
        phones: phonesMap[client.id] ?? [],
      );
    }).toList();
  }

  Stream<List<Client>> watchAll() {
    final query = select(clientTable).join(
      [
        leftOuterJoin(
          addressTable,
          addressTable.clientId.equalsExp(clientTable.id),
        ),
        leftOuterJoin(
          phoneTable,
          phoneTable.clientId.equalsExp(clientTable.id),
        ),
      ],
    );

    return query.watch().map((rows) {
      Map<String, Client> clientsMap = {};
      Map<String, List<Address>> addressesMap = {};
      Map<String, List<Phone>> phonesMap = {};

      for (var row in rows) {
        final clientRow = row.readTable(clientTable);
        final addressRow = row.readTableOrNull(addressTable);
        final phoneRow = row.readTableOrNull(phoneTable);

        if (!clientsMap.containsKey(clientRow.id)) {
          clientsMap[clientRow.id] = Client.fromTable(clientRow);
          addressesMap[clientRow.id] = [];
          phonesMap[clientRow.id] = [];
        }

        if (addressRow != null) {
          addressesMap[clientRow.id]!.add(Address.fromTable(addressRow));
        }

        if (phoneRow != null) {
          phonesMap[clientRow.id]!.add(Phone.fromTable(phoneRow));
        }
      }

      return clientsMap.values.map((client) {
        return client.copyWith(
          addresses: addressesMap[client.id] ?? [],
          phones: phonesMap[client.id] ?? [],
        );
      }).toList();
    });
  }

  Future<void> deleteAll() async {
    delete(clientTable).go();
    delete(addressTable).go();
    delete(phoneTable).go();
  }
}
