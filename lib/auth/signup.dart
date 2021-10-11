import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twistic/services/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _authService = AuthService();

  String email = "";
  String password = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 8,
        title: const Text("Sign Up"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Form(
            child: Column(
          children: [
            TextFormField(
                onChanged: (val) => setState(() {
                      email = val;
                    })),
            TextFormField(
                onChanged: (val) => setState(() {
                      password = val;
                    })),
            ElevatedButton(
              child: const Text("Sign Up"),
              onPressed: () async => {_authService.signIn(email, password)},
            ),
            ElevatedButton(
              child: const Text("Sign In"),
              onPressed: () async => {_authService.signUp(email, password)},
            ),
          ],
        )),
      ),
    );
  }
}
