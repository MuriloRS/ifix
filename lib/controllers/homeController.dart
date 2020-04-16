import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifix/models/userModel.dart';
import 'package:mobx/mobx.dart';
part "homeController.g.dart";

class HomeController = _HomeControllerBase with _$HomeController;
//flutter pub run build_runner watch
enum ControllerState { initial, loading, done, error, city_empty }

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

  Future<void> getIconMarker() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(128, 128), devicePixelRatio: 5),
        'assets/flag.png');
  }

  Set<Marker> getMapMarkers(QuerySnapshot mecanics, icon) {
    List<Marker> listMarkers = List();
    final geolocator = new Geolocator();

    mecanics.documents.forEach((m) {
      listMarkers.add(Marker(
          onTap: () async {
            loadingState = ControllerState.loading;

            this.mecanicSelected = {
              'mecanic': {'id': m.documentID, 'data': m.data},
              'distance': await getDistance(geolocator, m)
            };
            loadingState = ControllerState.done;
          },
          markerId: MarkerId(m['name']),
          position: LatLng(double.parse(m['localization']['latitude']),
              double.parse(m['localization']['longitude'])),
          icon: icon));
    });

    return listMarkers.toSet();
  }

  @action
  Future<dynamic> getMostNearMecanic(List<DocumentSnapshot> mecanics) async {
    loadingState = ControllerState.loading;

    if (model.userData['city'] == null) {
      loadingState = ControllerState.city_empty;
      return null;
    }

    dynamic mostNear;
    double mostNearDystance = 9999999;
    final geolocator = new Geolocator();

    await Future.forEach(mecanics, (DocumentSnapshot m) async {
      double distance = await getDistance(geolocator, m);

      if (distance < mostNearDystance &&
          (distance / 1000) < model.userData['configs']['max_distance']) {
        mostNear = {'data': m.data, 'id': m.documentID};
        mostNearDystance = distance;
      }
    });

    loadingState = ControllerState.done;

    mecanicSelected = {'mecanic': mostNear, 'distance': mostNearDystance};
  }

  Future<dynamic> getDistance(geolocator, mecanic) async {
    return await geolocator.distanceBetween(
        model.userData['localization']['latitude'],
        model.userData['localization']['longitude'],
        double.parse(mecanic.data['localization']['latitude']),
        double.parse(mecanic.data['localization']['longitude']));
  }

  String formatDistance(double distance) {
    return (distance / 1000).toStringAsFixed(2) + ' km';
  }

  Future<void> updateCity(city) async {
    model.userData['city'] = city;
    Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .updateData({'city': city});
  }
}
