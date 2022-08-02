import 'package:flutter/material.dart';
import 'package:medpod/ui/onboarding/onboard_model.dart';
import 'package:medpod/utilities/common_widgets/button.dart';
import 'package:medpod/utilities/constants/colors.dart';
import 'package:medpod/utilities/constants/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  late PageController _pageController;
  List<OnboardModel> screens = <OnboardModel>[
    OnboardModel(
      img: 'assets/',
      text: 'Track all your medications in one place.',
      desc:
          'Organize and customize your medication list and schedule use easily.',
    ),
    OnboardModel(
      img: 'assets/',
      text: 'Never miss a dose of your medication.',
      desc:
          'Set reminders and get notifications to take and refill medications.',
    ),
    OnboardModel(
      img: 'assets/',
      text: 'Stay informed with our news articles.',
      desc: 'Learn more with our health articles written by professionals.',
    ),
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _storeOnboardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: Column(
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 305, child: InkWell()),
                        //Image.asset(screens[index].img),
                        Text(
                          screens[index].text,
                          style: kHeading3TextStyle.copyWith(
                              color: kHeadingTextColor),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          screens[index].desc.toString(),
                          textAlign: TextAlign.center,
                          style: kLargeBody3TextStyle.copyWith(
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
            SmoothPageIndicator(
              controller: _pageController,
              count: screens.length,
              effect: const ScrollingDotsEffect(
                activeStrokeWidth: 2.6,
                activeDotScale: 1.3,
                radius: 6,
                spacing: 12,
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: kPrimaryColor,
                dotColor: Colors.grey,
              ),
            ),
            CustomButton(
              title: 'Login',
              onPressed: () {},
              isButtonDisabled: false,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextButton(
                onPressed: () {
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => Home()));
                },
                child: const Text(
                  'New to medpod? Sign up',
                  style: kSmallBody3TextStyle,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
