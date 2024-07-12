import 'package:automatize_app/common_libs.dart';

class AutomatizeHeader extends StatelessWidget {
  final String label;

  const AutomatizeHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: context.textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w600,
        color: context.colorScheme.primary,
      ),
    );
  }
}
