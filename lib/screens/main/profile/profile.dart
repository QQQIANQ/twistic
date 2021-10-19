import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twistic/models/postmodel.dart';
import 'package:twistic/models/user.dart';
import 'package:twistic/screens/main/posts/listposts.dart';
import 'package:twistic/services/posts.dart';
import 'package:twistic/services/userinfo.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PostService _postService = PostService();
  UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    final  String uid =  ModalRoute.of(context)!.settings.arguments.toString();
    return MultiProvider(
        providers: [
          StreamProvider<List<PostModel>>.value(
            value: _postService.getPostsByUser(uid),
            initialData: [],
          ),
          StreamProvider<UserModel?>.value(
            value: _userService.getUserInfo(uid),
            initialData: null,
          )
        ],
        child: Scaffold(
            body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverAppBar(
                    floating: false,
                    pinned: true,
                    expandedHeight: 130,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Image.network(
                      Provider.of<UserModel>(context).bannerImageUrl ?? '',
                      fit: BoxFit.cover,
                    )),
                  ),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children :[
                              Provider.of<UserModel>(context).profileImageUrl != '' ?
                              CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(Provider.of<UserModel>(context).profileImageUrl ?? '')
                              ): Icon(Icons.person,size: 40),
                              SizedBox(width: 10,),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/edit');
                                },
                                child: Text("Edit Profile"))
                          ]),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                Provider.of<UserModel>(context).name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]))
                ];
              },
              body: ListPosts()),
        )));
  }
}
