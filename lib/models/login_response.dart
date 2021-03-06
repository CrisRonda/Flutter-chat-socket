import 'dart:convert';

import 'package:chat_app_sockets/models/auth_data.dart';

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
