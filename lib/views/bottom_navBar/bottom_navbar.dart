import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medpod/utilities/constants/text_styles.dart';
import '../../services/auth.dart';
import 'package:provider/provider.dart';
import '../../utilities/common_widgets/header_row.dart';
import '../../utilities/constants/colors.dart';
import 'cubit/bottom_navbar_cubit.dart';
import 'feed.dart';
import 'home.dart';
import 'medication_nav.dart';
import 'more.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({super.key});

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
  String greetingIcon(String greeting){
switch (greeting) {
  case "Good Morning":
    return '☀️';
    case "Good Afternoon":
    return '☀️';
      case "Good Night":
    return '🌙';
  default:
  return '☀️';
}
  }

  final screens = [
    const HomePage(),
    const MedicationPage(),
    const FeedPage(),
    const MorePage(),
  ];
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    // final width = MediaQuery.of(context).size.width;
    final auth = Provider.of<AuthBase>(context, listen: false);
    auth.currentUser;
    return BlocProvider(
      create: (context) => BottomNavbarCubit(),
      child: BlocBuilder<BottomNavbarCubit, BottomNavbarState>(
        builder: (context, state) {
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
              title: ListTile( contentPadding: EdgeInsets.symmetric(horizontal: 0),
                title: buildHeaderRow(
                    title: greeting(), imageUrl:greetingIcon(greeting())),
                subtitle: Text(auth.currentUser!.displayName!,style: kMediumBody3TextStyle.copyWith(color: Colors.black)),
              ),
              //  Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: buildHeaderRow(
              //           title: greeting(),
              //           imageUrl: 'assets/images/sun.png',
              //         ),
              //       ),
              //       Align(
              //           alignment: Alignment.centerLeft,
              //           child: FittedBox(
              //             fit: BoxFit.contain,
              //             child: Text('  ${auth.currentUser!.displayName!}'))),
              //     ]),
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/bell.svg',
                    ),
                    tooltip: '',
                    onPressed: () {},
                  ),
                )
              ],
            ),
            body: screens[state.index],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
              currentIndex: state.index,
              onTap: (index) =>
                  context.read<BottomNavbarCubit>().goToSection(index),
              //setState(() => currentIndex = index),
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/home-3-line.svg',
                    color: state.index == 0 ? kPrimaryColor : Colors.grey,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/capsule-line.svg',
                    color: state.index == 1 ? kPrimaryColor : Colors.grey,
                  ),
                  label: 'Medication',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/newspaper-line.svg',
                    color: state.index == 2 ? kPrimaryColor : Colors.grey,
                  ),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/more-fill.svg',
                    color: state.index == 3 ? kPrimaryColor : Colors.grey,
                  ),
                  label: 'More',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
