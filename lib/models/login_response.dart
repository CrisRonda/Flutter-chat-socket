import 'dart:convert';

import 'package:chat_app_sockets/models/user.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok = false,
    this.msj = '',
    this.data,
  });

  bool ok;
  String msj;
  Data? data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        msj: json["msj"],
        data: json.containsKey("data")
            ? Data.fromJson(json["data"])
            : Data.fromJson({}),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": msj,
        "data": data!.toJson(),
      };
}

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
