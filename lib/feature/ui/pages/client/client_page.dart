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
import 'package:automatize_app/feature/ui/controllers/client/client_bloc.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sliver_tools/sliver_tools.dart';

part 'address_form.dart';

part 'personal_form.dart';

part 'phone_form.dart';

class ClientPage extends StatelessWidget {
  final Client? client;

  const ClientPage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I<ClientBloc>(),
      child: _ClientPage(client: client),
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
  late final GlobalKey<FormState> _formKey = GlobalKey();
  late final ClientBloc _bloc;

  late final PersonalFormControllers _personalFormControllers;
  late final AddressControllerManager _addressController;
  late final PhoneControllerManager _phonesController;

  @override
  void initState() {
    _bloc = context.bloc<ClientBloc>();
    _personalFormControllers = PersonalFormControllers(client: widget.client);
    _addressController = AddressControllerManager(widget.client?.addresses
            .map(
              (address) => AddressFormControllers(address: address),
            )
            .toList() ??
        [AddressFormControllers()]);
    _phonesController = PhoneControllerManager(widget.client?.phones
            .map((phone) => PhoneFormControllers(phone: phone))
            .toList() ??
        [PhoneFormControllers()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Column(
        children: [
          AutomatizeHeaderMenu(
            label: widget.client?.name ?? 'Novo Cliente',
            onDone: () {
              final isValid = _formKey.currentState?.validate();
              if (!isValid!) return;
              _bloc.add(CreateClientEvent(_createClient()));
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
                      key: const Key("personalForm"),
                      controllers: _personalFormControllers,
                    ),
                  ),
                  _listenableAddressForm(),
                  _listenablePhoneForm(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Client _createClient() {
    return Client(
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
    );
  }

  ListenableBuilder _listenableAddressForm() {
    return ListenableBuilder(
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
                    _addressController.add(AddressFormControllers());
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  addAutomaticKeepAlives: true,
                  (_, index) {
                    return _AddressForm(
                      key: UniqueKey(),
                      showDelete: isGreater,
                      controllers: controllers[index],
                      position: index + 1,
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
    );
  }

  ListenableBuilder _listenablePhoneForm() {
    return ListenableBuilder(
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
    );
  }

  @override
  void dispose() {
    _bloc.close();
    _addressController.dispose();
    _phonesController.dispose();
    super.dispose();
  }
}

class _SliverTitlePinned extends SliverPersistentHeaderDelegate {
  final String title;
  final IconData icon;
  final VoidCallback onPlusTap;
  final bool showPlusButton;

  _SliverTitlePinned({
    required this.title,
    required this.icon,
    required this.onPlusTap,
    this.showPlusButton = true,
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
              if (showPlusButton)
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
