import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twistic/screens/home/feed.dart';
import 'package:twistic/screens/home/search.dart';
import 'package:twistic/services/auth.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  int _currentIndex = 0;
  final List<Widget>  _children = [
    Feed(),
    Search(),
  ];

  void onTabPressed(int index){
    setState(() {
      _currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile',arguments: FirebaseAuth.instance.currentUser!.uid);
              },
            ),
            ListTile(
              title: Text("Edit"),
              onTap: (){
                Navigator.pushNamed(context, '/edit');
              },
            ),
            ListTile(
                title: Text('Log out'),
                onTap: () async {
                  _authService.signOut();
                }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        onTap: onTabPressed,
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: [BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}

