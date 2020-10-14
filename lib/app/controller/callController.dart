import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/data/repository/firebaseRepository.dart';

enum ControllerState { initial, loading, done, error, done_call }

class CallController extends GetxController {
  UserModel model;
  CallController(this.model);

  final repository = FirebaseRepository();

  final _state = ControllerState.initial.obs;
  set loadingState(value) => this._state.value = value;
  get loadingState => this._state.value;

  Future<void> acceptCall(String mecanicId, String description) async {
    loadingState = ControllerState.loading;

    await repository
        .updateDataCollection(collection: 'mecanics', uid: mecanicId, newData: {
      'call': {
        'state': 'INVITED',
        'userId': model.user.uid,
        'message': description
      }
    });

    loadingState = ControllerState.done;
  }

  Future<void> refuseCall(String mecanicId) async {
    await repository.updateDataCollection(
        collection: 'mecanics', uid: mecanicId, newData: {'call': null});
  }

  Future<void> updateRating(
      DocumentSnapshot snapshot, description, rating) async {
    loadingState = ControllerState.loading;
    Map newUserdata = snapshot.data;

    if (rating > 0.0) {
      newUserdata['rating'] = (newUserdata['rating'] + rating) / 2;
    }

    newUserdata['call'] = null;

    await repository.updateDataCollection(
        collection: 'mecanics', uid: snapshot.documentID, newData: newUserdata);

    await repository.setDataCollection(collection: 'mecanics', data: {
      'rating': rating,
      'message': description,
      'nameUser': model.userData['name']
    });

    await repository.setDataCollection(collection: 'historic', data: {
      'data': DateTime.now(),
      'mecanic': snapshot.data['name'],
    });

    Get.offAndToNamed("/home");
  }
}
