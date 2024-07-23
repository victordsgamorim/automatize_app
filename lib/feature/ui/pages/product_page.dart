import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_header_menu.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
      child: Column(
        children: [
          const AutomatizeHeaderMenu(label: 'Novo Produto'),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverCrossAxisConstrained(
                  alignment: 0,
                  maxCrossAxisExtent: 600,
                  child: SliverToBoxAdapter(
                    child: Container(
                      color: Colors.blue,
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 120.0),
                  sliver: SliverToBoxAdapter(child: _ProductForm()),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ProductForm extends StatefulWidget {
  const _ProductForm({super.key});

  @override
  State<_ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<_ProductForm> {
  late final TextEditingController _nameController;
  late final TextEditingController _companyController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  late final TextEditingController _infoController;

  late final FocusNode _nameNode;
  late final FocusNode _companyNode;
  late final FocusNode _priceNode;
  late final FocusNode _quantityNode;
  late final FocusNode _infoNode;

  @override
  void initState() {
    _nameController = TextEditingController();
    _companyController = TextEditingController();
    _priceController = TextEditingController();
    _quantityController = TextEditingController();
    _infoController = TextEditingController();

    _nameNode = FocusNode();
    _companyNode = FocusNode();
    _priceNode = FocusNode();
    _quantityNode = FocusNode();
    _infoNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutomatizeTextFieldWithTitle(
          key: const Key("productNameField"),
          controller: _nameController,
          focusNode: _nameNode,
          label: "Nome do produto",
          icon: Icons.sell_outlined,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: AutomatizeTextFieldWithTitle(
            key: const Key("productCompanyField"),
            controller: _companyController,
            focusNode: _companyNode,
            label: "Empresa",
            icon: FontAwesomeIcons.building,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Expanded(
                child: AutomatizeTextFieldWithTitle(
                  key: const Key("productPriceField"),
                  controller: _priceController,
                  focusNode: _priceNode,
                  label: "Preço",
                  icon: Icons.attach_money_rounded,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AutomatizeTextFieldWithTitle(
                  key: const Key("productQuantityField"),
                  controller: _quantityController,
                  focusNode: _quantityNode,
                  label: "Quantidade",
                  icon: Icons.onetwothree,
                ),
              )
            ],
          ),
        ),
        AutomatizeTextFieldWithTitle(
          key: const Key("productInfoField"),
          controller: _infoController,
          focusNode: _infoNode,
          label: "Informações adicionais",
          icon: Icons.info_outline_rounded,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _infoController.dispose();
    super.dispose();
  }
}
