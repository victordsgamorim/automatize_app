import 'package:automatize_app/common_libs.dart';
import 'package:automatize_app/core/utils/extensions/datetime_extension.dart';
import 'package:automatize_app/feature/ui/components/automatize_button.dart';
import 'package:automatize_app/feature/ui/components/automatize_text_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef DateRangeCallBack = Function(DateTimeRange? dates);

class AutomatizeDateTimePicker extends StatefulWidget {
  final DateTime? initialDate;
  final Size? parentSize;
  final VoidCallback onCancelPressed;
  final DateRangeCallBack onOKPressed;

  const AutomatizeDateTimePicker({
    this.initialDate,
    super.key,
    required this.onCancelPressed,
    required this.onOKPressed,
    this.parentSize,
  });

  @override
  State<AutomatizeDateTimePicker> createState() =>
      _AutomatizeDateTimePickerState();
}

class _AutomatizeDateTimePickerState extends State<AutomatizeDateTimePicker> {
  late DateTimeRange _currentDateRange;
  late String _selectedDate;
  bool _isResetIconVisible = false;

  @override
  void initState() {
    _initialInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const icon = Icon(Icons.calendar_month_outlined);

    Widget currentButton = SizedBox(
      height: 56,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AutomatizeTextButton(
          label: _selectedDate,
          icon: icon,
          onTap: () {
            showDateRange(
              currentHeight: MediaQuery.sizeOf(context).height,
              currentWidth: widget.parentSize != null
                  ? widget.parentSize!.width
                  : MediaQuery.sizeOf(context).width,
            );
          },
        ),
      ),
    );
    if (widget.parentSize != null && widget.parentSize!.width <= 700) {
      currentButton = AutomatizeButton.square(
        onPressed: () {
          showDateRange(
            currentHeight: MediaQuery.sizeOf(context).height,
            currentWidth: widget.parentSize!.width,
          );
        },
        icon: icon,
      );
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          currentButton,
          if (_isResetIconVisible)
            TextButton(
              onPressed: () {
                _isResetIconVisible = false;
                _onChangedEnd(_initialDateTimeRange);
              },
              child: const Icon(
                FontAwesomeIcons.filterCircleXmark,
                size: 18,
              ),
            )
        ],
      ),
    );
  }

  void showDateRange({
    required double currentHeight,
    required double currentWidth,
  }) async {
    final dates = await showDateRangePicker(
      context: context,
      initialDateRange: _currentDateRange,
      currentDate: _initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
      saveText: "OK",
      initialEntryMode: (currentHeight <= 500 || currentWidth <= 700)
          ? DatePickerEntryMode.calendar
          : DatePickerEntryMode.input,
    );

    _onChangedEnd(dates);
  }

  void _onChangedEnd(DateTimeRange? dates) {
    if (dates == null) return widget.onCancelPressed();

    setState(() {
      _currentDateRange = dates;
      _selectedDate = _formatDate(dates);
    });

    widget.onOKPressed(dates);
  }

  DateTime get _initialDate => widget.initialDate ?? DateTime.now();

  DateTimeRange get _initialDateTimeRange =>
      DateTimeRange(start: _initialDate, end: _initialDate);

  void _initialInfo() {
    _currentDateRange = _initialDateTimeRange;
    _selectedDate = _formatDate(_currentDateRange);
  }

  String _formatDate(DateTimeRange range) {
    final diff = range.end.difference(range.start).inDays;
    if (diff == 0) return range.start.EEEEddMMMMyyyy;

    _isResetIconVisible = true;
    return '${range.start.ddMMyyyy} - ${range.end.ddMMyyyy}';
  }
}
