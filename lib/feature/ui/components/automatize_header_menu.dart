import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_divider.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:go_router/go_router.dart';

class AutomatizeHeaderMenu extends StatefulWidget {
  final String label;
  final VoidCallback? onDone;
  final Widget? leading;

  const AutomatizeHeaderMenu({
    super.key,
    required this.label,
    this.onDone,
    this.leading,
  });

  @override
  State<AutomatizeHeaderMenu> createState() => _AutomatizeHeaderMenuState();
}

class _AutomatizeHeaderMenuState extends State<AutomatizeHeaderMenu> {
  @override
  Widget build(BuildContext context) {
    final showMobileLayout = isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (!showMobileLayout) ...[
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                IconButton(
                    onPressed: context.pop,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: context.colorScheme.primary,
                    )),
                AutomatizeHeader(label: widget.label),
              ]),
              Align(
                  alignment: Alignment.centerRight,
                  child: _actionButton())
            ],
          ),
          const AutomatizeDivider()
        ],
      ],
    );
  }

  Row _actionButton({Widget? leading, Widget? action}) {
    const padding = SizedBox(width: 8);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leading != null) ...[Expanded(child: leading), padding],
        if (action != null) ...[action, padding],
        AutomatizeButton.square(
          onPressed: () => widget.onDone?.call(),
          icon: const Icon(Icons.done_rounded, color: Colors.white),
          color: Colors.lightGreen,
        ),
      ],
    );
  }
}
