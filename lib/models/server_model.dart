class Server {
  final String id;
  final String ownerId;
  final String name;
  final String? imageUrl;


  Server({required this.id, required this.name,required this.ownerId,this.imageUrl});

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      id: json['id'].toString(),
      name: json['name'],
      ownerId: json['ownerId'],
      imageUrl: json['imageUrl'],

    );
  }
}