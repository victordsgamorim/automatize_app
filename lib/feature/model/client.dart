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

  const Client({
    required this.id,
    required this.name,
    required this.type,
    required this.addresses,
    required this.phones,
  });

  factory Client.empty() {
    return const Client(
      id: '',
      name: '',
      type: ClientType.personal,
      addresses: [],
      phones: [],
    );
  }

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
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "type": type.type
    };
  }

  @override
  List<Object?> get props => [id, name, type, addresses, phones];
}
