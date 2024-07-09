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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextButton.icon(
        onPressed: () {},
        label: Text(label),
        icon: icon,
      ),
    );
  }
}
