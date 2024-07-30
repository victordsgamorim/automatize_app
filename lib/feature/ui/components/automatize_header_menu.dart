import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_divider.dart';
import 'package:automatize_app/feature/ui/components/automatize_header.dart';
import 'package:automatize_app/feature/ui/pages/scaffold_navigation_page.dart';
import 'package:go_router/go_router.dart';

class AutomatizeHeaderMenu extends StatefulWidget {
  final String label;
  final VoidCallback? onClose;
  final VoidCallback? onDone;
  final Widget? leading;

  const AutomatizeHeaderMenu({
    super.key,
    required this.label,
    this.onDone,
    this.onClose,
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
      children: [
        if (showMobileLayout)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Align(
                alignment: Alignment.centerRight,
                child: _actionButton(
                  leading: widget.leading,
                  action: AutomatizeButton.square(
                    onPressed: () => _onClose(),
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    color: Colors.redAccent,
                  ),
                )),
          ),
        if (!showMobileLayout) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => _onClose(),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: context.colorScheme.primary,
                      )),
                  const SizedBox(width: 8),
                  AutomatizeHeader(label: widget.label),
                ],
              ),
              _actionButton()
            ],
          ),
          const AutomatizeDivider()
        ],
      ],
    );
  }

  void _onClose() {
    widget.onClose?.call();
    context.pop();
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
