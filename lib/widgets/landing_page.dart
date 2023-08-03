import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medpod/ui/sign_in/sign_in_model.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../ui/bottom_navBar/bottomNavBar.dart';
import '../ui/bottom_navBar/home.dart';
import '../ui/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User?>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final user = snapshot.data;
            if (user?.uid != null) {
              return const BottomNavBar();
            } else {
              return const SignInPage(
                isLoading: false,
                formType: EmailFormType.signIn,
              );
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
