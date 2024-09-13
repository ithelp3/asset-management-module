import 'package:intl/intl.dart';

extension DoubleExt on double {
  String toIdr() {
    return NumberFormat.simpleCurrency(
      name: 'IDR',
      decimalDigits: 2
    ).format(this/1);
  }
}