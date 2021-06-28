import 'dart:convert';

import 'package:chat_app_sockets/models/auth_response.dart';
import 'package:chat_app_sockets/models/register_response.dart';
import 'package:chat_app_sockets/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app_sockets/global/enviroments.dart';
import 'package:chat_app_sockets/models/login_response.dart';



class AuthService with ChangeNotifier {
  late User user;
  final _storage = new FlutterSecureStorage();

  bool _loading = false;

  bool get loadingAuth => this._loading;

   _changeLoadingState(bool value) {
    this._loading = value;
    notifyListeners();
  }


  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: "token");
    return token;
  }

  static Future<String?> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: "token");
  }

  set setLoadingAuth(bool isLoading) {
    this._loading = isLoading;
    notifyListeners();
  }

  Future<AuthResponse> login(String email, String password) async {
    _changeLoadingState(true);
    final data = {"email": email, "password": password};
    final resp = await http.post(Uri.parse('${Enviroments.apiURL}/login'),
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});
    final loginresponse = loginResponseFromJson(resp.body);
    if (resp.statusCode == 200) {
      this.user = loginresponse.data!.user;
      await _saveToken(loginresponse.data!.token);
    }
    _changeLoadingState(false);
    return AuthResponse(loginresponse.ok, loginresponse.msj);
  }

  Future _saveToken(String token) async {
    await _storage.write(key: "token", value: token);
  }

   Future<AuthResponse> register(String name,String email, String password) async {
    _changeLoadingState(true);
    final data = {"name":name, "email": email, "password": password};
    final resp = await http.post(Uri.parse('${Enviroments.apiURL}/login/new'),
        body: jsonEncode(data), headers: {'Content-type': 'application/json'});
    final registerResponse = registerResponseFromJson(resp.body);
    _changeLoadingState(false);
    return AuthResponse(registerResponse.ok, registerResponse.msj);
  }

}
