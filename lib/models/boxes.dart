
import 'package:hive/hive.dart';

import 'med.dart';

class Boxes {
  static Box<Med> getMeds() =>
      Hive.box<Med>('meds');
}