import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:m2i_cours_flutter/api/server_api.dart';
import 'package:m2i_cours_flutter/models/server_model.dart';
import 'package:m2i_cours_flutter/providers/server_provider.dart';
import 'package:m2i_cours_flutter/providers/user_provider.dart';
import 'package:m2i_cours_flutter/screens/channels.dart';
import 'package:m2i_cours_flutter/screens/home_page.dart';
import 'package:m2i_cours_flutter/screens/chats.dart';
import 'package:m2i_cours_flutter/screens/navigation/features/add_server.dart';
import 'package:m2i_cours_flutter/screens/profile.dart';
import 'package:m2i_cours_flutter/widgets/bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sign_in.dart';

class MainNav extends StatefulWidget {
  final int initialIndex;


  MainNav({int? initialIndex, Key? key})
      : initialIndex = initialIndex ?? 0,
        super(key: key);

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int currentIndex = 0;
  String? userDisplay ='';
  late Future<List<Server>> serverList;

  late List<Server> servers ;

  int serverCount = 0;
  final serverApiService = ServerServiceApi();

  final List<Widget> pages = [
    HomePage(),   // Page  0
    ChatsPage(),  // Page 1
   // ChannelsPage(), // Page 2
    ProfilePage() // Page 2
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = (widget.initialIndex >= 0 && widget.initialIndex < pages.length)
        ? widget.initialIndex
        : 0;
    serverList = serverApiService.fetchServers().then((servers) {
      setState(() {
        serverCount = servers.length;  // updated when data arrives
      });
      return servers;
    });

  }

  void onTabSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
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
                if(user?.userEmail == null){
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
                    user?.userEmail == null?'SignIn':'Logout',
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
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              // ---------- Drawer Header ----------
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF0f172b),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                        children: [
                           CircleAvatar(
                           radius: 28,
                           backgroundColor: Colors.white,
                           child: Icon(Icons.network_ping, size: 30, color: Color(0xFF0f172b)),
                ),
                SizedBox(width: 12),
                Text(
                  "Servers ($serverCount)",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ]
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) =>  AddNewServer(),
                ),
              );
            },
            child: Icon(Icons.add, color: Colors.white,)
            ,
          ),
        ],
      ),

              ),
              // ---------- Server List ----------
              Expanded(
                child: FutureBuilder<List<Server>>(
                  future: serverList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text("No servers available"));
                    }

                    final servers = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: servers.length,
                      itemBuilder: (context, index) {
                        final server = servers[index];

                        return ListTile(
                          leading: Icon(Icons.tag, color: Colors.black87),
                          title: Text(server.name),

                          trailing: IconButton(
                            icon: Icon(Icons.share, color: Colors.black87),
                            onPressed: () async {
                              final service = ServerServiceApi();
                              print("serverId using invite link: ${server.id}");
                              try {
                                final inviteLink = await service.generateInviteLink(server.id);

                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Invite Link"),
                                    content: SelectableText(inviteLink),
                                    actions: [
                                      TextButton(
                                        child: Text("Copy"),
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(text: inviteLink));
                                          Navigator.pop(context);

                                          // Optional: Show a snackbar confirming copy
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Link copied to clipboard")),
                                          );
                                        },
                                      ),
                                      TextButton(
                                        child: Text("Close"),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );

                              } catch (e) {
                                print("Error: $e");
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to generate invite link")),
                                );
                              }
                            },
                          ),

                          onTap: () {
                            context.read<ServerProvider>().setSelectedServer(server);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => ChannelsPage()),
                            );
                          },
                        );

                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),


      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onTabSelected,
      ),
    );
  }
}
