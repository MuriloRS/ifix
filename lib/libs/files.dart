import 'package:flutter/material.dart';
import 'dart:convert';

class Files {
  Future<List<String>> getCities(context) async {
    List<String> listCities = new List();

    try {
      String result = await DefaultAssetBundle.of(context)
          .loadString('assets/municipios.json');

      final parsed =
          json.decode(result.toString()).cast<Map<String, dynamic>>();

      parsed.forEach((m) => listCities.add(m['nome']));
    } catch (e) {
      print(e);
    }

    return listCities;
  }
}
