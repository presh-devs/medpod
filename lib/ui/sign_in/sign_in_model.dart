import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../utilities/constants/text_styles.dart';
import 'validators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum EmailFormType { signIn, signUp }

class SignInModel with EmailAndPasswordValidator, ChangeNotifier {
  final AuthBase auth;
  SignInModel({
    required this.auth,
    this.email,
    this.name,
    this.password,
    required this.formType,
    this.isLoading = false,
    this.submitted = false,
    this.passwordVisible = false,
  });
  String? name;
  String? email;
  String? password;
  EmailFormType? formType;
  bool isLoading;
  bool submitted;
  bool passwordVisible;

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      if (formType == EmailFormType.signIn) {
        await auth.signInWithEmailAndPassword(
          email,
          password,
        );
      } else {
        await auth.createUserWithEmailAndPassword(
name,
          email,
          password,


        );
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

//Todo: add user details after signUp.
  void addUserDetails(String id, String fName) {
    DocumentReference users = FirebaseFirestore.instance.doc('users/$id');
    users.set({
      'id': id,
      'fName': fName,
    });
  }

  // bool get visibility {
  //   if (passwordVisible == false) {
  //     passwordVisible = true;
  //     return true;
  //   }
  //   {
  //     passwordVisible = false;
  //     return false;
  //   }
  // }

  String get headingText {
    return formType == EmailFormType.signIn ? 'Login' : 'Sign up ';
  }

  String get headingDesc {
    return formType == EmailFormType.signIn
        ? 'Continue your journey'
        : 'Start building an healthier lifestyle ';
  }

  String get primaryButtonText {
    return formType == EmailFormType.signIn ? 'Login' : 'Sign up ';
  }

  String get secondaryButtonText {
    return formType == EmailFormType.signIn
        ? 'New to medpod?Sign up'
        : 'Already have an account?Login';
  }

  Widget? get forgotPassword {
    return formType == EmailFormType.signIn
        ? TextButton(
            child: Text(
              'Forgot password?',
              style: kSmallBody3TextStyle.copyWith(color: Colors.blueGrey),
            ),
            onPressed: () {},
          )
        : SizedBox(
            height: 0,
          );
  }

  String? get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String? get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  bool get canSubmit {
    return emailValidator.isValid(email) && passwordValidator.isValid(password);
  }

  void toggleFormType() {
    final formType = this.formType == EmailFormType.signIn
        ? EmailFormType.signUp
        : EmailFormType.signIn;
    updateWith(
      name: '',
      email: '',
      password: '',
      formType: formType,
      submitted: false,
      isLoading: false,
      passwordVisible: !passwordVisible,
    );
  }

  void togglePasswordIcon() {
    passwordVisible = !passwordVisible;
    updateWith(passwordVisible: !passwordVisible);
    notifyListeners();
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
  void updateName(String name) => updateWith(name: name);

  void updateWith({
    String? email,
    String? password,
    String? name,
    EmailFormType? formType,
    bool? isLoading,
    bool? submitted,
    bool? passwordVisible,
  }) {
    this.email = email ?? this.email;
    this.name = name ?? this.name;
    this.password = password ?? this.password;
    this.isLoading = isLoading ?? this.isLoading;
    this.formType = formType ?? this.formType;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
