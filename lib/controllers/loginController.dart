import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:ifix/libs/utils.dart';
import 'package:ifix/models/userModel.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';
part "loginController.g.dart";

class LoginController = _LoginControllerBase with _$LoginController;

enum ControllerState {
  initial,
  loading,
  done,
  error,
  errorLogin,
  loadingLogin,
  loadingPassword,
  successRecoverPassword
}

abstract class _LoginControllerBase with Store {
  UserModel userModel;
  _LoginControllerBase(this.userModel);

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
  String errorMessage = '';

  @observable
  String password;

  @action
  changePassword(dynamic newValue) => password = newValue;

  @observable
  ControllerState stateLoading = ControllerState.initial;

  @observable
  bool isEmailVerified = false;

  @observable
  bool checkTerms = false;

  @computed
  Map get newUser {
    return {"name": name, "email": email, 'city': city};
  }

  @action
  Future<void> doRegister(UserModel model) async {
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
          'city': city,
          'created': DateTime.now(),
          'vehicle': '',
          'max_distance': 30,
          'notifications': false,
          'localization': null,
          'configs': {'rating': 0.0, 'max_distance': 50, 'notifications': true}
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
    FirebaseUser currentUser = await auth.currentUser()
      ..reload();

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

  @action
  Future<void> signIn(email, password) async {
    try {
      stateLoading = ControllerState.loadingLogin;

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      DocumentSnapshot userData =
          await Firestore.instance.collection('users').document(user.uid).get();

      userModel.userData = userData.data;
      userModel.user = user;

      stateLoading = ControllerState.done;
    } catch (e) {
      if(e.code=='ERROR_USER_NOT_FOUND'){
        errorMessage = "Esse email não está cadastrado na nossa base de dados, tente outro.";
      }else if(e.code == 'ERROR_WRONG_PASSWORD'){
        errorMessage = "Senha inválida";
      }
      stateLoading = ControllerState.errorLogin;
    }
  }

  @action
  Future<void> openTerms() async{
    await Utils.openTermos();
  }

  @action
  Future<void> recoverPassword(email) async {
    try {
      stateLoading = ControllerState.loadingPassword;

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      stateLoading = ControllerState.successRecoverPassword;
    } catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        errorMessage = 'Usuário não encontrado com esse email, tente outro.';
      }
      else{
        errorMessage = 'Email inválido';
      }
      stateLoading = ControllerState.errorLogin;
    }
  }
}
