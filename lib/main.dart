import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medpod/services/auth.dart';
import 'package:medpod/services/notification_service.dart';
import 'package:medpod/ui/onboarding/onboarding_page.dart';
import 'package:flutter/services.dart';
import 'package:medpod/widgets/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

bool onBoarded = false;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  onBoarded = prefs.getBool('onBoarded')?? false;

  await NotificationService().init();
  await NotificationService().requestIOSPermissions();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medpod',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.latoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: onBoarded ? const LandingPage(): const Onboard(),
      ),
    );
  }
}
