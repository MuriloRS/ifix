import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ifix/app/data/model/userModel.dart';
import 'package:ifix/app/data/repository/firebaseRepository.dart';
import 'package:ifix/app/data/repository/httpRepository.dart';
import 'package:ifix/app/libs/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

enum ControllerState { initial, loading, done, error, city_empty }

class MecanicController extends GetxController {
  final UserModel model;
  final geolocator = new Geolocator();

  final FirebaseRepository userRepository = FirebaseRepository();
  final HttpRepository mechanicRepository = HttpRepository();

  MecanicController({this.model});

  final _state = ControllerState.initial.obs;
  set loadingState(value) => this._state.value = value;
  get loadingState => this._state.value;

  Future<dynamic> getBottomSheetInitialData(Map<String, dynamic> data) async {
    dynamic mecanicData = await _getDataFromMecanic(data);
    dynamic distance = await geolocator.distanceBetween(
        model.userData['localization']['latitude'],
        model.userData['localization']['longitude'],
        data['latitude'],
        data['longitude']);

    mecanicData['latitude'] = data['latitude'];
    mecanicData['longitude'] = data['longitude'];

    return {
      'mecanic': {'id': data["placeId"], 'data': mecanicData},
      'distance': Utils.formatDistance(distance)
    };
  }

  Future<Map<String, dynamic>> _getDataFromMecanic(mecanic) async {
    RemoteConfig remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();

    dynamic googleKey = remoteConfig.getValue('api_google').asString();

    dynamic result = await mechanicRepository.getDataFromMechanic(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=${mecanic['placeid']}&fields=formatted_phone_number,website,opening_hours,review&key=$googleKey&language=pt-BR");

    return {
      'telephone': result["result"]["formatted_phone_number"],
      'formattedAddress': mecanic['formattedAddress'],
      'name': mecanic['name'],
      'rating': mecanic['rating'],
      'nRating': mecanic['nRating'],
      'website': mecanic['website'],
      'open_now': result['result']['opening_hours'] != null
          ? result['result']['opening_hours']['open_now']
          : null,
      'weekday_text': result['result']['opening_hours'] != null
          ? result['result']['opening_hours']['weekday_text']
          : null,
      'reviews': result['result']['reviews'],
    };
  }

  Future<void> callNumber(phoneNumber) async {
    await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  Future<void> launchWhatsApp(phone) async {
    phone = Utils.formatPhone(phone);
    final link = WhatsAppUnilink(
      phoneNumber: '+55$phone',
      text:
          "Olá meu nome é ${model.userData['name']}, encontrei sua Mecânica através do aplicativo iFix, quero agendar um horário por favor.",
    );

    await launch('$link');
  }

  launchWebsite(website) async {
    if (await canLaunch(website)) {
      await launch(website);
    } else {
      throw 'Could not launch $website';
    }
  }

  openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
