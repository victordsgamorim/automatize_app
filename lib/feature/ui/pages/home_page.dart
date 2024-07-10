import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/datetime_extension.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_date_time_picker.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/components/automatize_text_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/components/radio_button/multiple_radio_option.dart';
import 'package:automatize_app/feature/ui/components/radio_button/radio_item.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchNode;

  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (constraints.maxWidth / 2.3).clamp(300, 500),
                child: AutomatizeTextField(
                  controller: _searchController,
                  focusNode: _searchNode,
                  label: "Buscar ordem de serviço...",
                ),
              ),
              AutomatizeButton.rectangle(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded),
                label: const Text("Sair"),
              )
            ],
          ),
          MultipleRadioOption(
            items: const [
              RadioItem(label: "Pessoa"),
              RadioItem(label: "Endereço"),
            ],
            onChanged: (int value) {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const AutomatizeHeader(label: "Ordem de Serviço"),
              AutomatizeDateTimePicker(
                parentSize: constraints.biggest,
                onCancelPressed: () {},
                onOKPressed: (range) {},
              )
            ],
          )
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
