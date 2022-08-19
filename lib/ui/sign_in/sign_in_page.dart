import 'package:flutter/material.dart';
import 'package:medpod/ui/sign_in/sign_in_model.dart';
import 'sign_in_form.dart';
import 'sign_in_model.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
    // required this.manager,
    required this.isLoading,
  }) : super(key: key);
  // final SignInManager manager;
  final isLoading;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // static Widget create(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final SignInModel model;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          textDirection: TextDirection.ltr,
          children: [
            // SocialSignInButton(
            //   assetName: 'images/google-logo.png',
            //   text: 'Sign in with Google',
            //   onPressed: isLoading ? null : () => _signInWithGoogle(context),
            //   color: Colors.white,
            //   textColor: Colors.black,
            // ),
            const SizedBox(
              height: 40,
            ),
            // SocialSignInButton(
            //   assetName: 'images/facebook-logo.png',
            //   text: 'Sign in with FaceBook',
            //   onPressed: isLoading ? null : () => _signInWithFacebook(context),
            //   color: const Color(0xFF334D92),
            //   textColor: Colors.white,
            // ),

            SignInForm.create(context),
          ],
        ),
      ),
    );
  }
}
