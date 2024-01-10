class SimpleReminder {
  int gap = 0;
  DateTime date;
  String description;
  int userUid;
  setGap(int num) {
    gap = num;
  }


  SimpleReminder(this.date, this.description,this.userUid)
      : gap = date
            .difference(DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day))
            .inDays;
  factory SimpleReminder.fromJson(Map<dynamic, dynamic> json) =>
      SimpleReminder(DateTime.parse(json['date']), json['description'],json['user_uid']);
}
