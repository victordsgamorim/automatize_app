part of 'automatize_textfield.dart';

class AutomatizeTextFieldWithTitle extends StatelessWidget {
  final String? label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final String? initValue;

  const AutomatizeTextFieldWithTitle({
    super.key,
    this.label,
    this.controller,
    this.focusNode,
    this.icon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.hint,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.initValue,
  });

  @override
  Widget build(BuildContext context) {
    return _CustomFieldWithTitle(
      label: label ?? '',
      field: AutomatizeTextField(
        initValue: initValue,
        controller: controller,
        focusNode: focusNode,
        icon: icon,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        hint: hint,
        onChanged: onChanged,
        validator: validator,
        readOnly: readOnly,
      ),
    );
  }
}
