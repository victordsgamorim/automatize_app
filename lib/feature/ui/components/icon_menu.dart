import 'package:automatize_app/common_libs.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

enum MenuType {
  delete(name: "Apagar", icon: Icons.delete),
  open(name: "Atualizar", icon: Icons.edit_rounded);

  final String name;
  final IconData icon;

  const MenuType({required this.name, required this.icon});
}

class IconMenu extends StatelessWidget {
  final List<MenuType> items;
  final ValueChanged<MenuType?>? onTap;

  const IconMenu({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(Icons.more_vert),
        items: [
          ...items.map(
            (item) => DropdownMenuItem<MenuType>(
              value: item,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(item.icon),
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text(
                        item.name,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        onChanged: onTap,
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          offset: const Offset(0, -8),
        ),
      ),
    );
  }
}
