Duration calculateTimeLeft(DateTime now) {
  if (now.isAfter(DateTime(now.year, now.month, now.day, 22, 0, 1)) ||
      now.isBefore(DateTime(now.year, now.month, now.day, 5, 30, 0))) {
    return Duration.zero;
  } else {
    final DateTime totaltime =
        DateTime(DateTime.now().year, now.month, now.day, 22, 0, 0);
    return totaltime.difference(now);
  }
}
