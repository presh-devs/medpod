import 'package:flutter/material.dart';
import 'package:medpod/views/sign_in/sign_in_model.dart';
import 'sign_in_form.dart';


final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
    // required this.manager,
    required this.isLoading,  required this.formType,
  });
  // final SignInManager manager;
  final bool  isLoading;
  final EmailFormType formType;


  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  // static Widget create(BuildContext context) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
      key:scaffoldKey,
    );
  }

  Widget _buildContent(BuildContext context) {
    final SignInModel model;

    return Padding(
      padding: const EdgeInsets.all(22.0),
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

            SignInForm.create(context,widget.formType),
          ],
        ),
      ),
    );
  }
}
