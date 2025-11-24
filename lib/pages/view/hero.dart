import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/pages/view/index.dart';

class HeroPage extends StatefulWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  _HeroPageState createState() => _HeroPageState();
}

class _HeroPageState extends State<HeroPage> {
  // TODO: Add text editing controllers (101)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IndexPage()),
                  );
                },
                child: Image.asset(
                  'assets/logo.png',
                  width: 150,
                ),
              ),
              const SizedBox(height: 16.0),

            ],
          ),
        ),
      ),
    );
  }
}
