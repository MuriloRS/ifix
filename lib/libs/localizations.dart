import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ifix/models/userModel.dart';

class Localization {
  Future<Map<String, double>> getInitialLocation(UserModel model) async {
    try {
      Position position = await getCurrentPosition();

      await Firestore.instance
          .collection('users')
          .document(model.user.uid)
          .updateData({
        'localization': {
          'latitude': position.latitude,
          'longitude': position.longitude
        }
      });

      model.userData['localization'] = {
        'latitude': position.latitude,
        'longitude': position.longitude
      };

      return {'latitude': position.latitude, 'longitude': position.longitude};
    } catch (ex) {
      print(ex.toString());

      return null;
    }
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }
}
