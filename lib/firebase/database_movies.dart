import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMovies {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference? collectionReference;

  DatabaseMovies() {
    collectionReference = firebaseFirestore.collection('movies');
  }

  Future<void> INSERT(Map<String, dynamic> movies) async {
    return collectionReference!.doc().set(movies);
  }

  Future<void> UPDATE(Map<String, dynamic> movies, String id) async {
    return collectionReference!.doc(id).update(movies);
  }

  Future<void> DELETE(String UId) async {
    return collectionReference!.doc(UId).delete();
  }

  Stream<QuerySnapshot> SELECT() {
    return collectionReference!
        .snapshots(); //manda todos los documentos de la colección
  }
}
