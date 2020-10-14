import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/data/repository/firebaseRepository.dart';
import 'package:ifix/app/libs/snackbar.dart';

enum ControllerState { initial, loading, done, error }

class ConfigController extends GetxController {
  UserModel model;
  ConfigController(this.model);

  final firebase = FirebaseRepository();

  final _state = ControllerState.initial.obs;
  set loadingState(value) => this._state.value = value;
  get loadingState => this._state.value;

  Future<void> saveField(value, field) async {
    loadingState = ControllerState.loading;

    Map newData = model.userData;

    switch (field) {
      case 'vehicle':
        newData['configs']['vehicle'] = value;
        break;
      case 'rating':
        newData['configs']['rating'] = value;
        break;
      case 'max_distance':
        newData['configs']['max_distance'] = value;
        break;
      case 'notifications':
        newData['configs']['notifications'] = value;
        break;
    }

    model.userData = newData;

    await firebase.updateDataCollection(
        collection: "users", uid: model.user.uid, newData: newData);

    Snackbar.show(message: "Campo salvo com sucesso", color: Colors.green);
  }
}
