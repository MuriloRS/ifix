import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/data/repository/firebaseRepository.dart';
import 'package:ifix/app/libs/snackbar.dart';
import 'package:ifix/app/libs/utils.dart';

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

class LoginController extends GetxController {
  UserModel userModel;
  LoginController(this.userModel);
  FirebaseRepository repository = FirebaseRepository();

  final _name = "".obs;
  set name(value) => this._name.value = value;
  get name => this._name.value;

  final _city = "".obs;
  set city(value) => this._city.value = value;
  get city => this._city.value;

  final _email = "".obs;
  set email(value) => this._email.value = value;
  get email => this._email.value;

  final _errorMessage = "".obs;
  set errorMessage(value) => this._errorMessage.value = value;
  get errorMessage => this._errorMessage.value;

  final _password = "".obs;
  set password(value) => this._password.value = value;
  get password => this._password.value;

  final _stateLoading = ControllerState.initial.obs;
  set stateLoading(value) => this._stateLoading.value = value;
  get stateLoading => this._stateLoading.value;

  final _checkTerms = false.obs;
  set checkTerms(value) => this._checkTerms.value = value;
  get checkTerms => this._checkTerms.value;

  Map get newUser {
    return {"name": name, "email": email, 'city': city};
  }

  Future<void> doRegister(UserModel model) async {
    stateLoading = ControllerState.loading;

    try {
      AuthResult result = await repository.createUser(
          email: email.toString().trim(), password: password.toString().trim());

      if (result != null) {
        //await result.user.sendEmailVerification();

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

        await repository.setDataCollection(
            collection: 'users', data: userModel);

        model.userData = userModel;
        model.user = result.user;

        Get.offAndToNamed("/home");
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          errorMessage = "Esse email já está sendo usado";
        }
      } else {
        errorMessage = e.toString();
      }

      Snackbar.show(message: errorMessage, color: Colors.red);

      stateLoading = ControllerState.done;
    }
  }

  Future<void> verifyConfirmationEmail() async {
    FirebaseUser currentUser = await repository.getUser();

    if (currentUser.isEmailVerified) {
      Get.toNamed("/home");
    } else {
      Snackbar.show(
          message:
              "Você ainda não validou o seu email, verifique sua caixa de spam.",
          color: Colors.red);
    }
  }

  Future<Map> getUserData() async {
    FirebaseUser currentUser;

    try {
      currentUser = await repository.getUser();
    } catch (e) {
      print(e);
    }

    if (currentUser == null) {
      return null;
    }

    DocumentSnapshot snapshot = await repository.getUserData(currentUser.uid);

    return {'userData': snapshot.data, 'user': currentUser};
  }

  Future<void> signIn(email, password) async {
    try {
      stateLoading = ControllerState.loadingLogin;

      await repository.userSignin(email: email, password: password);

      FirebaseUser user = await repository.getUser();

      DocumentSnapshot userData = await repository.getUserData(user.uid);

      userModel.userData = userData.data;
      userModel.user = user;

      Get.offAndToNamed("/home");
    } catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        errorMessage =
            "Esse email não está cadastrado na nossa base de dados, tente outro.";
      } else if (e.code == 'ERROR_WRONG_PASSWORD') {
        errorMessage = "Senha inválida";
      }

      stateLoading = ControllerState.error;

      Snackbar.show(message: errorMessage, color: Colors.red);
    }
  }

  Future<void> openTerms() async {
    await Utils.openTermos();
  }

  Future<void> recoverPassword(email) async {
    try {
      stateLoading = ControllerState.loadingPassword;

      await repository.sendPasswordReset(email: email);

      stateLoading = ControllerState.successRecoverPassword;
    } catch (e) {
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        errorMessage = 'Usuário não encontrado com esse email, tente outro.';
      } else {
        errorMessage = 'Email inválido';
      }

      Snackbar.show(message: errorMessage, color: Colors.red);

      stateLoading = ControllerState.error;
    }
  }
}
