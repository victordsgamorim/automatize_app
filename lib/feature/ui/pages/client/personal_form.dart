part of 'client_page.dart';

class PersonalFormControllers {
  final Client? client;
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController cpfController = TextEditingController();
  late final TextEditingController cnpjController = TextEditingController();

  late final FocusNode nameNode = FocusNode();
  late final FocusNode cpfNode = FocusNode();
  late final FocusNode cnpjNode = FocusNode();

  final cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  final cnpjMaskFormatter = MaskTextInputFormatter(
      mask: '##.###.###/0001-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  ClientType type = ClientType.personal;

  PersonalFormControllers({this.client}) {
    type = client?.type ?? type;
    nameController.text = client?.name ?? '';
    type == ClientType.personal
        ? cpfController.text = cpfMaskFormatter.maskText(client?.id ?? '')
        : cnpjController.text = _maskCPNJ(client?.id ?? '');
  }

  String get id => type == ClientType.personal ? unmaskCPF : unmaskedCPNJ;

  String get unmaskCPF => cpfMaskFormatter.unmaskText(cpfController.text);

  String get unmaskedCPNJ =>
      cnpjController.text.replaceAll(RegExp(r'[./-]'), '');

  String _maskCPNJ(String value) {
    if (value.isEmpty) return "";
    return MaskTextInputFormatter(
            mask: '##.###.###/####-##',
            filter: {"#": RegExp(r'[0-9]')},
            type: MaskAutoCompletionType.lazy)
        .maskText(value);
  }

  void dispose() {
    nameController.dispose();
    cpfController.dispose();
    cnpjController.dispose();

    nameNode.dispose();
    cpfNode.dispose();
    cnpjNode.dispose();
  }
}

class _PersonalForm extends StatefulWidget {
  final PersonalFormControllers controllers;

  const _PersonalForm({
    super.key,
    required this.controllers,
  });

  @override
  State<_PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<_PersonalForm>
    with FormValidator, AutomaticKeepAliveClientMixin {
  late int _personType;

  @override
  void initState() {
    _personType = widget.controllers.type.toInt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isMobile(context)) ...[
          _nameField,
          const SizedBox(height: 4),
          _idField,
          const SizedBox(height: 4),
        ] else
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _nameField),
              const SizedBox(width: 16),
              Flexible(child: _idField),
            ],
          ),
        MultipleRadioOption(
          value: _personType,
          items: ClientType.values
              .map((type) => RadioItem(label: type.name))
              .toList(),
          onChanged: (int value) {
            setState(() {
              _personType = value;
              widget.controllers.type = value.toClientType;
            });
          },
        )
      ],
    );
  }

  Widget get _nameField => AutomatizeTextFieldWithTitle(
        key: const Key("nameField"),
        controller: widget.controllers.nameController,
        focusNode: widget.controllers.nameNode,
        label: "Nome",
        icon: Icons.person_outline_rounded,
        validator: (value) => onValidate(value: value, message: nameFieldError),
      );

  Widget get _idField {
    return _personType == 0
        ? AutomatizeTextFieldWithTitle(
            key: const Key("cpfField"),
            controller: widget.controllers.cpfController,
            focusNode: widget.controllers.cpfNode,
            label: "CPF",
            hint: "000.000.000-00",
            icon: FontAwesomeIcons.idBadge,
            inputFormatters: [widget.controllers.cpfMaskFormatter],
            validator: (value) => onValidate(
              value: value,
              message: cpfFieldError,
              onRuleValidation: () {
                final cpf = widget.controllers.unmaskCPF;
                if (cpf.length < 11) return cpfLengthError;
                return null;
              },
            ),
          )
        : AutomatizeTextFieldWithTitle(
            key: const Key("cpnjField"),
            controller: widget.controllers.cnpjController,
            focusNode: widget.controllers.cnpjNode,
            label: "CNPJ",
            hint: "00.0000.000/0001-00",
            icon: FontAwesomeIcons.addressCard,
            inputFormatters: [widget.controllers.cnpjMaskFormatter],
            validator: (value) => onValidate(
              value: value,
              message: cnpjFieldError,
              onRuleValidation: () {
                final cnpj = widget.controllers.unmaskedCPNJ;
                if (cnpj.length < 14) return cnpjLengthError;
                return null;
              },
            ),
          );
  }

  @override
  void dispose() {
    widget.controllers.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
