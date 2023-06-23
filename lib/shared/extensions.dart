import 'package:intl/intl.dart';

extension Date on DateTime {
  String simpleDateFormat() => DateFormat('dd/MM/yy').format(this);
  String extendedDateFormat() =>
      DateFormat('EEEE, MMM dd yyyy, HH:mm').format(this);
  String dayDateFormat() => DateFormat('EE dd\nMMM yyyy').format(this);
}
