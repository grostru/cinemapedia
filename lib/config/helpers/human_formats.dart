import 'package:intl/intl.dart';

class Humanformats{

  static String number(double number){
    final formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en',
    ).format(number);

    return formattedNumber;
  }
}