import 'package:automatize_app/core/database/app_database.dart';
import 'package:automatize_app/feature/model/address.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/model/phone.dart';
import 'package:drift/drift.dart';

part 'client_dao.g.dart';

@DriftAccessor(tables: [ClientTable, AddressTable, PhoneTable])
class ClientDao extends DatabaseAccessor<AppDatabase> with _$ClientDaoMixin {
  ClientDao(super.attachedDatabase);

  void insetBatch(List<Client> clients) async {
    await batch((batch) {
      List<ClientTableCompanion> clientTableCompanion = [];
      late List<AddressTableCompanion> addressTableCompanion;
      late List<PhoneTableCompanion> phoneTableCompanion;
      for (var client in clients) {
        clientTableCompanion.add(client.toTable());
        addressTableCompanion = client.addresses
            .map<AddressTableCompanion>((address) => address.toTable(client.id))
            .toList();

        phoneTableCompanion = client.phones
            .map<PhoneTableCompanion>((phone) => phone.toTable(client.id))
            .toList();
      }

      batch.insertAll(
        clientTable,
        clientTableCompanion,
        mode: InsertMode.replace,
      );

      batch.insertAll(
        addressTable,
        addressTableCompanion,
        mode: InsertMode.replace,
      );

      batch.insertAll(
        phoneTable,
        phoneTableCompanion,
        mode: InsertMode.replace,
      );
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
}
