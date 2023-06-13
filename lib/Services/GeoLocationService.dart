import 'dart:convert';
import 'package:alisveris/Models/UserLocation.dart';
import 'package:http/http.dart' as http;

Future<UserLocation> GetUserLocation() async{
  String geoJsURL = 'https://get.geojs.io/v1/ip/geo.json';
  final response = await http.get(Uri.parse(geoJsURL));
  if(response.statusCode == 200){
    return UserLocation.fromMap(jsonDecode(response.body));
  }else{
    throw Exception('Hatayla karşılaşıldı.');
  }
}