import 'package:equatable/equatable.dart';

final class RadioItem extends Equatable {
  final String label;

  const RadioItem({required this.label});

  @override
  List<Object?> get props => [label];
}
