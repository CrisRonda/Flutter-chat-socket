import 'dart:io';

import 'package:chat_app_sockets/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _messageTxtController = TextEditingController();
  final Color colorHeader = Colors.black54;
  List<ChatMessage> _messages = [];
  bool _enableSendButton = false;

  @override
  void dispose() {
    // TODO: implement dispose to socket
    // clear _message[]
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
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

  AppBar _appBar() {
    return AppBar(
      backgroundColor: this.colorHeader,
      title: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.amber,
            maxRadius: 14,
            child: Text(
              "CR",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('Cristian Ronda', style: TextStyle(fontSize: 16))
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
    final newMessage = ChatMessage(
      message: message,
      uuid: '1234',
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 432)),
    );
    this._messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _enableSendButton = false;
    });
    _messageTxtController.clear();
    _focusNode.requestFocus();
  }
}
