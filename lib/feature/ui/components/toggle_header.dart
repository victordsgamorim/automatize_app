import 'package:automatize_app/common_libs.dart';

class ToggleHeader extends StatelessWidget {
  final bool toggle;
  final VoidCallback? onPressed;
  final Widget child;
  final String title;

  const ToggleHeader({
    super.key,
    required this.child,
    required this.toggle,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            IconButton(
                onPressed: () {
                  onPressed?.call();
                },
                icon: Icon(
                  toggle
                      ? Icons.remove_circle_outline_outlined
                      : Icons.add_circle_outline_rounded,
                  color: context.colorScheme.primary,
                ))
          ],
        ),
        if (toggle) child
      ],
    );
  }
}
