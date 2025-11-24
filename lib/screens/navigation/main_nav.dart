import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/screens/home_page.dart';
import 'package:m2i_cours_flutter/screens/chats.dart';
import 'package:m2i_cours_flutter/screens/profile.dart';
import 'package:m2i_cours_flutter/widgets/bottom_nav_bar.dart';

class MainNav extends StatefulWidget {
  final int initialIndex; // non-nullable

  MainNav({int? initialIndex, Key? key})
      : initialIndex = initialIndex ?? 0, // default to 0 if null
        super(key: key);

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),   // index 0
    ChatsPage(),  // index 1
    ProfilePage() // index 2
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = (widget.initialIndex >= 0 && widget.initialIndex < pages.length)
        ? widget.initialIndex
        : 0;
  }

  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onTabSelected,
      ),
    );
  }
}
