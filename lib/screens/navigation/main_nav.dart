import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/screens/channels.dart';
import 'package:m2i_cours_flutter/screens/home_page.dart';
import 'package:m2i_cours_flutter/screens/chats.dart';
import 'package:m2i_cours_flutter/screens/profile.dart';
import 'package:m2i_cours_flutter/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sign_in.dart';

class MainNav extends StatefulWidget {
  final int initialIndex;
  final String? username;
  final String? email;


  MainNav({int? initialIndex,required this.username, required this.email, Key? key})
      : initialIndex = initialIndex ?? 0,
        super(key: key);

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int currentIndex = 0;
  String? userDisplay ='';


  final List<Widget> pages = [
    HomePage(),   // Page  0
    ChatsPage(),  // Page 1
    ChannelsPage(), // Page 2
    ProfilePage() // Page 3
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = (widget.initialIndex >= 0 && widget.initialIndex < pages.length)
        ? widget.initialIndex
        : 0;
    getUserSharedPref();
  }

  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  Future<void> getUserSharedPref() async {
    final userPref = await SharedPreferences.getInstance();
   final display =  await userPref.getString('userDisplay');
   setState(() {
     userDisplay = display;
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.blueAccent,
                  child:    Image.asset(
                    'assets/user2.png',
                    width: 150,
                  ),
                ),
                // Status indicator
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 12),
            Expanded(
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(                   // add border
                    color: Color(0xff3b3b3c),          // border color
                    width: .5,                         // border width
                  ),
                ),
                child: Row(
                  children: [

                    const Icon(Icons.search, color: Color(0xFF0f172b)),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),

            GestureDetector(
              onTap: ()async {
                if(widget.email == null){
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>  SignInPage(),
                    ),
                  );
                }
                else{
                  await FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) =>  SignInPage(),
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  Icon(Icons.exit_to_app, color: Color(0xFF0f172b)),
                  Text(
                    widget.email == null?'SignIn':'Logout',
                    style: TextStyle(color: Color(0xFF0f172b),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      ),
                  ),
                ],
              )

            ),
          ],
        ),
      ),

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
