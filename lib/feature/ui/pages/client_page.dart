import 'dart:ui';

import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_header_menu.dart';
import 'package:automatize_app/feature/ui/components/form_wrapper.dart';
import 'package:automatize_app/feature/ui/components/radio_button/multiple_radio_option.dart';
import 'package:automatize_app/feature/ui/components/radio_button/radio_item.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  late final ValueNotifier<int> _addressCount;
  late final ValueNotifier<int> _phoneCount;

  @override
  void initState() {
    _addressCount = ValueNotifier(1);
    _phoneCount = ValueNotifier(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Column(
        children: [
          const AutomatizeHeaderMenu(label: 'Novo Cliente'),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: _PersonalForm()),
                ValueListenableBuilder(
                  valueListenable: _addressCount,
                  builder: (context, count, child) {
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
                              minusVisibility: count > 1,
                              onMinusTap: () {
                                _addressCount.value = _addressCount.value - 1;
                              },
                              onPlusTap: () {
                                _addressCount.value = _addressCount.value + 1;
                              },
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return _AddressForm(position: index + 1);
                              },
                              childCount: count,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: _phoneCount,
                  builder: (context, count, child) {
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
                              minusVisibility: count > 1,
                              onMinusTap: () {
                                _phoneCount.value = _phoneCount.value - 1;
                              },
                              onPlusTap: () {
                                _phoneCount.value = _phoneCount.value + 1;
                              },
                            ),
                          ),
                          SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return const _PhoneForm();
                            }, childCount: count),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _addressCount.dispose();
    _phoneCount.dispose();
    super.dispose();
  }
}

class _PersonalForm extends StatefulWidget {
  const _PersonalForm({super.key});

  @override
  State<_PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<_PersonalForm> {
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _cpfController = TextEditingController();
  late final TextEditingController _cnpjController = TextEditingController();
  late final FocusNode _nameNode = FocusNode();
  late final FocusNode _cpfNode = FocusNode();
  late final FocusNode _cnpjNode = FocusNode();

  final _cpfMaskFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final _cnpjMaskFormatter = MaskTextInputFormatter(
      mask: '##.###.###/0001-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  int personType = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: AutomatizeTextFieldWithTitle(
                key: const Key("nameField"),
                controller: _nameController,
                focusNode: _nameNode,
                label: "Nome",
                icon: Icons.person_outline_rounded,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: personType == 0
                  ? AutomatizeTextFieldWithTitle(
                      key: const Key("cpfField"),
                      controller: _cpfController,
                      focusNode: _cpfNode,
                      label: "CPF",
                      hint: "000.0000.000-00",
                      icon: FontAwesomeIcons.idBadge,
                      inputFormatters: [_cpfMaskFormatter],
                    )
                  : AutomatizeTextFieldWithTitle(
                      key: const Key("cpnjField"),
                      controller: _cnpjController,
                      focusNode: _cnpjNode,
                      label: "CNPJ",
                      hint: "00.0000.000/0001-00",
                      icon: FontAwesomeIcons.addressCard,
                      inputFormatters: [_cnpjMaskFormatter],
                    ),
            ),
          ],
        ),
        MultipleRadioOption(
          value: personType,
          items: const [
            RadioItem(label: "Pessoa Física"),
            RadioItem(label: "Pessoa Jurídica"),
          ],
          onChanged: (int value) {
            setState(() {
              personType = value;
            });
          },
        )
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cpfController.dispose();
    _cnpjController.dispose();

    _nameNode.dispose();
    _cpfNode.dispose();
    _cnpjNode.dispose();
    super.dispose();
  }
}

class _AddressForm extends StatefulWidget {
  final int position;

  const _AddressForm({
    super.key,
    required this.position,
  });

