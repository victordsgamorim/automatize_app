import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String get toReal =>
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(this);
}
