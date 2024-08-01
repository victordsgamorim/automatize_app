mixin FormValidator {
  String? onValidate(
      {String? value, String? message, String? Function()? onRuleValidation}) {
    if (value == null || value.isEmpty) {
      return message ?? "Preencha o campo corretamente.";
    }

    return onRuleValidation?.call();
  }
}
