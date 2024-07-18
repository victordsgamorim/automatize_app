import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route_path.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/table/paginated_table.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
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
    const btnIcon = Icon(FontAwesomeIcons.userPlus, size: 18);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!showMobileLayout) ...dividedHeader('Clientes'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: AutomatizeTextField(
                    controller: _searchController,
                    focusNode: _searchNode,
                    label: "Buscar cliente...",
                    icon: Icons.search_rounded,
                  ),
                ),
                const SizedBox(width: 16),
                showMobileLayout
                    ? AutomatizeButton.square(
                        onPressed: _onTapNewClient, icon: btnIcon)
                    : AutomatizeButton.rectangle(
                        onPressed: _onTapNewClient,
                        icon: btnIcon,
                        label: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Adicionar Cliente"),
                        ),
                      )
              ],
            ),
          ),
          Expanded(
            child: PaginatedTable(
              columns: const [
                DataColumn2(label: Text('Cliente')),
                DataColumn2(label: Text('Endereço')),
              ],
              source: ClientDataTableSource(onTap: () {
                context.go(R.client);
              }),
            ),
          )
        ],
      ),
    );
  }

  void _onTapNewClient() {
    context.go(R.client);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNode.dispose();
    super.dispose();
  }
}

class ClientDataTableSource extends DataTableSource {
  final VoidCallback onTap;
  final List<Map<String, dynamic>> _data = [
    {
      "client": "Alice",
      "address": "123 Main St",
    },
  ];

  ClientDataTableSource({required this.onTap});

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
      onTap: onTap,
      cells: [
        DataCell(Text(row['client'])),
        DataCell(Text(row['address'])),
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
