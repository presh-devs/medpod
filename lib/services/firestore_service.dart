import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medpod/models/medication.dart';


class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  get medsQuery => _medsQuery;

  // Set data to firestore
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    CollectionReference reference = FirebaseFirestore.instance.collection(path);
    // final referenced = FirebaseFirestore.instance.doc(path);
    //referenced.set(data);
    print('$path: $data');
    await reference.add(data);
  }

  //delete data from firestore
  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    //print('delete: $path');
    await reference.delete();
  }

  // get a collection from firestore
  Stream medStream({
    required String path,
  }) {
    Stream collectionStream =
    FirebaseFirestore.instance.collection(path).snapshots();

    return collectionStream;
  }

// get a collection from firestore
  final _medsQuery = FirebaseFirestore.instance
      .collection('meds')
      .orderBy('time')
      .withConverter<Medication>(
    fromFirestore: (snapshot, _) => Medication.fromMap(snapshot.data()!),
    toFirestore: (medication, _) => medication.toMap(),
  );


  void printMeds({
    required String path,
  }) {
    FirebaseFirestore.instance
        .collection(path)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        print(doc["name"]);
      }
    });
  }

// get a document stream from firestore
  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

}