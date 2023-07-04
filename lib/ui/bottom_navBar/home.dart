import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medpod/utilities/common_widgets/button.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import '../../models/medication.dart';
import '../../services/auth.dart';
import '../../services/firestore_service.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/text_styles.dart';
import '../../widgets/calendar_card.dart';
import '../../widgets/med_tile.dart';
import '../addMed.dart';
import '../sign_in/sign_in_form.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth auth = Auth();
  final User? user = Auth().currentUser;

  final _service = FirestoreService.instance;

  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  void dispose() {
    Hive.box('meds').close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    // final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: buildContent(),
      floatingActionButton:
          _service.medsQuery != null  ? null :
          buildFAB(),
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: false,
          builder: (context) => const AddMed(),
        ),
      ),
      child: const Icon(Icons.add),
    );
  }

  Column buildEmptyState(double width, double height, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: height * 0.03,
        ),
        SvgPicture.asset(
          'assets/images/pana.svg',
          width: width * 0.4,
          height: height * 0.3,
        ),
        SizedBox(
          height: height * 0.015,
        ),
        Text(
          'No meds due today ',
          style: kMediumBody3TextStyle.copyWith(color: kBlackTextColor),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        CustomButton(
          title: 'Add med',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: false,
                builder: (context) => const AddMed(),
              ),
            );
          },
          isButtonDisabled: false,
        ),
      ],
    );
  }

  @override
  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildCalendarCard(height),
          const SizedBox(
            height: 24,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '10:00pm',
              style: kBodyLTextStyle3,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
              child: FirestoreListView<Medication>(
            query: _service.medsQuery,
            itemBuilder: (context, snapshot) {
              Medication medication = snapshot.data();
              print(medication);
              return buildMedTile(context, medication);
              // Data is now typed!
            },
            emptyBuilder: (context) {
              return buildEmptyState(width, height, context);
            },
          )),
        ],
      ),
    );
    //}
  }
}
