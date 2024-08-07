import 'package:automatize_app/core/database/dao/client_dao.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'automatize.db');
  return openDatabase(
    path,
    onCreate: (db, _) {
      db.execute(ClientDao.clientTable);
      db.execute(ClientDao.addressTable);
      db.execute(ClientDao.phoneTable);
    },
    version: 1,
  );
}
