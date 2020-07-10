import 'package:dio/dio.dart';

class ApiService {
  static Future<dynamic> httpRequestGet(url) async {
    try {
      Response response = await Dio().get(url);
      return response.data;
    } catch (e) {
      print(e);

      return null;
    }
  }
}