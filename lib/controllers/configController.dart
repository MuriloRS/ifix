import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifix/models/userModel.dart';
import 'package:mobx/mobx.dart';
part "configController.g.dart";

class ConfigController = _ConfigControllerBase with _$ConfigController;

enum ControllerState { initial, loading, done, error }

abstract class _ConfigControllerBase with Store {
  UserModel model;
  _ConfigControllerBase(this.model);

  @observable
  ControllerState loadingState = ControllerState.initial;

  @action
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

    await Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .updateData(newData);

    loadingState = ControllerState.done;

  }
}
