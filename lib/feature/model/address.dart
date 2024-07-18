import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';

@Freezed()
class Address with _$Address {
  const factory Address({
    required String id,
    required String street,
    required String number,
    required String county,
    required String cep,
    required String city,
    required String state,
  }) = _Address;
}
