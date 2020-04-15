import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:ifix/models/userModel.dart';
import 'package:mobx/mobx.dart';
part "loginController.g.dart";

class LoginController = _LoginControllerBase with _$LoginController;

enum ControllerState { initial, loading, done, error }

abstract class _LoginControllerBase with Store {
  @observable
  String name;
  @action
  changeName(dynamic newName) => name = newName;

  @observable
  String city;
  @action
  changeCity(dynamic newCity) => city = newCity;

  @observable
  String email;
  @action
  changeEmail(dynamic newValue) => email = newValue;

  @observable
  String phone;

  @action
  changePhone(dynamic newValue) => phone = newValue;

  @observable
  String errorMessage = '';

  @observable
  String password;

  @action
  changePassword(dynamic newValue) => password = newValue;

  @observable
  ControllerState stateLoading = ControllerState.initial;

  @observable
  bool isEmailVerified = false;

  @computed
  Map get newUser {
    return {"name": name, "email": email, "phone": phone, 'city': city};
  }

  @action
  Future<void> doRegister(UserModel model, String city) async {
    stateLoading = ControllerState.loading;

    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;

      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email.toString().trim(), password: password.toString().trim());

      if (result != null) {
        await result.user.sendEmailVerification();

        dynamic userModel = {
          'email': newUser['email'],
          'name': newUser['name'],
          'phone': newUser['phone'],
          'city': city,
          'created': DateTime.now(),
          'vehicle': '',
          'max_distance': 30,
          'notifications': false,
          'localization': null,
          'configs': {'rating':0.0, 'max_distance': 50, 'notifications':true}
        };

        await Firestore.instance
            .collection('users')
            .document(result.user.uid)
            .setData(userModel);

        model.userData = userModel;
        model.user = result.user;

        stateLoading = ControllerState.done;
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          errorMessage = "Esse email já está sendo usado";
        }
      } else {
        errorMessage = e.toString();
      }
      stateLoading = ControllerState.error;
    }
  }

  @action
  Future<void> verifyConfirmationEmail() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser currentUser = await auth.currentUser()..reload();

    if (currentUser.isEmailVerified) {
      isEmailVerified = true;
    } else {
      isEmailVerified = false;
    }
  }

  Future<Map> getUserData() async {
    FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();

    if (currentUser == null) {
      return null;
    }

    DocumentSnapshot snapshot = await Firestore.instance
        .collection('users')
        .document(currentUser.uid)
        .get();

    return {'userData': snapshot.data, 'user': currentUser};
  }
}
