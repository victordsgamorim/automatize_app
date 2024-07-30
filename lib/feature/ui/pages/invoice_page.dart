import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/datetime_extension.dart';
import 'package:automatize_app/core/utils/extensions/double_extension.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_divider.dart';
import 'package:automatize_app/feature/ui/components/automatize_header_menu.dart';
import 'package:automatize_app/feature/ui/components/editable_textfield_with_title.dart';
import 'package:automatize_app/feature/ui/components/form_wrapper.dart';
import 'package:automatize_app/feature/ui/components/toggle_header.dart';
import 'package:automatize_app/feature/ui/pages/clients_page.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    const priceHeader = _PriceInvoiceHeader(value: 10.20);

    return Column(
      children: [
        const AutomatizeHeaderMenu(
          leading: priceHeader,
          label: 'Criar OS',
        ),
        if (!isMobile(context)) priceHeader,
        const Expanded(
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(child: _ClientForm()),
              SliverToBoxAdapter(child: _WarrantyDate()),
              SliverToBoxAdapter(child: _TechnicalList()),
            ],
          ),
        )
      ],
    );
  }
}

class _PriceInvoiceHeader extends StatelessWidget {
  final double value;

  const _PriceInvoiceHeader({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutomatizeDivider(
              color: !isMobile(context) ? Colors.transparent : null,
              padding: EdgeInsets.zero),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              Text(
                value.toReal,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
            ],
          ),
          const AutomatizeDivider(padding: EdgeInsets.zero)
        ],
      ),
    );
  }
}

class _ClientForm extends StatefulWidget {
  const _ClientForm({super.key});

  @override
  State<_ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<_ClientForm> {
  bool _clientAdded = false;

  List<String> titles = [
    "Nome",
    "Categoria",
    "Endereço",
    "Informação",
    "Telefone",
  ];
  List<TextEditingController> controllers =
      List.generate(5, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return ToggleHeader(
      title: "Cliente",
      toggle: _clientAdded,
      onPressed: _onAddClient,
      child: FormWrapper(
          child: AlignedGridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 4,
        itemCount: 5,
        itemBuilder: (context, index) {
          return EditableTextFieldWithTitle(
            title: titles[index],
            controller: controllers[index],
          );
        },
      )),
    );
  }

  void _onAddClient() {
    if (!_clientAdded) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                width: 500,
                child: ClientsPage(
                  hasAddButton: false,
                  hasTitle: false,
                  onClientPressed: (client) {
                    context.pop();
                    setState(() {
                      _clientAdded = !_clientAdded;
                    });
                  },
                ),
              ),
              actions: [
                AutomatizeButton.rectangle(
                  onPressed: context.pop,
                  label: const Text("Sair"),
                )
              ],
            );
          });

      return;
    }

    setState(() {
      _clientAdded = !_clientAdded;
    });
  }
}

class _WarrantyDate extends StatefulWidget {
  const _WarrantyDate({super.key});

  @override
  State<_WarrantyDate> createState() => _WarrantyDateState();
}

class _WarrantyDateState extends State<_WarrantyDate> {
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return ToggleHeader(
      title: "Garantia OS",
      toggle: _date != null,
      onPressed: () async {
        if (_date == null) {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(3000),
          );
          setState(() {
            _date = date;
          });
          return;
        }
        setState(() {
          _date = null;
        });
      },
      child: Text(
        _date?.ddMMyyyy ?? "",
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}

class _TechnicalList extends StatefulWidget {
  const _TechnicalList({super.key});

  @override
  State<_TechnicalList> createState() => _TechnicalListState();
}

class _TechnicalListState extends State<_TechnicalList> {
  bool toggle = false;

  @override
  Widget build(BuildContext context) {
    return ToggleHeader(
      title: "Técnicos",
      toggle: toggle,
      onPressed: () {
        setState(() {
          toggle = !toggle;
        });
      },
      child: FilterChip(
        selected: false,
        label: Text(dotenv.env['API_KEY'] ?? ""),
        onSelected: (bool value) {},
      ),
    );
  }
}
