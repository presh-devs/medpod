// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../utilities/constants/button_style.dart';
import '../../utilities/constants/text_styles.dart';
import '../bottom_navBar/bottomNavBar.dart';
import 'sign_in_model.dart';
import 'package:medpod/utilities/common_widgets/button.dart';

var pixelRatio = window.devicePixelRatio;
var logicalScreenSize = window.physicalSize / pixelRatio;
var height = logicalScreenSize.height;
var width = logicalScreenSize.width;

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key, required this.model,}) : super(key: key);
  final SignInModel model;


  static Widget create(BuildContext context, var sformType) {

    //final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<SignInModel>(
      create: (_) => SignInModel(formType: sformType

          //auth: auth
          ),
      child: Consumer<SignInModel>(
        builder: (_, model, __) => SignInForm(model: model, ),
      ),
    );
  }

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  SignInModel get model => widget.model;

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          fullscreenDialog: true, builder: (context) => BottomNavBar()),
    );
    // try {
    //   await model.submit();
    //   Navigator.of(context).pop();
    // } on FirebaseAuthException catch (e) {
    //   showExceptionAlertDialog(
    //     context,
    //     exception: e,
    //     title: 'Sign in failed',
    //   );
    // }
  }

  void _toggleFormType() {
    _emailController.clear;
    _nameController.clear;
    _passwordController.clear;
    model.toggleFormType();
  }

  void _togglePasswordIcon() {
    model.togglePasswordIcon();
  }

  List<Widget> _buildChildren() {
    return [
      Text(model.headingText, style: kHeadingTextStyle1),
      SizedBox(
        height: height * 0.02,
      ),
      Text(model.headingDesc, style: kBodyLTextStyle3),
      SizedBox(
        height: height * 0.08,
      ),
      _buildNameTextField(),
      const SizedBox(height: 16.0),
      _buildEmailTextField(),
      const SizedBox(height: 16.0),
      _buildPasswordTextField(),
      const SizedBox(height: 16.0),
      model.forgotPassword!,
      CustomButton(
        isButtonDisabled: model.canSubmit ? false : true,
        onPressed: model.canSubmit ? _submit : null,
        title: model.primaryButtonText,
      ),
      SizedBox(height: height * 0.02),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 1,
            width: width * 0.23,
            color: Colors.black54,
          ),
          const Text('or Login with'),
          Container(
            height: 1,
            width: width * 0.23,
            color: Colors.black54,
          ),
        ],
      ),
      SizedBox(height: height * 0.04),
      IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.07,
            ),
            SizedBox(
              height: height * 0.08,
              width: width * 0.3,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blue,
                  //onSurface: kDefaultButtonColor,
                  shape: const CircleBorder(),
                ),
                child: Image.asset(
                  'assets/images/google-logo.png',
                ),
              ),
            ),
            VerticalDivider(
              width: width * 0.06,
              color: Colors.black,
            ),
            SizedBox(
              height: height * 0.08,
              width: width * 0.2,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.blue,
                  //onSurface: kDefaultButtonColor,
                  shape: const CircleBorder(),
                ),
                child: Image.asset(
                  'assets/images/facebook-logo.png',
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: height * 0.12,
      ),
      Center(
        child: TextButton(
          onPressed: !model.isLoading ? _toggleFormType : null,
          child: Text(
            model.secondaryButtonText,
            style: kSmallBody3TextStyle,
          ),
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    return TextField(
      focusNode: _passwordFocusNode,
      controller: _passwordController,
      decoration: InputDecoration(
        border:  kBorder,
        enabled: model.isLoading == false,
        labelText: 'Password',
        errorText: model.passwordErrorText,
        suffixIcon: IconButton(
          icon: SvgPicture.asset(model.passwordVisible
              ? 'assets/icons/eye-fill.svg'
              : 'assets/icons/eye-off-fill.svg'),
          onPressed: () {
            _togglePasswordIcon();
          },
        ),
      ),
      obscureText: model.passwordVisible ? false : true,
      onChanged: model.updatePassword,
      textInputAction: TextInputAction.done,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    return TextField(
      focusNode: _emailFocusNode,
      controller: _emailController,
      decoration: InputDecoration(
        enabled: model.isLoading == false,
        // hintText: '@gmail.com',
        labelText: 'Email',
        errorText: model.emailErrorText,
        border:  kBorder,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updateEmail,
      onEditingComplete: () => _emailOnEditingComplete(),
    );
  }

  Widget _buildNameTextField() {
    return model.formType == EmailFormType.signUp
        ? TextField(
            focusNode: _nameFocusNode,
            controller: _nameController,
            decoration: InputDecoration(
              enabled: model.isLoading == false,
              // hintText: '@gmail.com',
              labelText: 'First Name',
              errorText: model.emailErrorText,
              border:  kBorder,
            ),
            autocorrect: false,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            onChanged: model.updateName,
            onEditingComplete: () => _emailOnEditingComplete(),
          )
        : const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        textDirection: TextDirection.ltr,
        children: _buildChildren(),
      ),
    );
  }

  void _emailOnEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }
}
