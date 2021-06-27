import 'dart:convert';

import 'package:chat_app_sockets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chat_app_sockets/global/enviroments.dart';
import 'package:chat_app_sockets/models/login_response.dart';

class ResponseAuth {
  ResponseAuth(this.ok, this.msj);
  bool ok;
  String msj;
}

class AuthService with ChangeNotifier {
  late User user;

  bool _loading = false;

  bool get loadingAuth => this._loading;

  set setLoadingAuth(bool isLoading) {
    this._loading = isLoading;
    notifyListeners();
  }

  _changeLoadingState(bool value) {
    this._loading = value;
    notifyListeners();
  }

  Future<ResponseAuth> login(String email, String password) async {
    _changeLoadingState(true);
    final data = {"email": email, "password": password};
    final resp = await http.post(Uri.parse('${Enviroments.apiURL}/login'),
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});
    final loginresponse = loginResponseFromJson(resp.body);
    if (resp.statusCode == 200) {
      this.user = loginresponse.data!.user;
    }
    _changeLoadingState(false);
    return ResponseAuth(loginresponse.ok, loginresponse.msj);
  }
}
