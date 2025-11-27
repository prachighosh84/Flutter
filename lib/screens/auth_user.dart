import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m2i_cours_flutter/screens/navigation/main_nav.dart';
import 'package:m2i_cours_flutter/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthGate extends StatelessWidget {

  const AuthGate({super.key});

   Future<void> setUserSharedPref(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
    await prefs.setString('userDisplay', "Prachi");
   }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?> (
      stream: FirebaseAuth.instance.authStateChanges(), // listens to login state
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        //  Not logged in → go to login screen
        if (!snapshot.hasData) {
          return SignInPage();
        }


          final user  = snapshot.data;
          final email  = user?.providerData.first.email;
          final displayName = "Prachi";
          if(email !=null){
            setUserSharedPref( email);
          }
        //  Logged in → go to home screen
        return MainNav(username:displayName, email:email ,);
      },
    );
  }
}
