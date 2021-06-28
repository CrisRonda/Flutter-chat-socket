import 'dart:convert';

import 'package:chat_app_sockets/models/user.dart';

UsersListResponse usersListResponseFromJson(String str) =>
    UsersListResponse.fromJson(json.decode(str));

String usersListResponseToJson(UsersListResponse data) =>
    json.encode(data.toJson());

class UsersListResponse {
  UsersListResponse({
    this.ok = false,
    this.msj = '',
    this.data,
  });

  bool ok; 
  String msj;
  Data? data;

  factory UsersListResponse.fromJson(Map<String, dynamic> json) =>
      UsersListResponse(
        ok: json["ok"],
        msj: json["msj"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": msj,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.users = const [],
  });

  List<User> users;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        users: json.containsKey('users')
            ? List<User>.from(json["users"].map((x) => User.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
