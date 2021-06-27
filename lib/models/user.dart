import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.online,
    required this.name,
    required this.email,
    required this.uid,
  });

  bool online;
  String name;
  String email;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        online: json.containsKey("online") ? json["online"] : false,
        name: json.containsKey("name") ? json["name"] : '',
        email: json.containsKey("email") ? json["email"] : '',
        uid: json.containsKey("uid") ? json["uid"] : '',
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "name": name,
        "email": email,
        "uid": uid,
      };
}
