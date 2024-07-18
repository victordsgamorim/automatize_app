import 'package:automatize_app/common_libs.dart';

const double _btnElevation = 0;

class AutomatizeButton extends StatelessWidget {
  final Widget child;

  const AutomatizeButton({
    super.key,
    required this.child,
  });

  factory AutomatizeButton.square({
    Key? key,
    required VoidCallback onPressed,
    required Widget icon,
    Color? color,
  }) {
    return AutomatizeButton(
      child: FloatingActionButton(
        onPressed: onPressed,
        elevation: _btnElevation,
        hoverElevation: _btnElevation,
        backgroundColor: color,
        child: icon,
      ),
    );
  }

  factory AutomatizeButton.rectangle({
    Key? key,
    required VoidCallback onPressed,
    Widget? icon,
    required Widget label,
    Color? color,
  }) {
    return AutomatizeButton(
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        elevation: _btnElevation,
        hoverElevation: _btnElevation,
        icon: icon,
        label: label,
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => child;
}
