import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/data/repository/firebaseRepository.dart';
import 'package:ifix/app/data/repository/sqliteRepository.dart';
import 'package:ifix/app/libs/dialogs.dart';
import 'package:ifix/app/libs/localizations.dart';
import 'package:ifix/app/libs/snackbar.dart';
import 'package:ifix/app/libs/utils.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeController extends GetxController {
  UserModel model;

  HomeController(this.model);

  final sqlite = new SqliteRepository();
  final firebase = new FirebaseRepository();

  dynamic mecanicSelected;

  Future<QuerySnapshot> getMecanics() async {
    return await firebase.getMecanics(
        city: model.userData['city'],
        rating: model.userData['configs']['rating']);
  }

  Future<Map<String, dynamic>> getMecanicsFromGoogle(context) async {
    try {
      List<Map<String, dynamic>> results = new List();
      Map<String, dynamic> result = new Map();

      Map<String, dynamic> userLocation;

      await checkUserPermission();

      //userLocation = {"latitude": -9.5942081, "longitude": -35.8267669};

      if (userLocation == null) {
        userLocation = await Localization().getInitialLocation(model);
      }

      result['userLocation'] = userLocation;

      await sqlite.startDatabase({
        'lastModified': new DateTime.now().toString().split(' ').elementAt(0),
        'latitude': userLocation['latitude'],
        'longitude': userLocation['longitude']
      });

      List<Map<String, dynamic>> mecanicsFromFile =
          await getMecanicsDatabase(context);

      if (mecanicsFromFile.length == 0) {
        var googlePlace = GooglePlace(model.googleKey);

        NearBySearchResponse response = await googlePlace.search
            .getNearBySearch(
                Location(
                    lat: userLocation['latitude'],
                    lng: userLocation['longitude']),
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
    } catch (e) {
      Snackbar.show(
          message:
              "Desculpe, ocorreu um erro ao buscar as oficinas, nosso time estará corrigindo o problema o mais breve possível.",
          color: Colors.black);

      _sendReport("ERRO AO BUSCAR AS OFICINAS: " + e.toString());

      return null;
    }
  }

  void _sendReport(error) {
    firebase.setDataCollection(collection: 'erros', data: {
      "user": this.model.user.uid,
      "date": DateTime.now(),
      "error": error
    });
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
        ImageConfiguration(size: Size(86, 86), devicePixelRatio: 999),
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

  Future<bool> checkUserPermission() async {
    if (await Permission.location.isGranted) {
      return true;
    }

    await Permission.location.request();
    return false;
  }

  Future<void> updateCity(city) async {
    model.userData['city'] = city;
    Firestore.instance
        .collection('users')
        .document(model.user.uid)
        .updateData({'city': city});
  }
}
