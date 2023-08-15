import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medpod/models/medication.dart';

import 'auth.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();


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
  Future<void> deleteData({required DocumentReference<Medication> documentReference,} ) async {
  //  final reference = FirebaseFirestore.instance.doc(path);
    //print('delete: $path');
   // await reference.delete();
    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(documentReference);
    });

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


}
