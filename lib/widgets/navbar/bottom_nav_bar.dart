import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/widgets/navbar/bottom_icon.dart';

class BottomNavBar extends StatelessWidget {
  final Function func;

  const BottomNavBar({
    super.key,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(),
        Row(
          mainAxisAlignment: .spaceAround,
          children: [
            BottomIcon(
              icon: Icons.home,
              text: "Home",
              func: () => func(0),
            ),
            BottomIcon(
              icon: Icons.chat,
              text: "Chats",
              func: () => func(1),
            ),

            BottomIcon(
              icon: Icons.notifications,
              text: "Channels",
              func: () => func(2),
            ),
          ],
        ),
      ],
    );
  }
}
