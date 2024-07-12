import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/menu/menu_item.dart';
import 'package:automatize_app/feature/ui/components/menu/menu_tile.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SliverMenu extends StatefulWidget {
  final List<MenuItem> menus;
  final AnimationController? controller;

  const SliverMenu({super.key, this.controller, required this.menus});

  @override
  State<SliverMenu> createState() => _SliverMenuState();
}

class _SliverMenuState extends State<SliverMenu> {
  int _currentIndex = 0;

  late List<MenuItem> _mainMenu;
  late List<MenuItem> _bottomMenu;

  final endSublist = 3;

  @override
  void initState() {
    _mainMenu = widget.menus.sublist(0, endSublist);
    _bottomMenu = widget.menus.sublist(endSublist);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final menu = _mainMenu[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: MenuTile(
                  isSelected: _currentIndex == index,
                  controller: widget.controller,
                  title: menu.title,
                  icon: menu.icon,
                  onPressed: () {
                    menu.onTap();
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              );
            },
            childCount: _mainMenu.length,
          ),
        ),
        SliverFillRemainingBoxAdapter(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _bottomMenu.length,
                itemBuilder: (context, index) {
                  final menu = _bottomMenu[index];
                  return MenuTile(
                    isSelected: _currentIndex == endSublist + index,
                    controller: widget.controller,
                    title: menu.title,
                    icon: menu.icon,
                    onPressed: () {
                      menu.onTap();
                      setState(() {
                        _currentIndex = endSublist + index;
                      });
                    },
                  );
                }),
          ),
        ),
      ],
    );
  }
}
