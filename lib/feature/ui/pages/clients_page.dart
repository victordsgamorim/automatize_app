import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/route/route_path.dart';
import 'package:automatize_app/feature/model/client.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/icon_menu.dart';
import 'package:automatize_app/feature/ui/components/table/paginated_table.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/controllers/client/client_bloc.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class ClientsPage extends StatelessWidget {
  const ClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ClientsPage();
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
  late final ClientBloc _clientBloc;
  late final TextEditingController _searchController;
  late final FocusNode _searchNode;

  Client? _selectedClient;

  @override
  void initState() {
    _clientBloc = context.bloc<ClientBloc>()..add(const GetAllEvent());
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
                    onChanged: (text) {
                      _clientBloc.add(SearchEvent(text));
                    },
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
            child: BlocConsumer<ClientBloc, ClientState>(
              listener: (context, state) {
                if (state is ClientLoading) {
                  EasyLoading.show(status: "Carregando...");
                }

                if(state is ClientError){
                  EasyLoading.showError(state.message);
                }

                if (state is ClientSuccess) {
                  EasyLoading.dismiss().then((_) {
                    if (state.canProceed) {
                      context.go(R.client, extra: _selectedClient);
                    }
                  });
                }
              },
              builder: (context, state) {
                return PaginatedTable(
                  columns: const [
                    DataColumn2(label: Text('Cliente')),
                    DataColumn2(label: Text('Endereço')),
                  ],
                  source: ClientDataTableSource(
                    onTap: (client, index) {
                      if (widget.onClientPressed != null) {
                        widget.onClientPressed!("");
                        return;
                      }
                      _go(client: client, index: index);
                    },
                    onMenuTap: (client, menu, index) {
                      if (menu == MenuType.delete) {
                        _clientBloc.add(DeleteByIdEvent(
                          id: client.id,
                          index: index,
                        ));
                        return;
                      }

                      _go(client: client, index: index);
                    },
                    clients: state.clients,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void _go({required Client client, required int index}) {
    _selectedClient = client;
    _clientBloc.add(GetByIdEvent(id: client.id, index: index));
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
  final Function(Client client, int index) onTap;
  final List<Client> clients;
  final Function(Client client, MenuType? menu, int index)? onMenuTap;

  ClientDataTableSource({
    required this.onTap,
    required this.clients,
    this.onMenuTap,
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
      onTap: () => onTap(client, index),
      cells: [
        DataCell(Text(client.name)),
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(client.addresses.isNotEmpty
                  ? client.addresses[0].toSingleLine
                  : ''),
            ),
            IconMenu(
              items: const [MenuType.open, MenuType.delete],
              onTap: (menu) => onMenuTap?.call(client, menu, index),
            )
          ],
        )),
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
