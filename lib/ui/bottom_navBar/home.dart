import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medpod/utilities/common_widgets/button.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/constants/text_styles.dart';
import '../addMed.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: height * 0.2,
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
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
                                  'assets/icons/calendar.svg',

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
                  )),
              SizedBox(height: 24,),
              SvgPicture.asset(
                'assets/images/pana.svg',
                width: width * 0.4,
                height: height * 0.3,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'No meds due today ',
                style: kMediumBody3TextStyle.copyWith(color: kBlackTextColor),
              ),
              const SizedBox(
                height: 32,
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
          ),
        ),
      ),
    );
  }
}
