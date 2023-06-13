// To parse this JSON data, do
//
//     final userLocation = userLocationFromMap(jsonString);

import 'dart:convert';

UserLocation userLocationFromMap(String str) => UserLocation.fromMap(json.decode(str));

String userLocationToMap(UserLocation data) => json.encode(data.toMap());

class UserLocation {
  String ip;
  String organizationName;
  String city;
  int asn;
  String organization;
  String country;
  String areaCode;
  String timezone;
  String countryCode;
  String countryCode3;
  String continentCode;
  int accuracy;
  String region;
  String latitude;
  String longitude;

  UserLocation({
    required this.ip,
    required this.organizationName,
    required this.city,
    required this.asn,
    required this.organization,
    required this.country,
    required this.areaCode,
    required this.timezone,
    required this.countryCode,
    required this.countryCode3,
    required this.continentCode,
    required this.accuracy,
    required this.region,
    required this.latitude,
    required this.longitude,
  });

  factory UserLocation.fromMap(Map<String, dynamic> json) => UserLocation(
    ip: json["ip"],
    organizationName: json["organization_name"],
    city: json["city"],
    asn: json["asn"],
    organization: json["organization"],
    country: json["country"],
    areaCode: json["area_code"],
    timezone: json["timezone"],
    countryCode: json["country_code"],
    countryCode3: json["country_code3"],
    continentCode: json["continent_code"],
    accuracy: json["accuracy"],
    region: json["region"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toMap() => {
    "ip": ip,
    "organization_name": organizationName,
    "city": city,
    "asn": asn,
    "organization": organization,
    "country": country,
    "area_code": areaCode,
    "timezone": timezone,
    "country_code": countryCode,
    "country_code3": countryCode3,
    "continent_code": continentCode,
    "accuracy": accuracy,
    "region": region,
    "latitude": latitude,
    "longitude": longitude,
  };
}
