// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientTableTable extends ClientTable
    with TableInfo<$ClientTableTable, ClientTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 11, maxTextLength: 14),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<ClientTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
    );
  }

  @override
  $ClientTableTable createAlias(String alias) {
    return $ClientTableTable(attachedDatabase, alias);
  }
}

class ClientTableData extends DataClass implements Insertable<ClientTableData> {
  final String id;
  final String name;
  final String type;
  const ClientTableData(
      {required this.id, required this.name, required this.type});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    return map;
  }

  ClientTableCompanion toCompanion(bool nullToAbsent) {
    return ClientTableCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
    );
  }

  factory ClientTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
    };
  }

  ClientTableData copyWith({String? id, String? name, String? type}) =>
      ClientTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
      );
  ClientTableData copyWithCompanion(ClientTableCompanion data) {
    return ClientTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type);
}

class ClientTableCompanion extends UpdateCompanion<ClientTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> rowid;
  const ClientTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientTableCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        type = Value(type);
  static Insertable<ClientTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? type,
      Value<int>? rowid}) {
    return ClientTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AddressTableTable extends AddressTable
    with TableInfo<$AddressTableTable, AddressTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AddressTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _streetMeta = const VerificationMeta('street');
  @override
  late final GeneratedColumn<String> street = GeneratedColumn<String>(
      'street', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
      'area', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _postalCodeMeta =
      const VerificationMeta('postalCode');
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
      'postal_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
      'state', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 2),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, street, number, area, postalCode, city, state, clientId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'addresses';
  @override
  VerificationContext validateIntegrity(Insertable<AddressTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    } else if (isInserting) {
      context.missing(_streetMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area']!, _areaMeta));
    } else if (isInserting) {
      context.missing(_areaMeta);
    }
    if (data.containsKey('postal_code')) {
      context.handle(
          _postalCodeMeta,
          postalCode.isAcceptableOrUnknown(
              data['postal_code']!, _postalCodeMeta));
    } else if (isInserting) {
      context.missing(_postalCodeMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
          _stateMeta, state.isAcceptableOrUnknown(data['state']!, _stateMeta));
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AddressTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AddressTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      street: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}street'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      area: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}area'])!,
      postalCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}postal_code'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      state: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
    );
  }

  @override
  $AddressTableTable createAlias(String alias) {
    return $AddressTableTable(attachedDatabase, alias);
  }
}

