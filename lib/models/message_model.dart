class Message {
  final String id;

  final String channelId;

  final String authorId;

  final String authorName;

  final String? authorAvatarUrl;

  final String content;

  final String createdAt;



  Message({
    required this.id,
    required this.channelId,
    required this.authorId,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.content,
    required this.createdAt

  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'].toString(),
      channelId: json['channelId'],
      authorId: json['channelId'],
      authorName: json['authorName'],
      authorAvatarUrl: json['authorAvatarUrl'],
      content: json['content'],
     createdAt:json['createdAt']
    );
  }
}