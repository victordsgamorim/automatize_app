import 'package:automatize_app/core/database/app_database.dart';
import 'package:drift/drift.dart';

part 'phone_dao.g.dart';

@DriftAccessor(tables: [PhoneTable])
class PhoneDao extends DatabaseAccessor<AppDatabase> with _$PhoneDaoMixin {
  PhoneDao(super.attachedDatabase);

  void insetBatch(List<PhoneTableCompanion> phones) async {
    await batch(
      (batch) => batch.insertAll(
        phoneTable,
        phones,
        mode: InsertMode.replace,
      ),
    );
  }

// void insetBatch(List<ClientTableCompanion> clients) async {
//   await batch((batch) => batch.insertAll(
//     clientTable,
//     clients,
//     mode: InsertMode.replace,
//   ));
// }
//
// Future<List<ClientTableData>> getAll() async {
//   return await select(clientTable).get();
// }
}
