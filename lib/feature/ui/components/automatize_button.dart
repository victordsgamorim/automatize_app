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
  }) {
    return AutomatizeButton(
      child: FloatingActionButton(
        onPressed: onPressed,
        elevation: _btnElevation,
        hoverElevation: _btnElevation,
        child: icon,
      ),
    );
  }

  factory AutomatizeButton.rectangle({
    Key? key,
    required VoidCallback onPressed,
    Widget? icon,
    required Widget label
  }) {
    return AutomatizeButton(
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        elevation: _btnElevation,
        hoverElevation: _btnElevation,
        icon: icon,
        label: label,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => child;
}
