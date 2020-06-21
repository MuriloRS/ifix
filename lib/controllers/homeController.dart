import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:ifix/libs/api.service.dart';
import 'package:ifix/libs/dialogs.dart';
import 'package:ifix/libs/localizations.dart';
import 'package:ifix/libs/sqlite.dart';
import 'package:ifix/libs/utils.dart';
import 'package:ifix/models/userModel.dart';
import 'package:mobx/mobx.dart';
part "homeController.g.dart";

class HomeController = _HomeControllerBase with _$HomeController;
//flutter pub run build_runner watch
enum ControllerState { initial, loading, done, error, city_empty }

abstract class _HomeControllerBase with Store {
  final UserModel model;
  dynamic googleKey;
  final sqlite = new Sqlite();
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

  _getKeyGoogle() async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();

    googleKey = remoteConfig.getValue('api_google').asString();
  }

  @action
  Future<Map<String, dynamic>> getMecanicsFromGoogle(context) async {
    await _getKeyGoogle();

    List<Map<String, dynamic>> results = new List();
    Map<String, dynamic> result = new Map();

    Map<String, dynamic> userLocation =
        await new Localization().getInitialLocation(model);
    result['userLocation'] = userLocation;

    await sqlite.startDatabase({
      'lastModified': new DateTime.now().toString().split(' ').elementAt(0),
      'latitude': userLocation['latitude'],
      'longitude': userLocation['longitude']
    });

    List<Map<String, dynamic>> mecanicsFromFile =
        await getMecanicsDatabase(context);

    if (mecanicsFromFile.length == 0) {
      var googlePlace = GooglePlace(googleKey);

      NearBySearchResponse response = await googlePlace.search.getNearBySearch(
          Location(
              lat: userLocation['latitude'], lng: userLocation['longitude']),
          5000,
          keyword: 'oficina',
          language: 'pt-BR',
          type: 'car_repair');

      results.addAll(Utils.convertSearchResultToMap(response.results));

      if (response.nextPageToken != null) {
        await Future.doWhile(() async {
          response = await googlePlace.search.getNearBySearch(
              Location(
                  lat: userLocation['latitude'],
                  lng: userLocation['longitude']),
              5000,
              keyword: 'oficina',
              language: 'pt-BR',
              type: 'car_repair',
              pagetoken: response.nextPageToken);

          await Future.delayed(Duration(milliseconds: 1500));

          results.addAll(Utils.convertSearchResultToMap(response.results));

          if (response.nextPageToken == null) return false;
          return true;
        });
      }
    }

    result['mecanics'] =
        mecanicsFromFile.length == 0 ? results : mecanicsFromFile;

    if (results.length > 0) {
      await setMecanicsDatabase(results);
    }

    return result;
  }

  Future<List<Map<String, dynamic>>> getMecanicsDatabase(context) async {
    Map<String, dynamic> configs = await sqlite.getConfig();
    final geolocator = new Geolocator();

    //double latitude = -29.5076743;
    //double longitude = -52.572997; //configs['longitude'];
    double latitude = configs['latitude'];
    double longitude = configs['longitude'];

    double distanceBetweenLastLoad = await geolocator.distanceBetween(
        model.userData['localization']['latitude'],
        model.userData['localization']['longitude'],
        latitude,
        longitude);

    if (distanceBetweenLastLoad > 5000) {
      return [];
    } else {
      return await sqlite.getAllMecanics();
    }
  }

  Future<void> setMecanicsDatabase(List<Map<String, dynamic>> mecanics) async {
    await sqlite.insertMecanics(mecanics);
  }

  Future<void> getIconMarker() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(128, 128), devicePixelRatio: 5),
        'assets/flag.png');
  }

  Set<Marker> getMapMarkers(
      List<Map<String, dynamic>> mecanics, icon, context) {
    List<Marker> listMarkers = List();

    mecanics.forEach((Map<String, dynamic> m) {
      listMarkers.add(Marker(
          onTap: () {
            model.mecanicSelected = null;
            new Dialogs().showBottomSheetMecanic(m, context);
          },
          markerId: MarkerId(m['name']),
          position: LatLng(m['latitude'], m['longitude']),
          icon: icon));
    });

    return listMarkers.toSet();
  }

  Future<void> updateCity(city) async {
    model.userData['city'] = city;
    Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .updateData({'city': city});
  }
}
