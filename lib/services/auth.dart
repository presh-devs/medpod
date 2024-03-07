
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();

  // Future<User?> signInWithGoogle();

  //Future<User?> signInWithFacebook();

  Future<User?> signInWithEmailAndPassword(String? email, String? password);

  Future<User?> createUserWithEmailAndPassword(
    String? fName,
    String? email,
    String? password,
  );

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInWithEmailAndPassword(
      String? email, String? password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email!, password: password!),
    );
    return userCredential.user;
  }

  @override
  Future<User?> createUserWithEmailAndPassword(
    String? fName,
    String? email,
    String? password,
  ) async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      User? user = userCredential.user;
      user?.updateDisplayName(fName);
      addUserDetails(fName!, user);
      return user;
    } catch (e){
      debugPrint(e.toString());
    }

  }
  //
  // @override
  // Future<User?> signInWithGoogle() async {
  //   final googleSignIn = GoogleSignIn();
  //   final googleUser = await googleSignIn.signIn();
  //   if (googleUser != null) {
  //     final googleAuth = await googleUser.authentication;
  //     if (googleAuth.idToken != null) {
  //       final userCredential = await _firebaseAuth.signInWithCredential(
  //         GoogleAuthProvider.credential(
  //           idToken: googleAuth.idToken,
  //           accessToken: googleAuth.accessToken,
  //         ),
  //       );
  //       return userCredential.user;
  //     } else {
  //       throw FirebaseAuthException(
  //         code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
  //         message: 'Missing Google Id Token',
  //       );
  //     }
  //   } else {
  //     throw FirebaseAuthException(
  //       code: 'ERROR_ABORTED_BY_USER',
  //       message: 'Sign in aborted by user',
  //     );
  //   }
  // }
  //
  // @override
  // Future<User?> signInWithFacebook() async {
  //   final fb = FacebookLogin();
  //   final response = await fb.logIn(permissions: [
  //     FacebookPermission.publicProfile,
  //     FacebookPermission.email,
  //   ]);
  //   switch (response.status) {
  //     case FacebookLoginStatus.success:
  //       final accessToken = response.accessToken;
  //       final userCredential = await _firebaseAuth.signInWithCredential(
  //         FacebookAuthProvider.credential(accessToken!.token),
  //       );
  //       return userCredential.user;
  //     case FacebookLoginStatus.cancel:
  //       throw FirebaseAuthException(
  //         code: 'ERROR_ABORTED_BY_USER',
  //         message: 'Sign in aborted by user',
  //       );
  //     case FacebookLoginStatus.error:
  //       throw FirebaseAuthException(
  //         code: 'ERROR_FACEBOOK_SIGN_IN_FAILED',
  //         message: response.error?.developerMessage,
  //       );
  //     default:
  //       throw UnimplementedError();
  //   }
  // }

  void addUserDetails(String fName, User? user) {
    if (user != null) {
      DocumentReference users =
          FirebaseFirestore.instance.doc('users/${user.uid}');

      users.set({
        'email': user.email,
        'id': user.uid,
        'fName': fName,
      });
    }
  }

  @override
  Future<void> signOut() async {
    //final googleSignIn = GoogleSignIn();
    //await googleSignIn.signOut();
    //final facebookLogin = FacebookLogin();
    //await facebookLogin.logOut();
    await _firebaseAuth.signOut;
  }
}
