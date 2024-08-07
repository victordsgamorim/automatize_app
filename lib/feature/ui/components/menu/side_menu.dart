import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/components/menu/menu.dart';
import 'package:automatize_app/feature/ui/components/menu/menu_item.dart';

part 'menu_header.dart';

const kAnimationDuration = Duration(milliseconds: 300);
const kAnimationCurve = Curves.linear;

class SideMenu extends StatefulWidget {
  final int index;
  final List<MenuItem> menus;
  final Function(int index) onChanged;

  const SideMenu({
    super.key,
    required this.index,
    required this.menus,
    required this.onChanged,
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
        AnimationController(vsync: this, duration: kAnimationDuration);

    _containerAnimation = Tween<double>(begin: 280, end: 132).animate(
        CurvedAnimation(parent: _animationController, curve: kAnimationCurve));

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
                  SliverMenu(
                    index: widget.index,
                    controller: _animationController,
                    menus: widget.menus,
                    onChanged: widget.onChanged,
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
