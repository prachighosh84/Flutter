import 'package:flutter/material.dart';

enum UserStatus { online, away, offline }

class ChatItem extends StatelessWidget {
  final String userName;
  final String message;
  final String time;
  final UserStatus status;
  final String? avatarUrl;

  const ChatItem({
    required this.userName,
    required this.message,
    required this.time,
    this.status = UserStatus.offline,
    this.avatarUrl,
    Key? key,
  }) : super(key: key);

  Color getStatusColor() {
    switch (status) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.away:
        return Colors.orange;
      case UserStatus.offline:
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage:
            avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null ? Text(userName[0]) : null,
          ),
          // Status indicator
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: getStatusColor(),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        userName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xffd5d5d5),
        ),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: Colors.white),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        time,
        style: const TextStyle(fontSize: 12, color: Colors.white60),
      ),
      onTap: () {
        // Navigate to chat detail page
      },
    );
  }
}
