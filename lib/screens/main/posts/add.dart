import 'package:flutter/material.dart';
import 'package:twistic/services/posts.dart';

class Add extends StatefulWidget {

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

  String text = "";

  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Add Tweet'),
    actions: <Widget>[
    TextButton(
    style: TextButton.styleFrom(
    primary: Colors.white,
    ),
    onPressed: () async {
      _postService.savePost(text);
      Navigator.pop(context);
    },
    child: const Text('Tweet '),
    )
    ],),
    body: Container(
    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
    child : Form(
        child: TextFormField(
        onChanged:(val){
          setState(() {
            text = val;
          });
        }),
    ),
    )
    );
  }
}
