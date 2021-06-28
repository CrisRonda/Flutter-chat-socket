// To parse this JSON data, do
//
//     final messagesResponse = messagesResponseFromJson(jsonString);

import 'dart:convert';

MessagesResponse messagesResponseFromJson(String str) => MessagesResponse.fromJson(json.decode(str));

String messagesResponseToJson(MessagesResponse data) => json.encode(data.toJson());

class MessagesResponse {
    MessagesResponse({
        required this.ok,
        required this.msj,
        required this.uid,
        required this.uidReceiver,
        required this.messages,
    });

    bool ok;
    String msj;
    String uid;
    String uidReceiver;
    List<Message> messages;

    factory MessagesResponse.fromJson(Map<String, dynamic> json) => MessagesResponse(
        ok: json["ok"],
        msj: json["msj"],
        uid: json["uid"],
        uidReceiver: json["uidReceiver"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msj": msj,
        "uid": uid,
        "uidReceiver": uidReceiver,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
    };
}

class Message {
    Message({
       required this.uidSender,
       required this.uidReceiver,
       required this.message,
       required this.createdAt,
       required this.updatedAt,
    });

    String uidSender;
    String uidReceiver;
    String message;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        uidSender: json["uidSender"],
        uidReceiver: json["uidReceiver"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "uidSender": uidSender,
        "uidReceiver": uidReceiver,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
