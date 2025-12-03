import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m2i_cours_flutter/models/user_model.dart';
import 'package:m2i_cours_flutter/providers/user_provider.dart';
import 'package:m2i_cours_flutter/screens/navigation/main_nav.dart';
import 'package:m2i_cours_flutter/screens/sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AuthGate extends StatelessWidget {


  const AuthGate({super.key});

   Future<void> setUserSharedPref(BuildContext context, User? user) async {

     final email  = user?.providerData.first.email??"";
    final userId = user?.providerData.first.uid??"";
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
    await prefs.setString('userDisplay', "Prachi");
    Provider.of<UserProvider>(context, listen: false).setUser(UserModel(userId: userId, userEmail: email));

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
          if(email !=null){
            setUserSharedPref(context, user);
          }
        //  Logged in → go to home screen
       // return MainNav(username:displayName, email:email ,);
        return MainNav();
      },
    );
  }
}
