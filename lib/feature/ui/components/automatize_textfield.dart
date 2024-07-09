import 'package:automatize_app/common_libs.dart';

class AutomatizeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final String? label;

  const AutomatizeTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.style,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      style: TextStyle(color: context.colorScheme.onPrimaryContainer),
      onTapOutside: (_) {
        if (focusNode != null) focusNode!.unfocus();
      },
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Icon(Icons.search_rounded),
        ),
        label: label != null
            ? Text(
                label!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
      ),
    );
  }
}
