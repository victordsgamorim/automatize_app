part of 'client_page.dart';

class PhoneFormControllers {
  final Phone? phone;
  late final TextEditingController phoneController = TextEditingController();
  late final TextEditingController fixedController = TextEditingController();
  late final TextEditingController otherController = TextEditingController();
  late final FocusNode phoneNode = FocusNode();
  late final FocusNode fixedNode = FocusNode();
  late final FocusNode otherNode = FocusNode();

  final fixedMaskFormatter = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final mobileMaskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  PhoneType type = PhoneType.mobile;

  PhoneFormControllers({this.phone}) {
    type = phone?.type ?? type;
    _initText();
  }

  void _initText() {
    if (type == PhoneType.mobile) {
      phoneController.text = mobileMaskFormatter.maskText(phone?.number ?? '');
      return;
    }
    if (type == PhoneType.fixed) {
      fixedController.text = fixedMaskFormatter.maskText(phone?.number ?? '');
      return;
    }

    otherController.text = phone?.number ?? '';
  }

  String get unmaskedMobile =>
      mobileMaskFormatter.unmaskText(phoneController.text);

  String get unmaskedFixed =>
      fixedMaskFormatter.unmaskText(fixedController.text);

  String get phoneNumber {
    if (type == PhoneType.mobile) {
      return mobileMaskFormatter.unmaskText(phoneController.text);
    }
    if (type == PhoneType.fixed) {
      return fixedMaskFormatter.unmaskText(fixedController.text);
    }
    return otherController.text;
  }

  dispose() {
    phoneController.dispose();
    fixedController.dispose();
    otherController.dispose();
    phoneNode.dispose();
    fixedNode.dispose();
    otherNode.dispose();
  }
}

class PhoneControllerManager extends ChangeNotifier {
  final List<PhoneFormControllers> _forms;

  PhoneControllerManager(this._forms);

  List<PhoneFormControllers> get forms => _forms;

  void add(PhoneFormControllers controller) {
    _forms.add(controller);
    notifyListeners();
  }

  void removeByIndex(int index) {
    final form = _forms.removeAt(index);
    form.dispose();
    notifyListeners();
  }

  void updateTypeByIndex({required int index, required PhoneType type}) {
    final tempForm = _forms[index];
    tempForm.type = type;
    _forms[index] = tempForm;
  }
}

class _PhoneForm extends StatefulWidget {
  final PhoneFormControllers controllers;
  final bool showDelete;
  final VoidCallback onDelete;
  final Function(PhoneType phone) onChanged;

  const _PhoneForm({
    super.key,
    required this.controllers,
    required this.showDelete,
    required this.onDelete,
    required this.onChanged,
  });

  @override
  State<_PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<_PhoneForm>
    with FormValidator, AutomaticKeepAliveClientMixin {
  int _phoneType = 0;

  @override
  void initState() {
    _phoneType = widget.controllers.type.toInt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: Stack(
        children: [
          FormWrapper(
            child: Column(
              children: [
                _phoneForm,
                MultipleRadioOption(
                  value: _phoneType,
                  items: PhoneType.values
                      .map((type) => RadioItem(label: type.name))
                      .toList(),
                  onChanged: (int value) {
                    setState(() {
                      _phoneType = value;
                      widget.onChanged(value.toPhoneType);
                    });
                  },
                )
              ],
            ),
          ),
          if (widget.showDelete)
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                color: Colors.red,
                onPressed: widget.onDelete,
                icon: const Icon(Icons.close_rounded, color: Colors.redAccent),
              ),
            ),
        ],
      ),
    );
  }

  Widget get _phoneForm {
    if (_phoneType == 0) {
      return AutomatizeTextFieldWithTitle(
        key: const Key("phoneField"),
        controller: widget.controllers.phoneController,
        focusNode: widget.controllers.phoneNode,
        label: "Celular",
        hint: "(00) 90000-0000",
        icon: Icons.phone_android,
        inputFormatters: [widget.controllers.mobileMaskFormatter],
        validator: (value) => onValidate(
            value: value,
            message: phoneFieldError,
            onRuleValidation: () {
              if (widget.controllers.unmaskedMobile.length < 11) {
                return phoneLengthError;
              }
              return null;
            }),
      );
    }

    if (_phoneType == 1) {
      return AutomatizeTextFieldWithTitle(
        key: const Key("fixedField"),
        controller: widget.controllers.fixedController,
        focusNode: widget.controllers.fixedNode,
        label: "Físico",
        hint: "(00) 0000-0000",
        icon: Icons.phone,
        inputFormatters: [widget.controllers.fixedMaskFormatter],
        validator: (value) => onValidate(
            value: value,
            message: fixedFieldError,
            onRuleValidation: () {
              if (widget.controllers.unmaskedFixed.length < 10) {
                return fixedLengthError;
              }
              return null;
            }),
      );
    }
    return AutomatizeTextFieldWithTitle(
        key: const Key("otherField"),
        controller: widget.controllers.otherController,
        focusNode: widget.controllers.otherNode,
        hint: "+551212345678",
        label: "Outro",
        icon: Icons.phone,
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            if (newValue.text.isEmpty) {
              return newValue;
            } else if (newValue.text == '+') {
              return TextEditingValue(text: newValue.text);
            } else if (RegExp(r'^[+]?[0-9]*$').hasMatch(newValue.text)) {
              return newValue;
            }
            return oldValue;
          })
        ],
        validator: (value) => onValidate(
              value: value,
              message: fixedFieldError,
            ));
  }

  @override
  bool get wantKeepAlive => true;
}
