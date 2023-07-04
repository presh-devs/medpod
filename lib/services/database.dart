import 'package:medpod/models/medication.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
  Future<void> setMed(Medication medication);
  void printMed();
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



  @override
  void printMed() => _service.printMeds(path: APIPath.medList(uid));

}
