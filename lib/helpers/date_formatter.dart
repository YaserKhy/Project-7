import 'package:intl/intl.dart';

String formatDate(String baseDate) {
  DateTime parsedDate = DateTime.parse(baseDate);
  String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
  return formattedDate;
}
