import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_date_time_picker.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/components/radio_button/multiple_radio_option.dart';
import 'package:automatize_app/feature/ui/components/radio_button/radio_item.dart';
import 'package:automatize_app/feature/ui/components/table/paginated_table.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:data_table_2/data_table_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final width = MediaQuery.sizeOf(context).width;
    final isTablet = width > tablet;
    final logoutItem = logoutMenu();
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AutomatizeTextField(
                  controller: _searchController,
                  focusNode: _searchNode,
                  label: "Buscar ordem de serviço...",
                  icon: Icons.search_rounded,
                ),
              ),
              if (isTablet) ...[
                const SizedBox(width: 16),
                AutomatizeButton.rectangle(
                  onPressed: logoutItem.onTap,
                  icon: Icon(logoutItem.icon),
                  label: Text(logoutItem.title),
                )
              ]
            ],
          ),
          MultipleRadioOption(
            items: const [
              RadioItem(label: "Pessoa"),
              RadioItem(label: "Endereço"),
            ],
            onChanged: (int value) {},
            value: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const AutomatizeHeader(label: "Ordem de serviço"),
                AutomatizeDateTimePicker(
                  parentSize: constraints.biggest,
                  onCancelPressed: () {},
                  onOKPressed: (range) {},
                )
              ],
            ),
          ),
          Expanded(
              child: PaginatedTable(
            columns: const [
              DataColumn2(label: CircleAvatar(radius: 12), fixedWidth: 50),
              DataColumn2(label: Text('Cliente'), size: ColumnSize.M),
              DataColumn2(label: Text('Endereço'), size: ColumnSize.M),
              DataColumn2(label: Text('Itens'), size: ColumnSize.L),
              DataColumn2(label: Text(r'''Total (R$)'''), fixedWidth: 125),
            ],
            source: SimpleDataTableSource(),
          ))
        ],
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNode.dispose();
    super.dispose();
  }
}

class SimpleDataTableSource extends DataTableSource {
  final List<Map<String, dynamic>> _data = [
    {
      "state": "CA",
      "client": "Alice",
      "address": "123 Main St",
      "items": 5,
      "total": 150.75
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
        DataCell(
          GestureDetector(
              onTap: () {
                print('estou clicando no icone');
              },
              child: const CircleAvatar(radius: 12)),
        ),
        DataCell(Text(row['client'])),
        DataCell(Text(row['address'])),
        DataCell(Text('${row['items']}')),
        DataCell(Text('${row['total']}')),
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
