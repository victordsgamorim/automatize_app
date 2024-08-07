import 'package:automatize_app/core/utils/extensions/iterable_extension.dart';
import 'package:equatable/equatable.dart';

enum PhoneType {
  mobile("Telefone Celular", "m"),
  fixed("Telefone Físico", "f"),
  other("Outro", "o");

  final String name;
  final String type;

  int get toInt {
    if (this == PhoneType.mobile) return 0;
    if (this == PhoneType.fixed) return 1;
    return 2;
  }

  const PhoneType(this.name, this.type);
}

class Phone extends Equatable {
  final String? id;
  final String number;
  final PhoneType type;
  final bool isActive;

  const Phone({
    this.id,
    required this.number,
    required this.type,
    this.isActive = true,
  });

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      id: map['id'],
      number: map['number'],
      type: PhoneType.values
              .firstWhereOrNull((type) => type.type == map['type']) ??
          PhoneType.mobile,
      isActive: map['is_active'],
    );
  }

  factory Phone.fromSQL(Map<String, dynamic> map) {
    return Phone(
      id: map['phone_id'],
      number: map['phone_number'],
      isActive: map['phone_active'] == 1,
      type: PhoneType.values
              .firstWhereOrNull((type) => type.type == map['phone_type']) ??
          PhoneType.mobile,
    );
  }

  Map<String, dynamic> toMap(String clientId) {
    return {
      "id": id,
      "number": number,
      "type": type.type,
      "is_active": isActive,
      "client_id": clientId
    };
  }

  Map<String, dynamic> toSQL(String clientId) {
    return {
      "id": id,
      "number": number,
      "type": type.type,
      "client_id": clientId,
      "is_active": isActive ? 1 : 0,
    };
  }

  @override
  List<Object?> get props => [id, number, type, isActive];
}
