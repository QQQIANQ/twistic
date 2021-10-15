import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twistic/services/utils.dart';

class UserService {
  UtilsService _utilsService = UtilsService();

  Future<void> updateProfile(File _bannerImage, File _profileImage, String name) async {
    String bannerImageUrl = '';
    String profileImageUrl = '';

    if (_bannerImage != null) {
      // save the image to storage
        bannerImageUrl = await _utilsService.uploadFile(_bannerImage, '/user/profile/${FirebaseAuth.instance.currentUser!.uid}/banner');
    }

    if (_profileImage != null) {
      // save the image to storage
      profileImageUrl = await _utilsService.uploadFile(_profileImage, '/user/profile/${FirebaseAuth.instance.currentUser!.uid}/profile');

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

    await FirebaseFirestore
        .instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);
  }
}
