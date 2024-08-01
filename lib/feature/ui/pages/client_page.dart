import 'dart:ui';

import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/constaints/messages.dart';
import 'package:automatize_app/core/utils/extensions/int_extension.dart';
import 'package:automatize_app/core/utils/mixin/form_validator.dart';
import 'package:automatize_app/feature/model/address.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/model/phone.dart';
import 'package:automatize_app/feature/ui/components/automatize_header_menu.dart';
import 'package:automatize_app/feature/ui/components/form_wrapper.dart';
import 'package:automatize_app/feature/ui/components/radio_button/multiple_radio_option.dart';
import 'package:automatize_app/feature/ui/components/radio_button/radio_item.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/controllers/client/client_cubit.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<ClientCubit>(),
      child: const _ClientPage(),
    );
  }
}

class _ClientPage extends StatefulWidget {
  final Client? client;

  const _ClientPage({super.key, this.client});

  @override
  State<_ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<_ClientPage> {
  late final ClientCubit _clientCubit;
  late final GlobalKey<FormState> _formKey = GlobalKey();

  late final PersonalFormControllers _personalFormControllers;
  late final AddressControllerManager _addressController;
  late final PhoneControllerManager _phonesController;

  @override
  void initState() {
    _clientCubit = context.bloc<ClientCubit>();
    _personalFormControllers = PersonalFormControllers();
    _addressController = AddressControllerManager([AddressFormControllers()]);
    _phonesController = PhoneControllerManager([PhoneFormControllers()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Column(
        children: [
          AutomatizeHeaderMenu(
            label: 'Novo Cliente',
            onDone: () {
              final isValid = _formKey.currentState?.validate();
              if (!isValid!) return;
              _clientCubit.insert(Client(
                id: _personalFormControllers.id,
                name: _personalFormControllers.nameController.text,
                type: _personalFormControllers.type,
                addresses: _addressController.forms
                    .map<Address>(
                      (address) => Address(
                        street: address.streetController.text,
                        number: address.numberController.text,
                        postalCode: address.postalCode,
                        city: address.cityController.text,
                        area: address.areaController.text,
                        state: address.state,
                      ),
                    )
                    .toList(),
                phones: _phonesController.forms
                    .map((phone) => Phone(
                          number: phone.phoneNumber,
                          type: phone.type,
                        ))
                    .toList(),
              ));
              // context.pop();
            },
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: _PersonalForm(
                        key: UniqueKey(),
                        controllers: _personalFormControllers),
                  ),
                  ListenableBuilder(
                    listenable: _addressController,
                    builder: (_, __) {
                      final controllers = _addressController.forms;
                      final bool isGreater = controllers.length > 1;
                      return SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        sliver: MultiSliver(
                          pushPinnedChildren: true,
                          children: [
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: _SliverTitlePinned(
                                title: 'Endereço',
                                icon: Icons.location_on_outlined,
                                onPlusTap: () {
                                  _addressController
                                      .add(AddressFormControllers());
                                },
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                addAutomaticKeepAlives: true,
                                (_, index) {
                                  return _AddressForm(
                                    key: UniqueKey(),
                                    controllers: controllers[index],
                                    position: index + 1,
                                    showDelete: isGreater,
                                    onDelete: () {
                                      if (!isGreater) return;
                                      _addressController.removeByIndex(index);
                                    },
                                    onStateChange: (state) {
                                      _addressController.updateStateByIndex(
                                        index: index,
                                        type: state,
                                      );
                                    },
                                  );
                                },
                                childCount: controllers.length,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  ListenableBuilder(
                    listenable: _phonesController,
                    builder: (context, child) {
                      final controllers = _phonesController.forms;
                      final bool isGreater = controllers.length > 1;
                      return SliverPadding(
                        padding: const EdgeInsets.only(bottom: 120.0),
                        sliver: MultiSliver(
                          pushPinnedChildren: true,
                          children: [
                            SliverPersistentHeader(
                              pinned: true,
                              delegate: _SliverTitlePinned(
                                title: 'Telefone',
                                icon: Icons.phone_outlined,
                                onPlusTap: () {
                                  _phonesController.add(PhoneFormControllers());
                                },
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                addAutomaticKeepAlives: true,
                                (_, index) {
                                  final phones = _phonesController.forms;
                                  final controller = phones[index];
                                  return _PhoneForm(
                                    key: UniqueKey(),
                                    controllers: controller,
                                    showDelete: isGreater,
                                    onDelete: () {
                                      if (!isGreater) return;
                                      _phonesController.removeByIndex(index);
                                    },
                                    onChanged: (PhoneType phone) {
                                      _phonesController.updateTypeByIndex(
                                          index: index, type: phone);
                                    },
                                  );
                                },
                                childCount: _phonesController.forms.length,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _clientCubit.close();
    _addressController.dispose();
    _phonesController.dispose();
    super.dispose();
  }
}

///INFO
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

  const _PersonalForm({super.key, required this.controllers});

  @override
  State<_PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<_PersonalForm> with FormValidator {
  late int _personType;

  @override
  void initState() {
    _personType = widget.controllers.type.toInt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
}

///ADDRESS
class AddressFormControllers {
  final Address? address;
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
  final bool showDelete;
  final VoidCallback? onDelete;
  final Function(StateType type) onStateChange;

  const _AddressForm({
    super.key,
    required this.position,
    this.showDelete = false,
    this.onDelete,
    required this.controllers,
    required this.onStateChange,
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
            ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

///PHONE
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

class _SliverTitlePinned extends SliverPersistentHeaderDelegate {
  final String title;
  final IconData icon;
  final VoidCallback onPlusTap;

  _SliverTitlePinned({
    required this.title,
    required this.icon,
    required this.onPlusTap,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final isShrinked = shrinkOffset > 0;
    return Stack(
      children: [
        if (isShrinked)
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                height: 80,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.5),
                ),
              ),
            ),
          ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: context.colorScheme.primary),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      title,
                      style: context.textTheme.titleLarge?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: onPlusTap,
                label: const Icon(Icons.add_circle),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 35;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;
}
