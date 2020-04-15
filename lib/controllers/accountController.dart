import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifix/models/userModel.dart';
import 'package:ifix/widgets/dialog_delete_account.dart';
import 'package:mobx/mobx.dart';
part "accountController.g.dart";

class AccountController = _AccountControllerBase with _$AccountController;

enum ControllerState { initial, loading, done, error }

abstract class _AccountControllerBase with Store {
  UserModel model;
  _AccountControllerBase(this.model);

  @observable
  ControllerState loadingState = ControllerState.initial;

  @action
  Future<void> saveField(value, field) async {
    loadingState = ControllerState.loading;

    Map newData = model.userData;

    switch (field) {
      case 'name':
        newData['name'] = value;
        break;
      case 'email':
        newData['email'] = value;
        break;
      case 'phone':
        newData['phone'] = value;
        break;
      case 'city':
        newData['city'] = value;
        break;
    }

    model.userData = newData;

    await Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .updateData(newData);

    loadingState = ControllerState.done;
  } 

  Future<void> deleteAccountData() async {

    await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: model.user.email, password: '1364738p');

    await Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .collection('historic')
        .getDocuments()
        .then((historics) {
      Future.forEach(historics.documents, (doc) {
        doc.reference.delete();
      });
    });

    await Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .delete();

    await model.user.delete();

    model.user = null;
    model.userData = null;
  }

  @action
  Future<void> deleteAccount(context) async {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogDeleteAccount(this);
        });
  }
}
