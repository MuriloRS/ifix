import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ifix/app/data/provider/firebaseProvider.dart';
import 'package:meta/meta.dart';

class FirebaseRepository {
  final FirebaseProvider firebaseProvider = FirebaseProvider();

  createUser({@required String email, @required String password}) async {
    return await firebaseProvider.createUser(email: email, password: password);
  }

  getUser() async {
    return await firebaseProvider.getUser();
  }

  getUserData(uid) async {
    return await firebaseProvider.getUserData(uid);
  }

  userSignin({@required String email, @required String password}) async {
    await firebaseProvider.userSignin(email: email, password: password);
  }

  sendPasswordReset({@required String email}) async {
    await firebaseProvider.sendPasswordReset(email: email);
  }

  Future<QuerySnapshot> getMecanics(
      {String city = "Santa Cruz do Sul", double rating = 0}) async {
    return await firebaseProvider.getMecanics(city: city, rating: rating);
  }

  updateDataCollection(
      {@required String collection,
      @required String uid,
      @required Map<String, dynamic> newData}) async {
    await firebaseProvider.updateDataCollection(
        collection: collection, uid: uid, newData: newData);
  }

  setDataCollection(
      {@required String collection,
      @required Map<String, dynamic> data}) async {
    await firebaseProvider.setDataCollection(
        collection: collection, data: data);
  }

  getAllFromCollection({@required String collection}) async {
    return await firebaseProvider.getAllFromCollection(collection: collection);
  }

  deleteValueFromCollection(
      {@required String collection, @required String uid}) async {
    await firebaseProvider.deleteValueFromCollection(
        collection: collection, uid: uid);
  }
}
