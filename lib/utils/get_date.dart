

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


// get the today date in this format 09/07/2021 12:00 AM

String getTodayDateTime() {
  final now = DateTime.now();
  final day = now.day;
  final month = now.month;
  final year = now.year;
  final hour = now.hour;
  final minute = now.minute;
  final period = now.hour > 12 ? 'PM' : 'AM';

  return '$day/$month/$year $hour:$minute $period';
}





