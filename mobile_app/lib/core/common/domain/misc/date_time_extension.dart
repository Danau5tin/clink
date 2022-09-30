extension DateTimeExtension on DateTime {
  bool isSameDayAs(DateTime comparison) {
    return day == comparison.day &&
        month == comparison.month &&
        year == comparison.year;
  }
}
