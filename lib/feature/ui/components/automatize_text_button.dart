import 'package:automatize_app/common_libs.dart';

class AutomatizeTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Widget? icon;

  const AutomatizeTextButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (icon != null) ...[const SizedBox(width: 8), icon!],
        ],
      ),
    );
  }
}
