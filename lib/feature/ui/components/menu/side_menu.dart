import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/menu/menu_item.dart';
import 'package:automatize_app/feature/ui/components/squared_button.dart';
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';
import 'package:sliver_tools/sliver_tools.dart';

part 'menu.dart';

part 'menu_header.dart';

part 'menu_tile.dart';

const _animationDuration = Duration(milliseconds: 300);
const _animationCurve = Curves.linear;

class SideMenu extends StatefulWidget {
  final List<MenuItem> menus;

  const SideMenu({
    super.key,
    required this.menus,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _containerAnimation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);

    _containerAnimation = Tween<double>(begin: 280, end: 132).animate(
        CurvedAnimation(parent: _animationController, curve: _animationCurve));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _containerAnimation,
        builder: (context, child) {
          return Container(
            height: double.maxFinite,
            width: _containerAnimation.value,
            decoration: BoxDecoration(
              color: context.colorScheme.onPrimary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              border: Border(
                right:
                    BorderSide(color: context.colorScheme.primary, width: 10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    sliver: SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverMenuHeaderDelegate(
                        controller: _animationController,
                        onPressed: _toggleNavigator,
                      ),
                    ),
                  ),
                  _SliverMenu(
                    controller: _animationController,
                    menus: widget.menus,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _toggleNavigator() {
    _animationController.isCompleted
        ? _animationController.reverse()
        : _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
