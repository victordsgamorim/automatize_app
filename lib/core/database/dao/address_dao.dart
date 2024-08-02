import 'package:automatize_app/core/database/app_database.dart';
import 'package:drift/drift.dart';

part 'address_dao.g.dart';

@DriftAccessor(tables: [AddressTable])
class AddressDao extends DatabaseAccessor<AppDatabase> with _$AddressDaoMixin {
  AddressDao(super.attachedDatabase);

  void insetBatch(List<AddressTableCompanion> address) async {
    await batch(
      (batch) => batch.insertAll(
        addressTable,
        address,
        mode: InsertMode.replace,
      ),
    );
  }

  Future<List<AddressTableData>> getAll() async {
    return await select(addressTable).get();
  }
}
