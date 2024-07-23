part of 'automatize_textfield.dart';

class AutomatizeTextFieldWithTitle extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? hint;
  final ValueChanged<String>? onChanged;

  const AutomatizeTextFieldWithTitle({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.icon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _CustomFieldWithTitle(
      label: label,
      field: AutomatizeTextField(
        controller: controller,
        focusNode: focusNode,
        icon: icon,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        hint: hint,
        onChanged: onChanged,
      ),
    );
  }
}
