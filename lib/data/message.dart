class Message {
  int id;
  String title;
  String content;
  String? image;

  Message({required this.title, required this.content, required this.id});

  Message.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        id = json['id'],
        image = json['file']['url'];
}
