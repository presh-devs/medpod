import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/medication.dart';
import '../services/firestore_service.dart';

Widget buildMedTile(BuildContext context, Medication med,
    DocumentReference<Medication> documentReference, ) {
  final service = FirestoreService.instance;
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: ListTile(
        onLongPress: ()=> service.deleteData(documentReference: documentReference),
        leading: SvgPicture.asset('assets/icons/medIcon.svg'),
        title: Text(
          med.name!,
          maxLines: 2,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(med.unit!),
        trailing: const Text(
          '',
        ),
        // children: [
        //   buildButtons(context, transaction),
        // ],
      ),
    ),
  );
}
