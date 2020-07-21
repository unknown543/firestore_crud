import 'package:cloud_firestore/cloud_firestore.dart';

import '../block/firebase_block.dart';

class Repository {
  final _firebaseBlock = FirebaseBlock();
  void insertSingleDocumentUsingMap({Map<String, dynamic> map}) {
    _firebaseBlock.insertSingleDocumentUsingMap(map: map);
  }

  void insertMultipaleDocument({Map<String, dynamic> map}) {
    _firebaseBlock.insertMultipaleDocument(map: map);
  }

  String nameValidation({String data}) {
    return _firebaseBlock.nameValidation(data: data);
  }

  String phoneValidation({String no}) => _firebaseBlock.phoneValidaton(no: no);
  Stream<QuerySnapshot> fetchMultipalDocument() {
    return _firebaseBlock.fetchMultipalDocument();
  }

  Stream<DocumentSnapshot> fetchSingleDocument() {
    return _firebaseBlock.fetchSingleDocument();
  }

  Future<void> updateData({Map<String, dynamic> map, String documentId}) async {
    return await _firebaseBlock.updateData(documentId: documentId, map: map);
  }

  Stream<QuerySnapshot> fetchUSingWhere({String name}) {
    return _firebaseBlock.fetchUSingWhere(name: name);
  }

  Future<void> deleteDocument({String documentID}) async {
    return await _firebaseBlock.deleteDocument(documentID: documentID);
  }
}
