import 'package:automatize_app/core/utils/extensions/string_extension.dart';
import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String get EEEEddMMyyyy =>
      DateFormat('EEEE, dd/MM/yyyy', 'pt_BR').format(this).capitalize();

  String get EEEEddMMMMyyyy =>
      DateFormat('EEEE, dd MMMM yyyy', 'pt_BR').format(this).capitalize();

  String get ddMMyyyy => DateFormat('dd/MM/yyyy', 'pt_BR').format(this);
}
