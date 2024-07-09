import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/datetime_extension.dart';
import 'package:automatize_app/core/utils/extensions/string_extension.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/components/automatize_text_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_textfield.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/radio_button/multiple_radio_option.dart';
import 'package:automatize_app/feature/ui/components/radio_button/radio_item.dart';
import 'package:jiffy/jiffy.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  @override
  void initState() {

    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
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
                  controller: _textEditingController,
                  focusNode: _focusNode,
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
              AutomatizeTextButton(
                label: DateTime.now().EEEEddMMMMyyyy,
                icon: const Icon(Icons.calendar_month_outlined),
                onTap: () {},
              )
            ],
          )
        ],
      );
    });
  }

}
