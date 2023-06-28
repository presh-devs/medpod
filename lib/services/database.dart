import 'package:medpod/models/medication.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Future<void> setMed(Medication medication);
  void printMed();
  // Future<void> deleteMed(Medication medication);
  // Stream<List<Medication>> medsStream();

}

//String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({required this.uid});
  final String uid;

  final _service = FirestoreService.instance;


  @override
  Future<void> setMed(Medication medication) => _service.setData(
        path: APIPath.med(
          uid,
        ),
        data: medication.toMap(),
      );

  Stream medications() => _service.medStream(path: APIPath.medList(uid));


  @override
  void printMed() => _service.printMeds(path: APIPath.medList(uid));
  // @override
  // Future<void> deleteMed(Medication medication) async {
  //   // delete where entry.jobId == job.jobId
  //   // final allEntries = await entriesStream(job: job).first;
  //   // for (Entry entry in allEntries) {
  //   //   if (entry.jobId == job.id) {
  //   //     await deleteEntry(entry);
  //   //   }
  //   // }
  //   // delete job
  //   await _service.deleteData(path: APIPath.med(uid, medication.id));
  // }

}

// @override
// Stream<Medication> medsStream({required String medId}) => _service.documentStream(
//       path: APIPath.med(uid, medId),
//       builder: (data, documentId) => Medication.fromMap(data!, documentId),
//     );
//

// @override
// Stream<List<Job>> jobsStream() => _service.collectionStream(
//       path: APIPath.jobs(uid),
//       builder: (data, documentId) => Job.fromMap(data, documentId),
//     );

// @override
// Future<void> setEntry(Entry entry) => _service.setData(
//   path: APIPath.entry(uid, entry.id),
//   data: entry.toMap(),
// );
//
// @override
// Future<void> deleteEntry(Entry entry) => _service.deleteData(
//   path: APIPath.entry(uid, entry.id),
// );
//
// @override
// Stream<List<Entry>> entriesStream({Job? job}) =>
//     _service.collectionStream<Entry>(
//       path: APIPath.entries(uid),
//       queryBuilder: job != null
//           ? (query) => query.where('jobId', isEqualTo: job.id)
//           : null,
//       builder: (data, documentID) => Entry.fromMap(data, documentID),
//       sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
//     );
