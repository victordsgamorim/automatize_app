part of 'client_page.dart';

class AddressFormControllers {
  final Address? address;
  String? id;
  late final TextEditingController streetController = TextEditingController();
  late final TextEditingController numberController = TextEditingController();
  late final TextEditingController areaController = TextEditingController();
  late final TextEditingController postalCodeController =
  TextEditingController();
  late final TextEditingController cityController = TextEditingController();

  late final FocusNode streetNode = FocusNode();
  late final FocusNode numberNode = FocusNode();
  late final FocusNode areaNode = FocusNode();
  late final FocusNode postalCodeNode = FocusNode();
  late final FocusNode cityNode = FocusNode();

  late final MaskTextInputFormatter postalCodeMaskFormatter =
  MaskTextInputFormatter(
    mask: '#####-###',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  StateType state = StateType.pernambuco;

  AddressFormControllers({this.address}) {
    id = address?.id;
    streetController.text = address?.street ?? '';
    numberController.text = address?.number ?? '';
    areaController.text = address?.area ?? '';
    postalCodeController.text =
        postalCodeMaskFormatter.maskText(address?.postalCode ?? '');
    cityController.text = address?.area ?? '';
    state = address?.state ?? state;
  }

  String get postalCode =>
      postalCodeMaskFormatter.unmaskText(postalCodeController.text);

  void dispose() {
    streetController.dispose();
    numberController.dispose();
    areaController.dispose();
    postalCodeController.dispose();
    cityController.dispose();

    streetNode.dispose();
    numberNode.dispose();
    areaNode.dispose();
    postalCodeNode.dispose();
    cityNode.dispose();
  }
}

class AddressControllerManager extends ChangeNotifier {
  final List<AddressFormControllers> _forms;

  AddressControllerManager(this._forms);

  List<AddressFormControllers> get forms => _forms;

  void add(AddressFormControllers controller) {
    _forms.add(controller);
    notifyListeners();
  }

  void removeByIndex(int index) {
    final form = _forms.removeAt(index);
    form.dispose();
    notifyListeners();
  }

  void updateStateByIndex({required int index, required StateType type}) {
    final tempForm = _forms[index];
    tempForm.state = type;
    _forms[index] = tempForm;
  }
}

class _AddressForm extends StatefulWidget {
  final AddressFormControllers controllers;
  final int position;
  final VoidCallback? onDelete;
  final Function(StateType type) onStateChange;
  final bool showDelete;

  const _AddressForm({
    super.key,
    required this.position,
    this.onDelete,
    required this.controllers,
    required this.onStateChange,
    this.showDelete = false,
  });

  @override
  State<_AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<_AddressForm>
    with FormValidator, AutomaticKeepAliveClientMixin {
  late StateType _stateSelected;

  @override
  void initState() {
    _stateSelected = widget.controllers.state;
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AutomatizeTextFieldWithTitle(
                        controller: widget.controllers.streetController,
                        focusNode: widget.controllers.streetNode,
                        label: "Rua #${widget.position}",
                        validator: (value) => onValidate(
                          value: value,
                          message: streetFieldError,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SizedBox(
                        width: 150,
                        child: AutomatizeTextFieldWithTitle(
                          controller: widget.controllers.numberController,
                          focusNode: widget.controllers.numberNode,
                          label: "Número",
                          validator: (value) => onValidate(
                            value: value,
                            message: numberFieldError,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AutomatizeTextFieldWithTitle(
                          controller: widget.controllers.areaController,
                          focusNode: widget.controllers.areaNode,
                          label: "Bairro",
                          validator: (value) => onValidate(
                            value: value,
                            message: areaFieldError,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: SizedBox(
                          width: 150,
                          child: AutomatizeTextFieldWithTitle(
                            controller: widget.controllers.postalCodeController,
                            focusNode: widget.controllers.postalCodeNode,
                            label: "CEP",
                            hint: '12345-678',
                            inputFormatters: [
                              widget.controllers.postalCodeMaskFormatter
                            ],
                            validator: (value) => onValidate(
                                value: value,
                                message: postalCodeFieldError,
                                onRuleValidation: () {
                                  if (widget.controllers.postalCodeController
                                      .text.length <
                                      8) return postalCodeLengthError;
                                  return null;
                                }),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AutomatizeTextFieldWithTitle(
                        controller: widget.controllers.cityController,
                        focusNode: widget.controllers.cityNode,
                        label: "Cidade",
                        validator: (value) => onValidate(
                          value: value,
                          message: cityFieldError,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: SizedBox(
                        width: 300,
                        child: DropdownWithTitle(
                          initValue: _stateSelected,
                          hint: "Selecione um estado",
                          label: 'Estado',
                          items: StateType.values,
                          onChanged: (state) {
                            _stateSelected = state!;
                            widget.onStateChange(state);
                          },
                        ),
                      ),
                    )
                  ],
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
            )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}