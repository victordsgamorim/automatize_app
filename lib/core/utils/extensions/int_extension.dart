import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/model/phone.dart';

extension IntExtension on int {
  ClientType get toClientType =>
      this == 0 ? ClientType.personal : ClientType.company;

  PhoneType get toPhoneType {
    if (this == 0) return PhoneType.mobile;
    if (this == 1) return PhoneType.fixed;
    return PhoneType.other;
  }
}
