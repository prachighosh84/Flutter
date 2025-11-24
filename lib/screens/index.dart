import 'package:flutter/material.dart';
import 'navigation/main_nav.dart';


class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainNav()),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 150,
              ),
              SizedBox(height: 20),
              Text('Tap to Enter', style: TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
