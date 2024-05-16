import 'package:flutter/material.dart';
import 'package:internal_communication_app/data/message.dart';
import 'package:http/http.dart' as http;

class MessagesPage extends StatefulWidget {
  MessagesPage({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  void markAsRead() {
    // Make HTTP request to your Ruby on Rails backend
    // Update the message as read
    String url = 'http://localhost:3000/api/v1/messages/${widget.message.id}';
    http.put(
      Uri.parse(url),
      body: {'read': 'true'},
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.message.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.message.content,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            // image
            if (widget.message.image != null)
              Image.network("http://localhost:3000${widget.message.image}"),

            
            ElevatedButton(
              onPressed: () {
                markAsRead();
                
              },
              child: const Text('Read'),
            ),
          ],
        ),
      ),
    );
  }
}
