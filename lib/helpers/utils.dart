import 'package:intl/intl.dart';

class Utils {
  static formatPrice(double price) => 'R\$ ${price.toStringAsFixed(2).replaceAll(".", ",")}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
}
