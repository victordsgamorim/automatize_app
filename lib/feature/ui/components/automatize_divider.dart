import 'package:automatize_app/common_libs.dart';

class AutomatizeDivider extends StatelessWidget {
  const AutomatizeDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        width: double.maxFinite,
        height: 2,
        decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
