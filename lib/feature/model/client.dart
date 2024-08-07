import 'package:automatize_app/core/utils/extensions/iterable_extension.dart';
import 'package:automatize_app/feature/model/address.dart';
import 'package:automatize_app/feature/model/phone.dart';
import 'package:equatable/equatable.dart';

enum ClientType {
  personal(name: "Pessoa Física", type: "f"),
  company(name: "Pessoa Jurídica", type: "j");

  final String name;
  final String type;

  int get toInt => this == ClientType.personal ? 0 : 1;

  const ClientType({required this.name, required this.type});
}

class Client extends Equatable {
  final String id;
  final String name;
  final ClientType type;
  final List<Address> addresses;
  final List<Phone> phones;
  final bool isActive;
  final DateTime updatedAt;

  const Client({
    required this.id,
    required this.name,
    required this.type,
    required this.addresses,
    required this.phones,
    this.isActive = true,
    required this.updatedAt,
  });

  factory Client.fromMap(Map<String, dynamic> data) {
    return Client(
        id: data['id'],
        name: data['name'],
        type: ClientType.values
                .firstWhereOrNull((type) => type.type == data['type']) ??
            ClientType.personal,
        addresses: data['addresses']
            .map<Address>((address) => Address.fromMap(address))
            .toList(),
        phones:
            data['phones'].map<Phone>((phone) => Phone.fromMap(phone)).toList(),
        isActive: data['is_active'],
        updatedAt: DateTime.parse(data['updated_at']));
  }

  factory Client.fromSQL(Map<String, dynamic> data) {
    return Client(
        id: data['id'],
        name: data['name'],
        type: ClientType.values
                .firstWhereOrNull((type) => type.type == data['client_type']) ??
            ClientType.personal,
        addresses: const [],
        phones: const [],
        isActive: data['client_active'] == 1,
        updatedAt: DateTime.parse(data['updated_at']));
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "type": type.type,
      "is_active": isActive,
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  Map<String, dynamic> toSQL() {
    return {
      "id": id,
      "name": name,
      "type": type.type,
      "is_active": isActive ? 1 : 0,
      "updated_at": DateTime.now().toIso8601String(),
    };
  }

  Client copyWith({
    List<Address>? addresses,
    List<Phone>? phones,
    DateTime? updatedAt,
  }) {
    return Client(
      id: id,
      name: name,
      type: type,
      addresses: addresses ?? this.addresses,
      phones: phones ?? this.phones,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [id];
}
