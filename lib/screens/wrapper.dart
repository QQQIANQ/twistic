import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twistic/models/user.dart';
import 'package:twistic/screens/auth/signup.dart';
import 'package:twistic/screens/main/home.dart';
import 'package:twistic/screens/main/posts/add.dart';
import 'package:twistic/screens/main/profile/edit.dart';
import 'package:twistic/screens/main/profile/profile.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user == null) {
      //show auth system routes
      return SignUp();
    }
    //show main system rtoutes
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/add': (context) => Add(),
        '/profile': (context) => Profile(),
        '/edit' : (context) => Edit(),
      }
    );
  }
}
