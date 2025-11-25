import 'package:flutter/material.dart';

import '../widgets/custom_form.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffddceec),
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: const CustomForm(),
    );
  }



}
