import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseDatabase {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  FirebaseDatabase() {
    collectionReference = firebaseFirestore.collection('movies');
  }

  Future<bool> INSERT(Map<String, dynamic> movies) async {
    try {
      collectionReference!.doc().set(movies);
      return true;
    } catch (e) {
      kDebugMode ? print('ERROR AL INSERTAR: ${e.toString()}') : '';
    }
    return false;
  }

  Future<bool> UPDATE(Map<String, dynamic> movies, String id) async {
    try {
      collectionReference!.doc(id).update(movies);
      return true;
    } catch (e) {
      print('Error en la actualización: $e');
    }
    return false;
  }

  Future<bool> DELETE(String UId) async {
    try {
      collectionReference!.doc(UId).delete();
      return true;
    } catch (e) {
      print('Error en borrado $e');
    }
    return false;
  }

  Stream<QuerySnapshot> SELECT() {
    return collectionReference!
        .snapshots(); //manda todos los documentos de la colección
  }
}
