import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifix/models/userModel.dart';
import 'package:mobx/mobx.dart';
part "homeController.g.dart";

class HomeController = _HomeControllerBase with _$HomeController;
//flutter pub run build_runner watch
enum ControllerState {
  initial,
  loading,
  done,
  error,
}

abstract class _HomeControllerBase with Store {
  UserModel model;
  _HomeControllerBase(this.model);

  @observable
  ControllerState loadingState = ControllerState.initial;

  @observable
  dynamic mecanicSelected;

  @action
  Future<QuerySnapshot> getMecanics() {
    return Firestore.instance
        .collection('mecanics')
        .where('city', isEqualTo: model.userData['city'])
        .where('rating', isGreaterThan: model.userData['configs']['rating'])
        .getDocuments();
  }

  Set<Marker> getMapMarkers(QuerySnapshot mecanics) {
    List<Marker> listMarkers = List();

    mecanics.documents.forEach((m) {
      listMarkers.add(Marker(
          markerId: MarkerId(m['name']),
          position: LatLng(double.parse(m['localization']['latitude']),
              double.parse(m['localization']['longitude'])),
          icon: BitmapDescriptor.defaultMarker));
    });

    return listMarkers.toSet();
  }

  @action
  Future<dynamic> getMostNearMecanic(List<DocumentSnapshot> mecanics) async {
    loadingState = ControllerState.loading;

    dynamic mostNear;
    double mostNearDystance =9999999;
    final geolocator = new Geolocator();

    await Future.forEach(mecanics, (DocumentSnapshot m) async {
      double distance = await geolocator.distanceBetween(
          model.userData['localization']['latitude'],
          model.userData['localization']['longitude'],
          double.parse(m.data['localization']['latitude']),
          double.parse(m.data['localization']['longitude']));

      if (distance < mostNearDystance && (distance/1000) < model.userData['configs']['max_distance']) {
        mostNear = {'data': m.data, 'id': m.documentID};
        mostNearDystance = distance;
      }
    });

    loadingState = ControllerState.done;

    mecanicSelected = {'mecanic': mostNear, 'distance': mostNearDystance};
  }

  String formatDistance(double distance){
    return (distance/1000).toStringAsFixed(2) + ' km';
  }
}
