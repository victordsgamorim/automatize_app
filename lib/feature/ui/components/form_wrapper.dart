import 'package:automatize_app/common_libs.dart';

class FormWrapper extends StatelessWidget {
  final Widget child;

  const FormWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: context.colorScheme.primary)),
      child: child,
    );
  }
}