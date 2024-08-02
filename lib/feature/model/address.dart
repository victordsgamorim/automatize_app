import 'package:automatize_app/core/database/app_database.dart';
import 'package:automatize_app/core/utils/extensions/iterable_extension.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

enum StateType {
  acre(name: "Acre", stateAbbreviation: "ac"),
  alagoas(name: "Alagoas", stateAbbreviation: "al"),
  amapa(name: "Amapá", stateAbbreviation: "ap"),
  amazonas(name: "Amazonas", stateAbbreviation: "am"),
  bahia(name: "Bahia", stateAbbreviation: "ba"),
  ceara(name: "Ceará", stateAbbreviation: "ce"),
  distritoFederal(name: "Distrito Federal", stateAbbreviation: "df"),
  espiritoSanto(name: "Espírito Santo", stateAbbreviation: "es"),
  goias(name: "Goiás", stateAbbreviation: "go"),
  maranhao(name: "Maranhão", stateAbbreviation: "ma"),
  matoGrosso(name: "Mato Grosso", stateAbbreviation: "mt"),
  matoGrossoSul(name: "Mato Grosso do Sul", stateAbbreviation: "ms"),
  minasGerais(name: "Minas Gerais", stateAbbreviation: "mg"),
  para(name: "Pará", stateAbbreviation: "pa"),
  paraiba(name: "Paraíba", stateAbbreviation: "pb"),
  parana(name: "Paraná", stateAbbreviation: "pr"),
  pernambuco(name: "Pernambuco", stateAbbreviation: "pe"),
  piaui(name: "Piauí", stateAbbreviation: "pi"),
  rioJaneiro(name: "Rio de Janeiro", stateAbbreviation: "rj"),
  rioGrandeNorte(name: "Rio Grande do Norte", stateAbbreviation: "rn"),
  rioGrandeSul(name: "Rio Grande do Sul", stateAbbreviation: "rs"),
  rondonia(name: "Rondônia", stateAbbreviation: "ro"),
  roraima(name: "Roraima", stateAbbreviation: "rr"),
  santaCatarina(name: "Santa Catarina", stateAbbreviation: "sc"),
  saoPaulo(name: "São Paulo", stateAbbreviation: "sp"),
  sergipe(name: "Sergipe", stateAbbreviation: "se"),
  tocantins(name: "Tocantins", stateAbbreviation: "to");

  final String name;
  final String stateAbbreviation;

  const StateType({required this.name, required this.stateAbbreviation});
}

class Address extends Equatable {
  final String? id;
  final String street;
  final String number;
  final String area;
  final String postalCode;
  final String city;
  final StateType state;

  const Address({
    this.id,
    required this.street,
    required this.number,
    required this.postalCode,
    required this.city,
    required this.area,
    required this.state,
  });

  factory Address.fromTable(AddressTableData table) {
    return Address(
      id: table.id,
      street: table.street,
      number: table.number,
      postalCode: table.postalCode,
      city: table.city,
      area: table.area,
      state: StateType.values.firstWhereOrNull(
              (type) => type.stateAbbreviation == table.state) ??
          StateType.pernambuco,
    );
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'],
      street: map['street'],
      number: map['number'],
      postalCode: map['postal_code'],
      city: map['city'],
      area: map['area'],
      state: StateType.values.firstWhereOrNull(
              (type) => type.stateAbbreviation == map['state']) ??
          StateType.pernambuco,
    );
  }

  String get toSingleLine =>
      '$street - n°: $number - $area - $city - ${state.name} - $postalCode';

  AddressTableCompanion toTable(String clientId) {
    return AddressTableCompanion(
      id: Value(id!),
      street: Value(street),
      number: Value(number),
      city: Value(city),
      postalCode: Value(postalCode),
      area: Value(area),
      state: Value(state.stateAbbreviation),
      clientId: Value(clientId),
    );
  }

  Map<String, dynamic> toMap(String clientId) {
    return {
      "street": street,
      "number": number,
      "area": area,
      "city": city,
      "state": state.stateAbbreviation,
      "postal_code": postalCode,
      "client_id": clientId,
    };
  }

  @override
  List<Object?> get props => [
        id,
        street,
        number,
        area,
        postalCode,
        city,
        state,
      ];
}
