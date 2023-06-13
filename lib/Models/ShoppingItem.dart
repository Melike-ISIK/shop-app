import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingItem {
  late String docId;
  late String name;
  late double amount;
  late String imagePath;
  late int quantity;
  late int productId;

  ShoppingItem(
      {
        required this.docId,
        required this.name,
        required this.amount,
        required this.imagePath,
        required this.quantity,
        required this.productId,
      });

  ShoppingItem.fromDocumentSnapshot(DocumentSnapshot documentSnapshot,) {
    Map<String, dynamic> data = (documentSnapshot.data() as Map<String, dynamic>);
    docId = documentSnapshot.id;
    name = data["name"];
    amount = data["amount"];
    imagePath = data["imagePath"];
    quantity = data["quantity"];
    productId = data["productId"];
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'name': name,
      'amount': amount,
      'imagePath': imagePath,
      'quantity': quantity,
      'productId': productId,
    };
  }
}