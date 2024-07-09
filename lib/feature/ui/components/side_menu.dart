import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/build_context_extension.dart';
import 'package:automatize_app/feature/ui/components/squared_button.dart';

const _animationDuration = Duration(milliseconds: 300);
const _animationCurve = Curves.linear;

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  bool isExpanded = true;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: double.maxFinite,
      width: isExpanded ? 280 : 132,
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          right: BorderSide(color: context.colorScheme.primary, width: 10),
        ),
      ),
      duration: _animationDuration,
      curve: _animationCurve,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _MenuHeader(
              isExpanded: isExpanded,
              onPressed: _toggleNavigator,
            ),
            _MenuTile(
              isExpanded: isExpanded,
              isSelected: isSelected,
              onPressed: () {
                setState(() {
                  isSelected = !isSelected;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void _toggleNavigator() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

class _MenuHeader extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onPressed;

  const _MenuHeader({
    required this.isExpanded,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 56,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: AnimatedOpacity(
              opacity: isExpanded ? 1 : 0,
              duration: _animationDuration,
              curve: _animationCurve,
              child: Text(
                "Menu",
                style: context.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: context.colorScheme.primary,
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: _animationDuration,
            curve: _animationCurve,
            alignment: Alignment(isExpanded ? 1 : 0, 0),
            child: SquaredButton(
              icon: AnimatedRotation(
                turns: isExpanded ? 0 : .5,
                duration: _animationDuration,
                curve: _animationCurve,
                child: const Icon(Icons.arrow_back_rounded),
              ),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatefulWidget {
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onPressed;

  const _MenuTile({
    super.key,
    required this.isExpanded,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<_MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<_MenuTile> {
  @override
  void didUpdateWidget(covariant _MenuTile oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final contentColor = !widget.isSelected
        ? context.colorScheme.onPrimaryContainer
        : context.colorScheme.primaryContainer;

    final containerColor = !widget.isSelected
        ? context.colorScheme.primaryContainer
        : context.colorScheme.onPrimaryContainer;

    return InkWell(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        height: 56,
        width: widget.isExpanded ? 280 : 56,
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        duration: _animationDuration,
        curve: _animationCurve,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                alignment: Alignment(widget.isExpanded ? -.85 : 0, 0),
                duration: _animationDuration,
                curve: _animationCurve,
                child: Icon(
                  Icons.home_rounded,
                  color: contentColor,
                ),
              ),
              AnimatedOpacity(
                duration: widget.isExpanded
                    ? const Duration(milliseconds: 1100)
                    : const Duration(milliseconds: 150),
                curve: _animationCurve,
                opacity: widget.isExpanded ? 1 : 0,
                child: Text(
                  "Pagina Inicial",
                  style: context.textTheme.labelLarge
                      ?.copyWith(color: contentColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
