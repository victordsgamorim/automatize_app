import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_divider.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/components/table/paginated_table.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchNode;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showMobileLayout = isMobile(context);
    const btnIcon = Icon(FontAwesomeIcons.folderPlus, size: 18);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!showMobileLayout) ...dividedHeader('Produtos'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: AutomatizeTextField(
                    controller: _searchController,
                    focusNode: _searchNode,
                    label: "Buscar produto...",
                    icon: Icons.search_rounded,
                  ),
                ),
                const SizedBox(width: 16),
                showMobileLayout
                    ? AutomatizeButton.square(onPressed: () {}, icon: btnIcon)
                    : AutomatizeButton.rectangle(
                        onPressed: () {},
                        icon: btnIcon,
                        label: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Adicionar Produto"),
                        ),
                      )
              ],
            ),
          ),
          Expanded(
              child: PaginatedTable(
            columns: const [
              DataColumn2(label: Text('Produto'), size: ColumnSize.L),
              DataColumn2(label: Text('Qnt.'), fixedWidth: 125),
              DataColumn2(label: Text(r'''Preço (R$)'''), fixedWidth: 125),
            ],
            source: ProductDataTableSource(),
          ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNode.dispose();
    super.dispose();
  }
}

class ProductDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> _data = [
    {
      "name": "Motor",
      "quantity": 5,
      "price": 150.75
    },
  ];

  @override
  DataRow? getRow(int index) {
    if (index >= _data.length) return null;
    final Map<String, dynamic> row = _data[index];
    final isRounded = index == (_data.length) - 1
        ? const Radius.circular(16)
        : const Radius.circular(0);
    return DataRow2.byIndex(
      index: index,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: isRounded,
          bottomRight: isRounded,
        ),
      ),
      onTap: () {
        print('data row click');
      },
      cells: [
        DataCell(Text(row['name'])),
        DataCell(Text('${row['quantity']}')),
        DataCell(Text('${row['price']}')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
