import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  late String docId;
  late String name;
  late String comment;
  late Timestamp date;

  Comment(
      {
        required this.docId,
        required this.name,
        required this.comment,
        required this.date,
      });

  Comment.fromDocumentSnapshot(DocumentSnapshot documentSnapshot,) {
    Map<String, dynamic> data = (documentSnapshot.data() as Map<String, dynamic>);
    docId = documentSnapshot.id;
    name = data["name"];
    comment = data["comment"];
    date = data["date"];
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'name': name,
      'date': date,
      'comment': comment,
    };
  }
}