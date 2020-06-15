import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  Map userData;
  FirebaseUser user;
  Map<String, dynamic> mecanicSelected;

  UserModel(this.userData, this.user);

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}