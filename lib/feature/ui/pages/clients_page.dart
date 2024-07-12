import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_divider.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/components/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/components/table/paginated_table.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    final showMobileLayout = isMobile(MediaQuery.sizeOf(context).width);
    const btnIcon = Icon(FontAwesomeIcons.userPlus, size: 18);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!showMobileLayout) ...[
          const AutomatizeHeader(label: 'Clientes'),
          const AutomatizeDivider(),
        ],
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Row(
            children: [
              Expanded(
                child: AutomatizeTextField(
                  controller: _searchController,
                  focusNode: _searchNode,
                  label: "Buscar cliente...",
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              showMobileLayout
                  ? AutomatizeButton.square(onPressed: () {}, icon: btnIcon)
                  : AutomatizeButton.rectangle(
                      onPressed: () {},
                      icon: btnIcon,
                      label: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text("Adicionar Cliente"),
                      ),
                    )
            ],
          ),
        ),
        const Expanded(child: PaginatedTable())
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchNode.dispose();
    super.dispose();
  }
}
