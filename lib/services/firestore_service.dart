import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:medpod/models/medication.dart';
import 'package:provider/provider.dart';

import 'auth.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  // get medsCollection => _medsCollection;

  Auth auth = Auth();
  final User? user = Auth().currentUser;

  // Set data to firestore
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    CollectionReference reference = FirebaseFirestore.instance.collection(path);
    print('$path: $data');
    await reference.add(data);
  }

  //delete data from firestore
  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    //print('delete: $path');
    await reference.delete();
  }

  //medication query for FirestoreListview
  Query<Medication> getMedQuery() {
    Query<Medication> query = FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .collection('meds')
        .orderBy('name')
        .withConverter<Medication>(
          fromFirestore: (snapshot, _) => Medication.fromMap(snapshot.data()!),
          toFirestore: (medication, _) => medication.toMap(),
        );
    return query;
  }

  void printMeds({
    required String path,
  }) {
    FirebaseFirestore.instance
        .collection('meds')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["name"]);
      }
    });
  }
}
