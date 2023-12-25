

// get the today date in this format (Friday, 23 July)

String getTodayDate() {
  final now = DateTime.now();
  final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  final weekday = weekdays[now.weekday - 1];
  final day = now.day;
  final month = months[now.month - 1];

  return '$weekday, $day $month';
}