class AddressTableData extends DataClass
    implements Insertable<AddressTableData> {
  final String id;
  final String street;
  final String number;
  final String area;
  final String postalCode;
  final String city;
  final String state;
  final String clientId;
  const AddressTableData(
      {required this.id,
      required this.street,
      required this.number,
      required this.area,
      required this.postalCode,
      required this.city,
      required this.state,
      required this.clientId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['street'] = Variable<String>(street);
    map['number'] = Variable<String>(number);
    map['area'] = Variable<String>(area);
    map['postal_code'] = Variable<String>(postalCode);
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['client_id'] = Variable<String>(clientId);
    return map;
  }

  AddressTableCompanion toCompanion(bool nullToAbsent) {
    return AddressTableCompanion(
      id: Value(id),
      street: Value(street),
      number: Value(number),
      area: Value(area),
      postalCode: Value(postalCode),
      city: Value(city),
      state: Value(state),
      clientId: Value(clientId),
    );
  }

  factory AddressTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AddressTableData(
      id: serializer.fromJson<String>(json['id']),
      street: serializer.fromJson<String>(json['street']),
      number: serializer.fromJson<String>(json['number']),
      area: serializer.fromJson<String>(json['area']),
      postalCode: serializer.fromJson<String>(json['postalCode']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      clientId: serializer.fromJson<String>(json['clientId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'street': serializer.toJson<String>(street),
      'number': serializer.toJson<String>(number),
      'area': serializer.toJson<String>(area),
      'postalCode': serializer.toJson<String>(postalCode),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'clientId': serializer.toJson<String>(clientId),
    };
  }

  AddressTableData copyWith(
          {String? id,
          String? street,
          String? number,
          String? area,
          String? postalCode,
          String? city,
          String? state,
          String? clientId}) =>
      AddressTableData(
        id: id ?? this.id,
        street: street ?? this.street,
        number: number ?? this.number,
        area: area ?? this.area,
        postalCode: postalCode ?? this.postalCode,
        city: city ?? this.city,
        state: state ?? this.state,
        clientId: clientId ?? this.clientId,
      );
  AddressTableData copyWithCompanion(AddressTableCompanion data) {
    return AddressTableData(
      id: data.id.present ? data.id.value : this.id,
      street: data.street.present ? data.street.value : this.street,
      number: data.number.present ? data.number.value : this.number,
      area: data.area.present ? data.area.value : this.area,
      postalCode:
          data.postalCode.present ? data.postalCode.value : this.postalCode,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AddressTableData(')
          ..write('id: $id, ')
          ..write('street: $street, ')
          ..write('number: $number, ')
          ..write('area: $area, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, street, number, area, postalCode, city, state, clientId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AddressTableData &&
          other.id == this.id &&
          other.street == this.street &&
          other.number == this.number &&
          other.area == this.area &&
          other.postalCode == this.postalCode &&
          other.city == this.city &&
          other.state == this.state &&
          other.clientId == this.clientId);
}

class AddressTableCompanion extends UpdateCompanion<AddressTableData> {
  final Value<String> id;
  final Value<String> street;
  final Value<String> number;
  final Value<String> area;
  final Value<String> postalCode;
  final Value<String> city;
  final Value<String> state;
  final Value<String> clientId;
  final Value<int> rowid;
  const AddressTableCompanion({
    this.id = const Value.absent(),
    this.street = const Value.absent(),
    this.number = const Value.absent(),
    this.area = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.clientId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AddressTableCompanion.insert({
    required String id,
    required String street,
    required String number,
    required String area,
    required String postalCode,
    required String city,
    required String state,
    required String clientId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        street = Value(street),
        number = Value(number),
        area = Value(area),
        postalCode = Value(postalCode),
        city = Value(city),
        state = Value(state),
        clientId = Value(clientId);
  static Insertable<AddressTableData> custom({
    Expression<String>? id,
    Expression<String>? street,
    Expression<String>? number,
    Expression<String>? area,
    Expression<String>? postalCode,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? clientId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (street != null) 'street': street,
      if (number != null) 'number': number,
      if (area != null) 'area': area,
      if (postalCode != null) 'postal_code': postalCode,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (clientId != null) 'client_id': clientId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AddressTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? street,
      Value<String>? number,
      Value<String>? area,
      Value<String>? postalCode,
      Value<String>? city,
      Value<String>? state,
      Value<String>? clientId,
      Value<int>? rowid}) {
    return AddressTableCompanion(
      id: id ?? this.id,
      street: street ?? this.street,
      number: number ?? this.number,
      area: area ?? this.area,
      postalCode: postalCode ?? this.postalCode,
      city: city ?? this.city,
      state: state ?? this.state,
      clientId: clientId ?? this.clientId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (street.present) {
      map['street'] = Variable<String>(street.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AddressTableCompanion(')
          ..write('id: $id, ')
          ..write('street: $street, ')
          ..write('number: $number, ')
          ..write('area: $area, ')
          ..write('postalCode: $postalCode, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('clientId: $clientId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhoneTableTable extends PhoneTable
    with TableInfo<$PhoneTableTable, PhoneTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhoneTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 36, maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
      'number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
      'client_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clients (id)'));
  @override
  List<GeneratedColumn> get $columns => [id, number, type, clientId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phones';
  @override
  VerificationContext validateIntegrity(Insertable<PhoneTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta,
          number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhoneTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhoneTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      number: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}number'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_id'])!,
    );
  }

  @override
  $PhoneTableTable createAlias(String alias) {
    return $PhoneTableTable(attachedDatabase, alias);
  }
}

class PhoneTableData extends DataClass implements Insertable<PhoneTableData> {
  final String id;
  final String number;
  final String type;
  final String clientId;
  const PhoneTableData(
      {required this.id,
      required this.number,
      required this.type,
      required this.clientId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['number'] = Variable<String>(number);
    map['type'] = Variable<String>(type);
    map['client_id'] = Variable<String>(clientId);
    return map;
  }

  PhoneTableCompanion toCompanion(bool nullToAbsent) {
    return PhoneTableCompanion(
      id: Value(id),
      number: Value(number),
      type: Value(type),
      clientId: Value(clientId),
    );
  }

  factory PhoneTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhoneTableData(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<String>(json['number']),
      type: serializer.fromJson<String>(json['type']),
      clientId: serializer.fromJson<String>(json['clientId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<String>(number),
      'type': serializer.toJson<String>(type),
      'clientId': serializer.toJson<String>(clientId),
    };
  }

  PhoneTableData copyWith(
          {String? id, String? number, String? type, String? clientId}) =>
      PhoneTableData(
        id: id ?? this.id,
        number: number ?? this.number,
        type: type ?? this.type,
        clientId: clientId ?? this.clientId,
      );
  PhoneTableData copyWithCompanion(PhoneTableCompanion data) {
    return PhoneTableData(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      type: data.type.present ? data.type.value : this.type,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhoneTableData(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('type: $type, ')
          ..write('clientId: $clientId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, number, type, clientId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhoneTableData &&
          other.id == this.id &&
          other.number == this.number &&
          other.type == this.type &&
          other.clientId == this.clientId);
}

class PhoneTableCompanion extends UpdateCompanion<PhoneTableData> {
  final Value<String> id;
  final Value<String> number;
  final Value<String> type;
  final Value<String> clientId;
  final Value<int> rowid;
  const PhoneTableCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.type = const Value.absent(),
    this.clientId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhoneTableCompanion.insert({
    required String id,
    required String number,
    required String type,
    required String clientId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        number = Value(number),
        type = Value(type),
        clientId = Value(clientId);
  static Insertable<PhoneTableData> custom({
    Expression<String>? id,
    Expression<String>? number,
    Expression<String>? type,
    Expression<String>? clientId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (type != null) 'type': type,
      if (clientId != null) 'client_id': clientId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhoneTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? number,
      Value<String>? type,
      Value<String>? clientId,
      Value<int>? rowid}) {
    return PhoneTableCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      type: type ?? this.type,
      clientId: clientId ?? this.clientId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhoneTableCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('type: $type, ')
          ..write('clientId: $clientId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientTableTable clientTable = $ClientTableTable(this);
  late final $AddressTableTable addressTable = $AddressTableTable(this);
  late final $PhoneTableTable phoneTable = $PhoneTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [clientTable, addressTable, phoneTable];
}

typedef $$ClientTableTableCreateCompanionBuilder = ClientTableCompanion
    Function({
  required String id,
  required String name,
  required String type,
  Value<int> rowid,
});
typedef $$ClientTableTableUpdateCompanionBuilder = ClientTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String> type,
  Value<int> rowid,
});

class $$ClientTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientTableTable,
    ClientTableData,
    $$ClientTableTableFilterComposer,
    $$ClientTableTableOrderingComposer,
    $$ClientTableTableCreateCompanionBuilder,
    $$ClientTableTableUpdateCompanionBuilder> {
  $$ClientTableTableTableManager(_$AppDatabase db, $ClientTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ClientTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ClientTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientTableCompanion(
            id: id,
            name: name,
            type: type,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String type,
            Value<int> rowid = const Value.absent(),
          }) =>
              ClientTableCompanion.insert(
            id: id,
            name: name,
            type: type,
            rowid: rowid,
          ),
        ));
}

class $$ClientTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ClientTableTable> {
  $$ClientTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter addressTableRefs(
      ComposableFilter Function($$AddressTableTableFilterComposer f) f) {
    final $$AddressTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.addressTable,
        getReferencedColumn: (t) => t.clientId,
        builder: (joinBuilder, parentComposers) =>
            $$AddressTableTableFilterComposer(ComposerState($state.db,
                $state.db.addressTable, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter phoneTableRefs(
      ComposableFilter Function($$PhoneTableTableFilterComposer f) f) {
    final $$PhoneTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.phoneTable,
        getReferencedColumn: (t) => t.clientId,
        builder: (joinBuilder, parentComposers) =>
            $$PhoneTableTableFilterComposer(ComposerState($state.db,
                $state.db.phoneTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$ClientTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ClientTableTable> {
  $$ClientTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$AddressTableTableCreateCompanionBuilder = AddressTableCompanion
    Function({
  required String id,
  required String street,
  required String number,
  required String area,
  required String postalCode,
  required String city,
  required String state,
  required String clientId,
  Value<int> rowid,
});
typedef $$AddressTableTableUpdateCompanionBuilder = AddressTableCompanion
    Function({
  Value<String> id,
  Value<String> street,
  Value<String> number,
  Value<String> area,
  Value<String> postalCode,
  Value<String> city,
  Value<String> state,
  Value<String> clientId,
  Value<int> rowid,
});

class $$AddressTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AddressTableTable,
    AddressTableData,
    $$AddressTableTableFilterComposer,
    $$AddressTableTableOrderingComposer,
    $$AddressTableTableCreateCompanionBuilder,
    $$AddressTableTableUpdateCompanionBuilder> {
  $$AddressTableTableTableManager(_$AppDatabase db, $AddressTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$AddressTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$AddressTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> street = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<String> area = const Value.absent(),
            Value<String> postalCode = const Value.absent(),
            Value<String> city = const Value.absent(),
            Value<String> state = const Value.absent(),
            Value<String> clientId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AddressTableCompanion(
            id: id,
            street: street,
            number: number,
            area: area,
            postalCode: postalCode,
            city: city,
            state: state,
            clientId: clientId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String street,
            required String number,
            required String area,
            required String postalCode,
            required String city,
            required String state,
            required String clientId,
            Value<int> rowid = const Value.absent(),
          }) =>
              AddressTableCompanion.insert(
            id: id,
            street: street,
            number: number,
            area: area,
            postalCode: postalCode,
            city: city,
            state: state,
            clientId: clientId,
            rowid: rowid,
          ),
        ));
}

class $$AddressTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $AddressTableTable> {
  $$AddressTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get street => $state.composableBuilder(
      column: $state.table.street,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get area => $state.composableBuilder(
      column: $state.table.area,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postalCode => $state.composableBuilder(
      column: $state.table.postalCode,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get city => $state.composableBuilder(
      column: $state.table.city,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get state => $state.composableBuilder(
      column: $state.table.state,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ClientTableTableFilterComposer get clientId {
    final $$ClientTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $state.db.clientTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ClientTableTableFilterComposer(ComposerState($state.db,
                $state.db.clientTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$AddressTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $AddressTableTable> {
  $$AddressTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get street => $state.composableBuilder(
      column: $state.table.street,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get area => $state.composableBuilder(
      column: $state.table.area,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postalCode => $state.composableBuilder(
      column: $state.table.postalCode,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get city => $state.composableBuilder(
      column: $state.table.city,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get state => $state.composableBuilder(
      column: $state.table.state,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ClientTableTableOrderingComposer get clientId {
    final $$ClientTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $state.db.clientTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ClientTableTableOrderingComposer(ComposerState($state.db,
                $state.db.clientTable, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PhoneTableTableCreateCompanionBuilder = PhoneTableCompanion Function({
  required String id,
  required String number,
  required String type,
  required String clientId,
  Value<int> rowid,
});
typedef $$PhoneTableTableUpdateCompanionBuilder = PhoneTableCompanion Function({
  Value<String> id,
  Value<String> number,
  Value<String> type,
  Value<String> clientId,
  Value<int> rowid,
});

class $$PhoneTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhoneTableTable,
    PhoneTableData,
    $$PhoneTableTableFilterComposer,
    $$PhoneTableTableOrderingComposer,
    $$PhoneTableTableCreateCompanionBuilder,
    $$PhoneTableTableUpdateCompanionBuilder> {
  $$PhoneTableTableTableManager(_$AppDatabase db, $PhoneTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PhoneTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PhoneTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> number = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> clientId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhoneTableCompanion(
            id: id,
            number: number,
            type: type,
            clientId: clientId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String number,
            required String type,
            required String clientId,
            Value<int> rowid = const Value.absent(),
          }) =>
              PhoneTableCompanion.insert(
            id: id,
            number: number,
            type: type,
            clientId: clientId,
            rowid: rowid,
          ),
        ));
}

class $$PhoneTableTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PhoneTableTable> {
  $$PhoneTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ClientTableTableFilterComposer get clientId {
    final $$ClientTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $state.db.clientTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ClientTableTableFilterComposer(ComposerState($state.db,
                $state.db.clientTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PhoneTableTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PhoneTableTable> {
  $$PhoneTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get number => $state.composableBuilder(
      column: $state.table.number,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get type => $state.composableBuilder(
      column: $state.table.type,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ClientTableTableOrderingComposer get clientId {
    final $$ClientTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientId,
        referencedTable: $state.db.clientTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$ClientTableTableOrderingComposer(ComposerState($state.db,
                $state.db.clientTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientTableTableTableManager get clientTable =>
      $$ClientTableTableTableManager(_db, _db.clientTable);
  $$AddressTableTableTableManager get addressTable =>
      $$AddressTableTableTableManager(_db, _db.addressTable);
  $$PhoneTableTableTableManager get phoneTable =>
      $$PhoneTableTableTableManager(_db, _db.phoneTable);
}
