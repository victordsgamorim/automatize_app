import 'package:automatize_app/common_libs.dart';
import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  List<Object?> get props => [title, icon, onTap];
}
