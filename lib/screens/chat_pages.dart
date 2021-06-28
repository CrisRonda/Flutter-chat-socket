import 'dart:io';

import 'package:chat_app_sockets/helpers/show_snack.dart';
import 'package:chat_app_sockets/models/message_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app_sockets/services/chat_service.dart';
import 'package:chat_app_sockets/services/auth_service.dart';
import 'package:chat_app_sockets/services/socket_service.dart';
import 'package:chat_app_sockets/widgets/chat_message.dart';
import 'package:chat_app_sockets/models/user.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _messageTxtController = TextEditingController();
  final Color colorHeader = Colors.black54;
  List<ChatMessage> _messages = [];
  bool _enableSendButton = false;
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;

  @override
  void initState() {
    super.initState();
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    this.socketService.socket.on("private-room", _subscribeToPrivateRoomChat);
    _loadMessages(this.chatService.userReceive.uid);
  }

  _subscribeToPrivateRoomChat(dynamic data) {
    ChatMessage newMessage = ChatMessage(
        message: data['message'],
        uid: data['uidSender'],
        animationController:
            AnimationController(vsync: this, duration: Duration(seconds: 1)));
    setState(() {
      _messages.insert(0, newMessage);
    });
    newMessage.animationController.forward();
  }

  _loadMessages(String uidReceiver) async {
    List<Message> chat = await this.chatService.getChat(uidReceiver);
    final history = chat.map((msg) => ChatMessage(
        message: msg.message,
        uid: msg.uidSender,
        animationController: AnimationController(
            vsync: this, duration: Duration(milliseconds: 500))
          ..forward()));
    setState(() {
      this._messages.insertAll(0, history);
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    this.socketService.socket.off("private-room");
    super.dispose();
  }

  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final User userToSendMessage = this.chatService.userReceive;

    return Scaffold(
      appBar: _appBar(userToSendMessage),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (_, i) => _messages[i])),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  AppBar _appBar(User user) {
    return AppBar(
      backgroundColor: this.colorHeader,
      centerTitle: true,
      title: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.amber,
            maxRadius: 14,
            child: Text(
              user.name.substring(0, 2),
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(user.name, style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }

  _inputChat() {
    var onPressedSendButton = _enableSendButton
        ? () => _handleSubmit(_messageTxtController.text)
        : null;
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: this._messageTxtController,
              onSubmitted: this._handleSubmit,
              onChanged: (text) => {
                setState(() {
                  _enableSendButton = text.trim().length > 0;
                })
              },
              decoration: InputDecoration.collapsed(hintText: "Mensaje"),
              focusNode: this._focusNode,
            ),
          ),
          Container(
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: onPressedSendButton, child: Text("Enviar"))
                : IconTheme(
                    data: IconThemeData(color: Colors.blue.shade200),
                    child: IconButton(
                      onPressed: onPressedSendButton,
                      icon: Icon(Icons.send),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      color: Colors.blue.shade200,
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String message) {
    if (message.trim().length == 0) {
      return;
    }
    if (this.socketService.serverStatus == ServerStatus.Offline) {
      return showSnackBar(
          context: context,
          title: "Lo sentimos, estamos fuera de linea",
          color: Colors.red.shade600);
    }
    final newMessage = ChatMessage(
      message: message,
      uid: authService.user.uid,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 432)),
    );
    this._messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _enableSendButton = false;
    });
    this.socketService.emit('private-room', {
      'uidSender': this.authService.user.uid,
      'uidReceiver': this.chatService.userReceive.uid,
      'message': message,
    });
    _messageTxtController.clear();
    _focusNode.requestFocus();
  }
}
