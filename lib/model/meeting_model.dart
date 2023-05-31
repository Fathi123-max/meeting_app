class Meeting {
  final String title;
  final DateTime dateTime;
  final int duration;
  final List<String> attendees;
  final String agenda;

  Meeting({
    required this.title,
    required this.dateTime,
    required this.duration,
    required this.attendees,
    required this.agenda,
  });
}
