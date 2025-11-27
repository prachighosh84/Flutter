import 'package:flutter/material.dart';
import '../services/auth_service.dart';

// Define a custom Form widget.
class CustomForm extends StatefulWidget {
  const CustomForm({super.key});

  @override
  CustomFormState createState() {
    return CustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CustomFormState extends State<CustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  final _authService = AuthService();

  void loginUser() async {
    final result = await _authService.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (result == null) {
      print("Login success!");
    } else {
      print("Login failed: $result");
    }
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Expanded(
        child:  Container(
        decoration: BoxDecoration(
        color: Color(0xFF0f172b),
        borderRadius: BorderRadius.circular(2),
        ),


        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
            top: 24,
            bottom: 0,
            left: 24,
            right: 24,
          ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: Text("Sign In", style:TextStyle (color:Colors.white, fontSize: 24) ),
                  ),
                  Container(
                      padding: EdgeInsets.all( 16),

                      child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter your email",
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,


                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,

                          decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color:Color(0xff21c2ea),
                                    fontSize: 16,
                                  decoration: TextDecoration.underline,
                                  decorationColor:  Color(0xff21c2ea),     // underline color
                                  decorationThickness: 1,),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                loginUser();
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ),

                        Container(
                            padding: EdgeInsets.only(top: 24),
                            child: Row(
                            children: [
                              Text("Dont have an account?", style: TextStyle(color: Colors.white, fontSize: 16)),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    " Sign Up",
                                    style: TextStyle(color: Color(0xff21c2ea),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                      decorationColor:  Color(0xff21c2ea),     // underline color
                                      decorationThickness: 1,  ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ]
                    )
                  )
                ],
              )
          ),
        )
    )
    );
  }



}
