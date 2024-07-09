import 'package:automatize_app/common_libs.dart';

class SquaredButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const SquaredButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      elevation: 0,
      child: icon,
    );
  }
}
