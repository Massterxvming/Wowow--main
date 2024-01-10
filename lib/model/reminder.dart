class Reminder {
  int reminderId;
  int userUId;
  int gap=0;
  DateTime date;
  String description;
  Reminder(this.reminderId, this.userUId, this.date, this.description):gap=(date.month-DateTime.now().month)*30+(date.day-DateTime.now().day);
  factory Reminder.fromJson(Map<dynamic, dynamic> json) => Reminder(
      json['reminder_uid'],
      json['user_uid'],
      DateTime.parse(json['date']),
      json['description']);
}
