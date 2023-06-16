import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  late String docId;
  late String name;
  late String surname;
  late String address;
  late String city;
  late String country;

  Address(
      {
        required this.docId,
        required this.name,
        required this.surname,
        required this.address,
        required this.city,
        required this.country,
      });

  Address.fromDocumentSnapshot(DocumentSnapshot documentSnapshot,) {
    Map<String, dynamic> data = (documentSnapshot.data() as Map<String, dynamic>);
    docId = documentSnapshot.id;
    name = data["name"];
    surname = data["surname"];
    address = data["address"];
    city = data["city"];
    country = data["country"];
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'name': name,
      'surname': surname,
      'address': address,
      'city': city,
      'country': country,
    };
  }
}