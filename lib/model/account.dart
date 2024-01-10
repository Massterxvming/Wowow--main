
class Account {
  String name;
  String token;
  int userUid;
  String qualiaId;
  String? portrait;
  String? password;
  String mobilePhone;

  Account(this.userUid, this.mobilePhone, this.password, this.qualiaId,
      this.name, this.portrait, this.token);
  factory Account.fromJson(Map<dynamic, dynamic> json) => Account(
      json['user_uid'],
      json['mobile_phone'],
      json['password'],
      json['qualia_id'],
      json['name'],
      json['portrait'],
      json['token']);
}
