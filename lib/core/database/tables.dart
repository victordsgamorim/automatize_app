part of 'app_database.dart';

class ClientTable extends Table {
  TextColumn get id => text().withLength(min: 11, max: 14)();

  TextColumn get name => text()();

  TextColumn get type => text().withLength(min: 1, max: 1)();

  @override
  String? get tableName => 'clients';

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class AddressTable extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();

  TextColumn get street => text()();

  TextColumn get number => text()();

  TextColumn get area => text()();

  TextColumn get postalCode => text()();

  TextColumn get city => text()();

  TextColumn get state => text().withLength(min: 2, max: 2)();

  TextColumn get clientId => text().references(ClientTable, #id)();
      // .customConstraint('REFERENCES clients(id) NOT NULL')
  @override
  String? get tableName => 'addresses';

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class PhoneTable extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();

  TextColumn get number => text()();

  TextColumn get type => text().withLength(min: 1, max: 1)();

  TextColumn get clientId => text().references(ClientTable, #id)();

  @override
  String? get tableName => 'phones';

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
