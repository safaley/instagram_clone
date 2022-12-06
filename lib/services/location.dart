import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Location {
  String? cityName;
  String? countryName;
  Future<void> getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var response = await http.get(Uri.parse(
          'https://api.bigdatacloud.net/data/reverse-geocode-client?latitude=${position.latitude}&longitude=${position.longitude}'));
      var data = jsonDecode(response.body);
      cityName = data['city'];
      countryName = data['countryCode'];
    } catch (e) {
      print(e);
    }
  }
}
