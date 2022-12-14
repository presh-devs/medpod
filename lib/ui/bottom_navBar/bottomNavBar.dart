import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medpod/utilities/common_widgets/button.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/constants/text_styles.dart';
import '../addMed.dart';
import 'feed.dart';
import 'home.dart';
import 'medication.dart';
import 'more.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool isSelected = true;
  int currentIndex = 0;
  final screens = [
    const HomePage(),
    const MedicationPage(),
    const FeedPage(),
    const MorePage(),
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(
              'assets/images/Profile.png',
            ),
          ),
        ),
        title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Good Morning'),
                Image.asset('assets/images/sun.png'),
              ]),
              Align(alignment: Alignment.centerLeft, child: Text('Iyanu')),
            ]),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/bell.svg',
                // color: Colors.white,
                //width: 230,
                //height: 235,
              ),
              tooltip: '',
              onPressed: () {},
            ),
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        showUnselectedLabels: true,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home-3-line.svg',
              color: currentIndex == 0 ? kPrimaryColor : Colors.grey,

              //width: 230,
              //height: 235,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/capsule-line.svg',
              color: currentIndex == 1 ? kPrimaryColor : Colors.grey,
              //width: 230,
              //height: 235,
            ),
            label: 'Medication',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/newspaper-line.svg',
              color: currentIndex == 2 ? kPrimaryColor : Colors.grey,
              //width: 230,
              //height: 235,
            ),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/more-fill.svg',
              color: currentIndex == 3 ? kPrimaryColor : Colors.grey,
              //width: 230,
              //height: 235,
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