  @override
  State<_AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<_AddressForm> {
  late final TextEditingController streetController = TextEditingController();
  late final TextEditingController numberController = TextEditingController();
  late final TextEditingController countyController = TextEditingController();
  late final TextEditingController postalCodeController =
      TextEditingController();
  late final TextEditingController cityController = TextEditingController();
  late final TextEditingController stateController = TextEditingController();

  late final FocusNode streetNode = FocusNode();
  late final FocusNode numberNode = FocusNode();
  late final FocusNode countyNode = FocusNode();
  late final FocusNode postalCodeNode = FocusNode();
  late final FocusNode cityNode = FocusNode();
  late final FocusNode stateNode = FocusNode();

  final _cepMaskFormatter = MaskTextInputFormatter(
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final List<String> statesList = [
    "Acre",
    "Alagoas",
    "Amapá",
    "Amazonas",
    "Bahia",
    "Ceará",
    "Distrito Federal",
    "Espírito Santo",
    "Goiás",
    "Maranhão",
    "Mato Grosso",
    "Mato Grosso do Sul",
    "Minas Gerais",
    "Pará",
    "Paraíba",
    "Paraná",
    "Pernambuco",
    "Piauí",
    "Rio de Janeiro",
    "Rio Grande do Norte",
    "Rio Grande do Sul",
    "Rondônia",
    "Roraima",
    "Santa Catarina",
    "São Paulo",
    "Sergipe",
    "Tocantins"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: FormWrapper(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AutomatizeTextFieldWithTitle(
                    controller: streetController,
                    focusNode: streetNode,
                    label: "Rua #${widget.position}",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    width: 150,
                    child: AutomatizeTextFieldWithTitle(
                      controller: numberController,
                      focusNode: numberNode,
                      label: "Número",
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: AutomatizeTextFieldWithTitle(
                      controller: countyController,
                      focusNode: countyNode,
                      label: "Bairro",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: SizedBox(
                      width: 150,
                      child: AutomatizeTextFieldWithTitle(
                        controller: postalCodeController,
                        focusNode: postalCodeNode,
                        label: "CEP",
                        hint: '12345-678',
                        inputFormatters: [_cepMaskFormatter],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AutomatizeTextFieldWithTitle(
                    controller: cityController,
                    focusNode: cityNode,
                    label: "Cidade",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    width: 300,
                    child: DropdownWithTitle(
                      hint: "Selecione um estado",
                      label: 'Estado',
                      items: statesList,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    streetController.dispose();
    numberController.dispose();
    countyController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    stateController.dispose();

    streetNode.dispose();
    numberNode.dispose();
    countyNode.dispose();
    postalCodeNode.dispose();
    cityNode.dispose();
    stateNode.dispose();
    super.dispose();
  }
}

class _PhoneForm extends StatefulWidget {
  const _PhoneForm({super.key});

  @override
  State<_PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<_PhoneForm> {
  late final TextEditingController _phoneController = TextEditingController();
  late final TextEditingController _fixedController = TextEditingController();
  late final TextEditingController _otherController = TextEditingController();
  late final FocusNode _phoneNode = FocusNode();
  late final FocusNode _fixedNode = FocusNode();
  late final FocusNode _otherNode = FocusNode();

  int phoneType = 0;

  final _fixedMaskFormatter = MaskTextInputFormatter(
      mask: '(##) ####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final _mobileMaskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final _otherMaskFormatter = MaskTextInputFormatter(
      filter: {"": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4),
      child: FormWrapper(
        child: Column(
          children: [
            _phoneForm,
            MultipleRadioOption(
              value: phoneType,
              items: const [
                RadioItem(label: "Telefone Celular"),
                RadioItem(label: "Telefone Físico"),
                RadioItem(label: "Outro"),
              ],
              onChanged: (int value) {
                setState(() {
                  phoneType = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget get _phoneForm {
    if (phoneType == 0) {
      return AutomatizeTextFieldWithTitle(
        key: const Key("phoneField"),
        controller: _phoneController,
        focusNode: _phoneNode,
        label: "Celular",
        hint: "(00) 90000-0000",
        icon: Icons.phone_android,
        inputFormatters: [_mobileMaskFormatter],
      );
    }

    if (phoneType == 1) {
      return AutomatizeTextFieldWithTitle(
        key: const Key("fixedField"),
        controller: _fixedController,
        focusNode: _fixedNode,
        label: "Físico",
        hint: "(00) 0000-0000",
        icon: Icons.phone,
        inputFormatters: [_fixedMaskFormatter],
      );
    }
    return AutomatizeTextFieldWithTitle(
      key: const Key("otherField"),
      controller: _otherController,
      focusNode: _otherNode,
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
    );
  }

  @override
  void dispose() {
    _fixedController.dispose();
    _phoneController.dispose();
    _phoneNode.dispose();
    _fixedNode.dispose();
    super.dispose();
  }
}

class _SliverTitlePinned extends SliverPersistentHeaderDelegate {
  final String title;
  final IconData icon;
  final VoidCallback onPlusTap;
  final VoidCallback onMinusTap;
  final bool minusVisibility;

  _SliverTitlePinned({
    required this.title,
    required this.icon,
    required this.onPlusTap,
    required this.onMinusTap,
    this.minusVisibility = false,
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
              Row(
                children: [
                  AbsorbPointer(
                    absorbing: !minusVisibility,
                    child: Opacity(
                      opacity: minusVisibility ? 1 : 0.5,
                      child: TextButton.icon(
                        onPressed: onMinusTap,
                        label: const Icon(Icons.remove_circle),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onPlusTap,
                    label: const Icon(Icons.add_circle),
                  )
                ],
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
