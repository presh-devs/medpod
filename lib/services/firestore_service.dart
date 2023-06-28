import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medpod/models/medication.dart';
import 'package:medpod/services/api_path.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  var _medsQuery;
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
  getCollection(String path) {
    _medsQuery = FirebaseFirestore.instance
        .collection(path)
        .orderBy('time')
        .withConverter<Medication>(
          fromFirestore: (snapshot, _) => Medication.fromMap(snapshot.data()!),
          toFirestore: (medication, _) => medication.toMap(),
        );
  }

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

// Stream<List<T>> collectionStream<T>({
//   required String path,
//   required T Function(Map<String, dynamic> data, String documentId) builder,
//   Query Function(Query query)? queryBuilder,
//   int Function(T lhs, T rhs)? sort,
// }) {
//   Query query = FirebaseFirestore.instance.collection(path);
//   if (queryBuilder != null) {
//     query = queryBuilder(query);
//   }
//   final snapshots = query.snapshots();
//   return snapshots.map((snapshot) {
//     final result = snapshot.docs
//         .map((snapshot) =>
//             builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
//         .where((value) => value != null)
//         .toList();
//     if (sort != null) {
//       result.sort(sort);
//     }
//     return result;
//   });
// }
