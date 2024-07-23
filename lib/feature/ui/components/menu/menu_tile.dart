import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/menu/side_menu.dart';

class MenuTile extends StatefulWidget {
  final bool isSelected;
  final AnimationController? controller;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const MenuTile({
    super.key,
    this.controller,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  late final Animation<double> _fadeTransition;
  late final Animation<double> _containerTransition;
  late final bool isDrawerMenu;

  @override
  void initState() {
    isDrawerMenu = widget.controller == null;
    if (!isDrawerMenu) {
      _containerTransition = Tween<double>(begin: 238, end: 56).animate(
        CurvedAnimation(
          parent: widget.controller!,
          curve: kAnimationCurve,
        ),
      );

      _fadeTransition = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
          parent: widget.controller!,
          curve: const Interval(0, .3, curve: kAnimationCurve),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getColor(isSelected: !widget.isSelected);
    final contentColor = _getColor(isSelected: widget.isSelected);

    final Text textWidget = Text(
      widget.title,
      maxLines: 1,
      style: context.textTheme.labelLarge?.copyWith(color: contentColor),
    );

    const SizedBox sizedBoxWidget = SizedBox(width: 16);

    final Widget body = ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Material(
        child: InkWell(
          onTap: widget.onPressed,
          child: Ink(
            width: !isDrawerMenu ? _containerTransition.value : null,
            height: 56,
            decoration: BoxDecoration(color: bgColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widget.icon,
                    color: contentColor,
                    size: 20,
                  ),
                  if (isDrawerMenu) ...[sizedBoxWidget, textWidget],
                  if (!isDrawerMenu && _fadeTransition.value != 0.0) ...[
                    sizedBoxWidget,
                    FadeTransition(
                      opacity: _fadeTransition,
                      child: textWidget,
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return !isDrawerMenu ? UnconstrainedBox(child: body) : body;
  }

  Color _getColor({required bool isSelected}) {
    return !isSelected
        ? context.colorScheme.primary
        : context.colorScheme.onPrimary;
  }
}
