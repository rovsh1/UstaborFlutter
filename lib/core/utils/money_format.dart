import 'package:get/utils.dart';
import 'package:intl/intl.dart';

String formatMoney(dynamic text, {bool withSum = true}) {
  final formatCurrency = new NumberFormat.simpleCurrency(decimalDigits: 0);

  return "${formatCurrency.format(text).replaceAll('\$', '').replaceAll(',', ' ')}${withSum? ' ${'sum'.tr}': ''}";
}

String phoneFormat(String phone) {
  return "+${phone.substring(0, 3)} ${phone.substring(3, 5)} ${phone.substring(5, 8)} ${phone.substring(8, 10)} ${phone.substring(10, 12)}";
}
