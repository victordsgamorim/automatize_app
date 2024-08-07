import 'package:automatize_app/common_libs.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';

part 'text_field_with_title.dart';

part 'dropdown_with_title.dart';

part 'custom_field_with_title.dart';

class AutomatizeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextStyle? style;
  final String? label;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final ValueChanged<String>? onChanged;

  const AutomatizeTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.style,
    this.label,
    this.icon,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: TextStyle(color: context.colorScheme.onPrimaryContainer),
      onTapOutside: (_) {
        if (focusNode != null) focusNode!.unfocus();
      },
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: icon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Icon(icon!),
              )
            : null,
        label: label != null
            ? Text(
                label!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        hintText: hint,
      ),
    );
  }
}
