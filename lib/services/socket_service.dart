
import 'package:chat/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => this._serverStatus;

  IO.Socket? get socket => this._socket;
  Function get emit => this._socket!.emit;

  void connect() async {

    final token = await AuthService.getToken();

    // Dart client
    this._socket = IO.io(
        'http://192.168.100.92:3000/',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM// optional
            .enableForceNew()
            .enableAutoConnect()
            .setExtraHeaders({
                'x-token': token
             })
            .build()
    );

    this._socket!.onConnect((_) {
      // ignore: unnecessary_this
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket!.onDisconnect((_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }
  void disconnect() {
    this._socket!.disconnect();
  }

}