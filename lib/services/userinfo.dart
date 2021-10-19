import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twistic/models/user.dart';
import 'package:twistic/services/utils.dart';

class UserService {
  UtilsService _utilsService = UtilsService();

  UserModel? _userFromFirebaseSnapshot(DocumentSnapshot? snapshot) {
    if (snapshot != null) {
      return UserModel(
        id: snapshot.id,
        name: snapshot['name'],
        profileImageUrl: snapshot['profileImageUrl'],
        bannerImageUrl: snapshot['bannerImageUrl'],
        email: snapshot['email'],
    );
    } else {
      return null ;
    }
  }
  List<UserModel> _userListFromSnapshot(QuerySnapshot? snapshot) {

    return snapshot!.docs.map((doc) {
      return UserModel(
        id: doc.id,
        name: (doc.data() as dynamic)['name'] ?? '',
        profileImageUrl: (doc.data() as dynamic)['profileImageUrl'] ?? '',
        bannerImageUrl: (doc.data() as dynamic)['bannerImageUrl'] ?? '',
        email: (doc.data() as dynamic)['email'] ?? '',
      );
    }).toList();

  }





  Stream<UserModel?> getUserInfo(uid) {
    return FirebaseFirestore.instance.collection("users").doc(uid).snapshots().map(_userFromFirebaseSnapshot);
  }

  Stream<List<UserModel>?> queryByName(search) {
    return FirebaseFirestore.instance
        .collection("users")
        .orderBy("name")
        .startAt([search])
        .endAt([search + '\uf8ff'])
        .limit(10)
        .snapshots()
        .map(_userListFromSnapshot);
  }

  Future<void> updateProfile(File _bannerImage, File _profileImage, String name) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    if (_bannerImage != null) {
      // save the image to storage
      bannerImageUrl = await _utilsService.uploadFile(
          _bannerImage, '/user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner');
    }

    if (_profileImage != null) {
      // save the image to storage
      profileImageUrl = await _utilsService.uploadFile(
          _profileImage, '/user/profile/${FirebaseAuth.instance.currentUser!.uid}/profile');
    }

    Map<String, Object> data = HashMap();
    if (name != '') {
      data['name'] = name;
    }
    if (_bannerImage != '') {
      data['bannerImageUrl'] = bannerImageUrl;
    }
    if (_profileImage != '') {
      data['profileImageUrl'] = profileImageUrl;
    }

    await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(data);
  }
}
