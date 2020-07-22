import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBlock {
  final _database = Firestore.instance;
  // this method is used for insert only one data into [static document].
  Future<void> insertSingleDocumentUsingMap({Map<String, dynamic> map}) async {
    try {
      await _database.collection("Users").document("Helllo").setData(map);
    } catch (e) {
      print(e.toString());
    }
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
    try {
      await _database.collection("Users").add(map);
    } catch (e) {
      print(e.toString());
    }
  }

  // this method is used for to fetch multipal document into [User] collection.
  Stream<QuerySnapshot> fetchMultipalDocument() {
    try {
      return _database.collection("Users").snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  // where conditon
  Stream<QuerySnapshot> fetchUSingWhere({String name}) {
    try {
      return _database
          .collection("Users")
          .where("name", isEqualTo: name)
          .limit(1)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  // delete document
  Future<void> deleteDocument({String documentID}) async {
    try {
      return await _database.collection("Users").document(documentID).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  // this method is used for to fetch multipal document into [User] collection.
  Stream<DocumentSnapshot> fetchSingleDocument() {
    try {
      return _database.collection("Users").document("Helllo").snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  // update single document detail
  Future<void> updateData({String documentId, Map<String, dynamic> map}) async {
    try {
      await _database.collection("Users").document(documentId).updateData(map);
    } catch (e) {
      print(e.toString());
    }
  }
}
