part of 'side_menu.dart';

class _SliverMenu extends StatefulWidget {
  final List<MenuItem> menus;
  final AnimationController controller;

  const _SliverMenu({super.key, required this.controller, required this.menus});

  @override
  State<_SliverMenu> createState() => _SliverMenuState();
}

class _SliverMenuState extends State<_SliverMenu> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final menu = widget.menus[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _MenuTile(
              isSelected: _currentIndex == index,
              controller: widget.controller,
              title: menu.title,
              icon: menu.icon,
              onPressed: () {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          );
        },
        childCount: widget.menus.length,
      ),
    );
  }
}
