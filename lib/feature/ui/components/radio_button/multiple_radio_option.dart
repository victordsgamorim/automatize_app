import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/iterable_extension.dart';
import 'package:automatize_app/feature/ui/components/radio_button/radio_item.dart';

class MultipleRadioOption extends StatefulWidget {
  final int value;
  final List<RadioItem> items;
  final Function(int value) onChanged;
  final bool enabled;

  const MultipleRadioOption({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.enabled = false,
  }) : assert(value >= 0 && value < items.length);

  @override
  State<MultipleRadioOption> createState() => _MultipleRadioOptionState();
}

class _MultipleRadioOptionState extends State<MultipleRadioOption> {
  late int _chosenRadio;

  @override
  void initState() {
    _chosenRadio = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
      child: AbsorbPointer(
        absorbing: widget.enabled,
        child: Opacity(
          opacity: widget.enabled ? .5 : 1,
          child: Row(
              children: widget.items.mapIndexed((index, item) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: RadioMenuButton<int>(
                value: index,
                groupValue: _chosenRadio,
                onFocusChange: (_) => FocusScope.of(context).unfocus(),
                onChanged: onTap,
                child: Text(
                  item.label,
                  style: TextStyle(color: context.colorScheme.primary),
                ),
              ),
            );
          }).toList()),
        ),
      ),
    );
  }

  onTap(int? value) {
    setState(() => _chosenRadio = value!);
    widget.onChanged(_chosenRadio);
  }
}
