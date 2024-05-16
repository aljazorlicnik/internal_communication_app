import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internal_communication_app/components/message.dart';
import 'package:internal_communication_app/data/message.dart';
import 'package:internal_communication_app/pages/messages.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Message> messages = [];

  Future<void> loadMessages() async {
    final uri = Uri.parse("http://localhost:3000/api/v1/messages");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      final List<Message> messages =
          data.map((e) => Message.fromJson(e)).toList();
      setState(() {
        this.messages = messages;
      });
    } else {
      print('Failed to load messages');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onBuild();
    });
  }

  void onBuild() {
    loadMessages();
  }

  void onMessageTap(Message message) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MessagesPage(message: message);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            Message message = messages[index];
            return GestureDetector(
              onTap: () {
                onMessageTap(message);
              },
              child: messageBox(message.title, message.content),
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: messages.length),
    );
  }
}
