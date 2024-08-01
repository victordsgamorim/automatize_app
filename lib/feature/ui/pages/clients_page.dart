import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route_path.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/table/paginated_table.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/controllers/client/client_cubit.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<ClientCubit>(),
      child: const _ClientsPage(),
    );
  }
}

class _ClientsPage extends StatefulWidget {
  final bool hasAddButton;
  final bool hasTitle;
  final Function(dynamic client)? onClientPressed;

  const _ClientsPage({
    super.key,
    this.hasAddButton = true,
    this.hasTitle = true,
    this.onClientPressed,
  });

  @override
  State<_ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<_ClientsPage> {
  late final ClientCubit _cubit;
  late final TextEditingController _searchController;
  late final FocusNode _searchNode;

  @override
  void initState() {
    _cubit = context.bloc<ClientCubit>()..load();
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
          if (widget.hasTitle && !showMobileLayout)
            ...dividedHeader('Clientes'),
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
                if (widget.hasAddButton) ...[
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
                ]
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ClientCubit, ClientState>(
              builder: (context, state) {
                if (state is ClientLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return PaginatedTable(
                  columns: const [
                    DataColumn2(label: Text('Cliente')),
                    DataColumn2(label: Text('Endereço')),
                  ],
                  source: ClientDataTableSource(
                      onTap: () {
                        if (widget.onClientPressed != null) {
                          widget.onClientPressed!("");
                          return;
                        }
                        context.go(R.client);
                      },
                      clients: state.clients),
                );
              },
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
  final List<Client> clients;

  ClientDataTableSource({
    required this.onTap,
    required this.clients,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= clients.length) return null;
    final Client client = clients[index];
    final isRounded = index == (clients.length) - 1
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
        DataCell(Text(client.name), showEditIcon: true),
        DataCell(Text(client.addresses.isNotEmpty
            ? client.addresses[0].toSingleLine
            : '')),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => clients.length;

  @override
  int get selectedRowCount => 0;
}
