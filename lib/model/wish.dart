class Wish {
  int wid;
  int subject_useruid;
  String pub_date;
  String read;
  int object_useruid;
  String content;
  String update_date;
  String wish_pics;
  String status;
  String start_date;
  String? username;
  String? portrait;
  Wish(
      this.wid,
      this.subject_useruid,
      this.pub_date,
      this.read,
      this.object_useruid,
      this.content,
      this.status,
      this.wish_pics,
      this.start_date,
      this.update_date,
      this.username,
      this.portrait,
      );
  factory Wish.fromJson(Map<dynamic, dynamic> json) => Wish(//factory特殊地构造函数
      json['uid'],
      json['subject_useruid'],
      json['pub_date'],
      json['read'],
      json['object_useruid'],
      json['content'],
      json['status'],
      json['wish_pics'],
      json['start_date'],
      json['update_date'],
      json['username'],
      json['portrait']
  );
  Map toMap()=>{
        'uid':wid,
        'subject_useruid':subject_useruid,
        'pub_date':pub_date,
        'read':read,
        'object_useruid':object_useruid,
        'content':content,
        'status':status,
        'wish_pics':wish_pics,
        'start_date':start_date,
        'update_date':update_date,
        // 'username':username,
        // 'portrait':portrait,
  };
}
