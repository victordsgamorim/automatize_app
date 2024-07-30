import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/text_field/automatize_textfield.dart';
import 'package:go_router/go_router.dart';

class EditableTextFieldWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const EditableTextFieldWithTitle({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onPrimaryContainer,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Alterar $title"),
                          content: AutomatizeTextField(
                            controller: controller,
                            multipleLines: true,
                          ),
                          actions: [
                            AutomatizeButton.rectangle(
                              onPressed: context.pop,
                              label: const Text("Sair"),
                            )
                          ],
                        );
                      });
                },
                child: Icon(
                  Icons.edit_rounded,
                  size: 16,
                  color: context.colorScheme.onPrimaryContainer,
                ),
              ),
            )
          ],
        ),
        AutomatizeTextField(
          controller: controller,
          multipleLines: true,
          readOnly: true,
        )
        // Text(_controller.text)
      ],
    );
  }
}
