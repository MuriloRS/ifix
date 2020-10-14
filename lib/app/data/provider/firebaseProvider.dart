import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

const baseUrl = 'http://gerador-nomes.herokuapp.com/nomes/10';

class FirebaseProvider {
  final Firestore firestore = Firestore();

  createUser({@required String email, @required String password}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: email.toString().trim(), password: password.toString().trim());

    return result;
  }

  getUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return await auth.currentUser();
  }

  getUserData(uid) async {
    return await Firestore.instance.collection('users').document(uid).get();
  }

  userSignin({@required String email, @required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  sendPasswordReset({@required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<QuerySnapshot> getMecanics(
      {String city = "Santa Cruz do Sul", double rating = 0}) async {
    return await Firestore.instance
        .collection('mecanics')
        .where('city', isEqualTo: city)
        .where('rating', isGreaterThan: rating)
        .getDocuments();
  }

  setDataCollection(
      {@required String collection,
      @required Map<String, dynamic> data}) async {
    await Firestore.instance.collection(collection).add(data);
  }

  updateDataCollection(
      {@required String collection,
      @required String uid,
      @required Map<String, dynamic> newData}) async {
    await Firestore.instance
        .collection('users')
        .document(uid)
        .updateData(newData);
  }

  getAllFromCollection({@required String collection}) async {
    return await Firestore.instance.collection(collection).getDocuments();
  }

  deleteValueFromCollection(
      {@required String collection, @required String uid}) async {
    await Firestore.instance.collection(collection).document(uid).delete();
  }
}
