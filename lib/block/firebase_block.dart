import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBlock {
  final _database = Firestore.instance;
  // this method is used for insert only one data into [static document].
  Future<void> insertSingleDocumentUsingMap({Map<String, dynamic> map}) async {
    await _database.collection("Users").document("Helllo").setData(map);
  }

  String nameValidation({String data}) {
    if (data.length <= 0) {
      return "please enter name";
    } else if (data.length > 10) {
      return "please enter only 10 character";
    } else {
      return null;
    }
  }

  String phoneValidaton({String no}) {
    if (no.length <= 0) {
      return "please enter phone no";
    } else if (no.length > 10) {
      return "please enter only 10 number";
    } else {
      return null;
    }
  }

  // this method is used for to insert multipal document into [User] collection.
  Future<void> insertMultipaleDocument({Map<String, dynamic> map}) async {
    await _database.collection("Users").add(map);
  }

  // this method is used for to fetch multipal document into [User] collection.
  Stream<QuerySnapshot> fetchMultipalDocument() {
    return _database.collection("Users").snapshots();
  }

  // where conditon
  Stream<QuerySnapshot> fetchUSingWhere({String name}) {
    return _database
        .collection("Users")
        .where("name", isEqualTo: name)
        .limit(1)
        .snapshots();
  }

  // delete document
  Future<void> deleteDocument({String documentID}) async {
    return await _database.collection("Users").document(documentID).delete();
  }

  // this method is used for to fetch multipal document into [User] collection.
  Stream<DocumentSnapshot> fetchSingleDocument() {
    return _database.collection("Users").document("Helllo").snapshots();
  }

  // update single document detail
  Future<void> updateData({String documentId, Map<String, dynamic> map}) async {
    await _database.collection("Users").document(documentId).updateData(map);
  }
}
