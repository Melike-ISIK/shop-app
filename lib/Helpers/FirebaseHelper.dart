import 'dart:async';

import 'package:alisveris/Models/Address.dart';
import 'package:alisveris/Models/Comment.dart';
import 'package:alisveris/Models/ShoppingItem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<ShoppingItem>> StreamCart() {
    try {
      return _firestore
          .collection("User")
          .doc(_auth.currentUser?.uid)
          .collection("cart")
          .snapshots()
          .map((query) {
        final List<ShoppingItem> retVal = <ShoppingItem>[];

        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(ShoppingItem.fromDocumentSnapshot(doc));
        }

        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> AddCart(ShoppingItem model) async {
    try {
      _firestore.collection("User")
          .doc(_auth.currentUser?.uid)
          .collection("cart")
          .add({
        "amount": model.amount,
        "name": model.name,
        "imagePath": model.imagePath,
        "quantity": model.quantity,
        "productId": model.productId,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> UpdateCart(ShoppingItem model) async {
    try {
      _firestore.collection("User")
          .doc(_auth.currentUser?.uid)
          .collection("cart")
          .doc(model.docId)
          .update({
        "name": model.name,
        "amount": model.amount,
        "imagePath": model.imagePath,
        "quantity": model.quantity,
        "productId": model.productId
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> DeleteCart(ShoppingItem model) async {
    try {
      _firestore.collection("User")
          .doc(_auth.currentUser?.uid)
          .collection("cart")
          .doc(model.docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<double> CalculateTotalPrice() {
    try {
      return _firestore
          .collection("User")
          .doc(_auth.currentUser?.uid)
          .collection("cart")
          .snapshots()
          .map((query) {
        double totalPrice = 0;

        for (final DocumentSnapshot doc in query.docs) {
          Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);

          totalPrice += data['amount'] * data['quantity'];
        }

        return totalPrice;
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Comment>> StreamProductComments(int productId) {
    try {
      return _firestore
          .collection("Product")
          .doc(productId.toString())
          .collection("Comments")
          .orderBy('date', descending: true)
          .snapshots()
          .map((query) {
        final List<Comment> commentList = <Comment>[];

        for (final DocumentSnapshot doc in query.docs) {
          commentList.add(Comment.fromDocumentSnapshot(doc));
        }
        return commentList;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> AddAddress(Address model) async {
    CollectionReference ref =
    await FirebaseFirestore.instance.collection('User').doc(_auth.currentUser?.uid).collection("Address");

    String docId=ref.doc().id;

    try {
      ref.doc(docId).set({
        'docId': docId,
        'name': model.name,
        'surname': model.surname,
        'address': model.address,
        'city': model.city,
        'country': model.country,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> DeleteAddress(Address model) async {
    try {
      _firestore.collection("User")
          .doc(_auth.currentUser?.uid)
          .collection("Address")
          .doc(model.docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Address>> StreamAddress() {
    try {
      return _firestore
          .collection("User")
          .doc(_auth.currentUser?.uid)
          .collection("Address")
          .snapshots()
          .map((query) {
        final List<Address> retVal = <Address>[];

        for (final DocumentSnapshot doc in query.docs) {
          retVal.add(Address.fromDocumentSnapshot(doc));
        }

        return retVal;
      });
    } catch (e) {
      rethrow;
    }
  }
}