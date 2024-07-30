import 'package:automatize_app/common_libs.dart';

class AutomatizeDivider extends StatelessWidget {
  final double height;
  final Color? color;
  final EdgeInsets padding;

  const AutomatizeDivider({
    super.key,
    this.height = 2,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: double.maxFinite,
        height: height,
        decoration: BoxDecoration(
            color: color ?? context.colorScheme.primary,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
