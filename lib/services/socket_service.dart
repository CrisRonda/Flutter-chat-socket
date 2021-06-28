import 'package:chat_app_sockets/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:chat_app_sockets/global/enviroments.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();

    this._socket = IO.io(
        Enviroments.socketURL,
        IO.OptionBuilder()
            .enableAutoConnect()
            .enableForceNew()
            .setTransports(['websocket']).setExtraHeaders({
          'x-token': token,
        }).build());

    this._socket.onConnect((_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.onConnectError((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.onConnectTimeout((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
