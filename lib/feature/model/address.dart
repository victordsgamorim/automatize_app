import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String id;
  final String street;
  final String number;
  final String county;
  final String postalCode;
  final String city;
  final String state;

  const Address({
    required this.id,
    required this.street,
    required this.number,
    required this.county,
    required this.postalCode,
    required this.city,
    required this.state,
  });

  factory Address.empty() {
    return const Address(
      id: '',
      street: '',
      number: '',
      county: '',
      postalCode: '',
      city: '',
      state: '',
    );
  }

  Address copyWith({String? street}) {
    return Address(
      id: '',
      street: street ?? this.street,
      number: '',
      county: '',
      postalCode: '',
      city: '',
      state: '',
    );
  }

  @override
  List<Object?> get props =>
      [id, street, number, county, postalCode, city, state];
}
