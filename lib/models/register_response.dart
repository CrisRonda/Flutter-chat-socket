import 'dart:convert';

import 'package:chat_app_sockets/models/auth_data.dart';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.ok = false,
    this.msj = '',
    this.data,
  });

  bool ok;
  String msj;
  Data? data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        ok: json["ok"],
        msj: json["msj"],
        data: json.containsKey("data")
            ? Data.fromJson(json["data"])
            : Data.fromJson({}),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": msj,
        "data": data,
      };
}
