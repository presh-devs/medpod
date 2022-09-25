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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Today, 1 Jul', style: kSmallBody3TextStyle),
              const SizedBox(
                height: 190,
              ),
              SvgPicture.asset(
                'assets/images/pana.svg',
                width: 230,
                height: 235,
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
                      fullscreenDialog: true,
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
