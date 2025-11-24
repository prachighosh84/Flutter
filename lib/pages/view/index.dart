import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/pages/view/chats.dart';
import 'package:m2i_cours_flutter/pages/view/channels.dart';
import 'package:m2i_cours_flutter/pages/view/home.dart';

import 'package:m2i_cours_flutter/widgets/navbar/bottom_nav_bar.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List<StatefulWidget> pages = [
    Home(),
    ChatsPage(),
    Channels(),
  ];
  int pageIndex = 0;

  void changePage(int newIndex) {
    if (pageIndex != newIndex) {
      setState(() {
        pageIndex = newIndex;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: pages[pageIndex],
              ),
              BottomNavBar(func: changePage),
            ],
          ),
        ),
      ),
    );
  }

}
