import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twistic/models/user.dart';
import 'package:twistic/screens/wrapper.dart';
import 'package:twistic/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text("Error");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {

          return StreamProvider<UserModel?>.value(
            value: AuthService().user,
            child: MaterialApp(home: Wrapper(),),
            initialData: null,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Text("Loading",textDirection: TextDirection.ltr,);
      },
    );
  }
}
