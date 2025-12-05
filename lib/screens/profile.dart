import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF0f172b),
        body: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blueAccent,
                child:    Image.asset('assets/user2.png',

                ),
              ),
            ],

          )

          )
        );

  }
}