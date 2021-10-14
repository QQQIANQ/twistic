import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twistic/screens/main/posts/listposts.dart';
import 'package:twistic/services/posts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value:_postService.getPostsByUser(FirebaseAuth.instance.currentUser!.uid),
      child: Scaffold(
        body: Container(
          child: ListPosts(),
        ),
      ),
      initialData: null,
    );
  }
}
