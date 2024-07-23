import 'package:automatize_app/common_libs.dart';

class AutomatizeDivider extends StatelessWidget {
  final double height;
  const AutomatizeDivider({super.key, this.height = 2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: double.maxFinite,
        height: height,
        decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
