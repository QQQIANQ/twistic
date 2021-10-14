import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{

  final String id;
  final String? creator;
  final String? text;
  final Timestamp? timestamp;

  PostModel({this.creator,this.text,this.timestamp, required this.id});
}
