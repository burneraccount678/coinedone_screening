String durationToString(int durationinSeconds) {
  final duration = Duration(seconds: durationinSeconds);
  if (duration.inHours == 0) {
    return "${duration.inMinutes % 60}m";
  }
  if (duration.inMinutes % 60 == 0) {
    return "${duration.inHours}h";
  }
  return "${duration.inHours}h ${duration.inMinutes % 60}m";
}
