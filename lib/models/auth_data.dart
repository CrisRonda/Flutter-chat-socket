
import 'package:chat_app_sockets/models/user.dart';

class Data {
  Data({
    required this.user,
    required this.token,
  });

  User user;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json.containsKey("user")
            ? User.fromJson(json["user"])
            : User.fromJson({}),
        token: json.containsKey("token") ? json["token"] : "",
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}
