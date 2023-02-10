import 'package:flutter/material.dart';
import 'package:medpod/ui/onboarding/onboard_model.dart';
import 'package:medpod/ui/sign_in/sign_in_model.dart';
import 'package:medpod/utilities/common_widgets/button.dart';
import 'package:medpod/utilities/constants/colors.dart';
import 'package:medpod/utilities/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

import '../sign_in/sign_in_page.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  bool isLoading = false;
  bool end = false;
  late Timer timer;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/images/onboardingIllustration1.svg',
      text: 'Track all your medications in one place.',
      desc:
          'Organize and customize your medication list and schedule use easily.',
    ),
    OnboardModel(
      img: 'assets/images/onboardingIllustration2.svg',
      text: 'Never miss a dose of your medication.',
      desc:
          'Set reminders and get notifications to take and refill medications.',
    ),
    OnboardModel(
      img: 'assets/images/onboardingIllustration3.svg',
      text: 'Stay informed with our news articles.',
      desc: 'Learn more with our health articles written by professionals.',
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (currentIndex == 2) {
        end = true;
      } else if (currentIndex == 0) {
        end = false;
      }
      if (end == false) {
        currentIndex++;
      }
      _pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeIn,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  // void _showSignInPage(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       fullscreenDialog: true,
  //       builder: (context) => SignInPage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: screens.length,
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Image.asset(screens[index].img),
                        SvgPicture.asset(screens[index].img,
                            height: height * 0.34),
                        SizedBox(height: height * 0.0195),
                        Text(
                          screens[index].text,
                          style: kHeadingTextStyle3.copyWith(
                              color: kHeadingTextColor),
                          textAlign: TextAlign.center,
                        ),
                        // SizedBox(height: height * 0.009),
                        Text(
                          screens[index].desc.toString(),
                          textAlign: TextAlign.center,
                          style: kBodyLTextStyle3.copyWith(
                              color: kHeadingTextColor),
                        ),

                        // InkWell(
                        //   onTap: () async {
                        //     if (index == screens.length - 1) {
                        //       await _storeOnboardInfo();
                        //       //Navigator.pushReplacement(context,
                        //       //  MaterialPageRoute(builder: (context) => Home()));
                        //     }
                        //     _pageController.nextPage(
                        //       duration: Duration(milliseconds: 300),
                        //       curve: Curves.easeIn,
                        //     );
                        //   },
                        // ),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: height * 0.024,
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: screens.length,
              effect: const ScrollingDotsEffect(
                activeStrokeWidth: 2.6,
                activeDotScale: 1.3,
                radius: 5,
                spacing: 12,
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: kPrimaryColor,
                dotColor: Colors.grey,
              ),
            ),
            CustomButton(
              title: 'Login',
              onPressed: () async {
                await _storeOnboardInfo();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => SignInPage(
                      formType: EmailFormType.signIn,
                      isLoading: isLoading,
                    ),
                  ),
                );
              },
              isButtonDisabled: false,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextButton(
                onPressed: () {

                  Navigator.pushReplacement(context,
                   MaterialPageRoute(builder:(context) => SignInPage(isLoading: isLoading, formType: EmailFormType.signUp,)));
                },
                child: const Text(
                  'New to medpod? Sign up',
                  style: kSmallBody3TextStyle,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
