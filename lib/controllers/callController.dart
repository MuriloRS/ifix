import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifix/models/userModel.dart';
import 'package:mobx/mobx.dart';
part "callController.g.dart";

class CallController = _CallControllerBase with _$CallController;

enum ControllerState { initial, loading, done, error, done_call }

abstract class _CallControllerBase with Store {
  UserModel model;
  _CallControllerBase(this.model);

  @observable
  ControllerState stateLoading = ControllerState.initial;

  @action
  Future<void> acceptCall(String mecanicId, String description) async {
    stateLoading = ControllerState.loading;

    await Firestore.instance
        .collection('mecanics')
        .document(mecanicId)
        .updateData({
      'call': {
        'state': 'INVITED',
        'userId': model.user.uid,
        'message': description
      }
    });

    stateLoading = ControllerState.done;
  }

  @action
  Future<void> refuseCall(String mecanicId) async {
    await Firestore.instance
        .collection('mecanics')
        .document(mecanicId)
        .updateData({'call': null});
  }

  @action
  Future<void> updateRating(
      DocumentSnapshot snapshot, description, rating) async {
    stateLoading = ControllerState.loading;
    Map newUserdata = snapshot.data;

    if (rating > 0.0) {
      newUserdata['rating'] = (newUserdata['rating'] + rating) / 2;
    }

    newUserdata['call'] = null;

    await Firestore.instance
        .collection('mecanics')
        .document(snapshot.documentID)
        .updateData(newUserdata);
    await Firestore.instance
        .collection('mecanics')
        .document(snapshot.documentID)
        .collection('ratings')
        .add({
      'rating': rating,
      'message': description,
      'nameUser': model.userData['name']
    });

    await Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .collection('historic')
        .add({
      'data': DateTime.now(),
      'mecanic': snapshot.data['name'],
    });

    stateLoading = ControllerState.done_call;
  }
}
