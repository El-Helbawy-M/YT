import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yt/System/Constants.dart';

class Database {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  String _collection;
  Database(this._collection);

  Future<RequestState> editDocument(String path, Map<String, dynamic> data, Operation op) async {
    try {
      op == Operation.NEW ? await _db.collection(_collection).doc(path).set(data) : await _db.collection(_collection).doc(path).update(data);
      return RequestState.OK;
    } catch (e) {
      return RequestState.Unknown;
    }
  }

  Future<Map<String, dynamic>> getDocument(String name) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await _db.collection(_collection).doc(name).get();
      return data.data();
    } catch (e) {
      return {};
    }
  }

  Future<RequestState> deleteDocument(String name) async {
    try {
      await _db.collection(_collection).doc(name).delete();
      return RequestState.OK;
    } catch (e) {
      return RequestState.Unknown;
    }
  }
}
