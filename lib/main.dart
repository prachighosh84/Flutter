import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:m2i_cours_flutter/providers/server_provider.dart';
import 'package:m2i_cours_flutter/providers/user_provider.dart';
import 'package:m2i_cours_flutter/screens/index.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ServerProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: IndexPage(),
    );
  }
}
