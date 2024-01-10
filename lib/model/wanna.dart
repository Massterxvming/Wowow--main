class Wanna {
  String wannaPics;
  String content;
  int userUid;
  int? wannaUid;
  String? pubDate;
  String? status;
  String? updateDate;
  Wanna(this.userUid, this.content, this.wannaPics,
      {this.wannaUid, this.status, this.pubDate, this.updateDate});

  factory Wanna.fromJson(Map<dynamic, dynamic> json) => Wanna(
        json['subject_useruid'],
        json['content'],
        json['wanna_pics'],
        wannaUid: json['uid'],
        status: json['status'],
        pubDate: json['pub_date'],
        updateDate: json['update_date'],
      );
  toMap() {
    return {
      'uid': wannaUid,
      'subject_useruid': userUid,
      'pub_date': pubDate,
      'wanna_pics': wannaPics,
      'content': content,
      'update_date': updateDate,
      'status': status
    };
  }
}
