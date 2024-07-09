part of 'side_menu.dart';

class _MenuTile extends StatefulWidget {
  final bool isSelected;
  final AnimationController controller;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const _MenuTile({
    required this.controller,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<_MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<_MenuTile> {
  late final Animation<double> _fadeTransition;
  late final Animation<double> _containerTransition;

  @override
  void initState() {
    _containerTransition = Tween<double>(begin: 238, end: 56).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: _animationCurve,
      ),
    );

    _fadeTransition = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0, .3, curve: _animationCurve),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _getColor(isSelected: !widget.isSelected);
    final contentColor = _getColor(isSelected: widget.isSelected);
    return UnconstrainedBox(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Material(
          child: InkWell(
            onTap: widget.onPressed,
            child: Ink(
              width: _containerTransition.value,
              height: 56,
              decoration: BoxDecoration(color: bgColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(widget.icon, color: contentColor, size: 20,),
                    if (_fadeTransition.value != 0.0) ...[
                      const SizedBox(width: 16),
                      FadeTransition(
                        opacity: _fadeTransition,
                        child: Text(
                          widget.title,
                          maxLines: 1,
                          style: context.textTheme.labelLarge
                              ?.copyWith(color: contentColor),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor({required bool isSelected}) {
    return !isSelected
        ? context.colorScheme.primary
        : context.colorScheme.onPrimary;
  }
}
