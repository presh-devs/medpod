import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medpod/utilities/common_widgets/alingedText.dart';
import 'package:medpod/utilities/common_widgets/button.dart';

import '../../models/boxes.dart';
import '../../models/med.dart';
import '../../services/auth.dart';
import '../../utilities/constants/colors.dart';
import '../../utilities/constants/text_styles.dart';
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

  Future<void> signOut()async{
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<Box<Med>>(
      valueListenable: Boxes.getMeds().listenable(),
      builder: (context, box, _) {
        final meds = box.values.toList().cast<Med>();

        return Scaffold(
          backgroundColor: Colors.white,
          body: buildContent(meds),
          floatingActionButton: meds.isEmpty ? null : buildFAB(),
        );
      },
    );
  }

  FloatingActionButton buildFAB() {
    return FloatingActionButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: false,
          builder: (context) => AddMed(),
        ),
      ),
      child: Icon(Icons.add),
    );
  }

  Column buildEmptyState(double width, double height, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCalendarCard(height),

            ],
          ),
        ),
        SizedBox(
          height:height*0.03,
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
          height:height*0.03,
        ),
        CustomButton(
          title: 'Add med',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: false,
                builder: (context) => AddMed(),
              ),
            );
          },
          isButtonDisabled: false,
        ),
      ],
    );
  }

  SizedBox buildCalendarCard(double height) {
    return SizedBox(
        height: height * 0.17,
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding: EdgeInsets.all(height * 0.01),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('September, 2022'),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/calendar-2.svg',

                        //width: 230,
                        //height: 235,
                      ),
                      tooltip: '',
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget buildContent(List<Med> meds) {
    if (meds.isEmpty) {
      return buildEmptyState(width, height, context);
    } else {

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildCalendarCard(height),
            SizedBox(
              height: 24,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '10:00pm',
                style: kBodyLTextStyle3,
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(8),
                itemCount: meds.length,
                itemBuilder: (BuildContext context, int index) {
                  final med = meds[index];

                  return buildMedTile(context, med);
                },
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildMedTile(BuildContext context, Med med) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: ListTile(
          onLongPress: ()=> med.delete(),
          leading: SvgPicture.asset('assets/icons/medIcon.svg'),
                    title: Text(
            med.name,
            maxLines: 2,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Text(med.unit),
          trailing: Text(
            '',
          ),
          // children: [
          //   buildButtons(context, transaction),
          // ],
        ),
      ),
    );
  }
}

//ValueListenableBuilder<Box<Med>>(
//         valueListenable: Boxes.getMeds().listenable(),
//         builder: (context, box, _) {
//           final meds = box.values.toList().cast<Med>();
//
//           return buildContent(meds);
//         },
//       )
