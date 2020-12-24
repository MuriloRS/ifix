import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  Map userData;
  FirebaseUser user;
  Map<String, dynamic> mecanicSelected;
  String googleKey;

  UserModel(this.userData, this.user);

  setGoogleKey(googleKey) {
    this.googleKey = googleKey;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
