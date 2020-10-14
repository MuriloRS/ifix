import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpProvider {
  final http.Client httpClient = http.Client();

  getRequest(url) async {
    try {
      var response = await httpClient.get(url);

      Map<String, dynamic> jsonResponse = json.decode(response.body);

      return jsonResponse;
    } catch (_) {
      print(_);
    }
  }

  postRequest() async {
    try {} catch (e) {}
  }
}
