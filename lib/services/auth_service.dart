import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/user_data.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;
  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    name = name.trim();
    email = email.trim();
    password = password.trim();

    print(email);
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'name': name,
          'email': email,
        });
        Provider.of<UserData>(context, listen: false).currentUserId =
            signedInUser.uid;
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Main()));
      }
    } catch (e) {
      print(e);
    }
  }

  static void logout(context) async {
    await Provider.of<UserData>(context, listen: false).logout();
    _auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Main()));

    // Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  static void login(BuildContext context, String email, String password) async {
    email = email.trim();
    password = password.trim();
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser signedInUser = authResult.user;
      Provider.of<UserData>(context, listen: false).currentUserId =
          signedInUser.uid;
      // Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Main()));
    } on Exception catch (e) {
      print(e);
    }
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static void signInWithGoogle(context) async {
    final GoogleSignInAccount googleSignInAccount = await _googleSignIn
        .signIn(); //TODO: handle canceled (PlatformException (PlatformException(sign_in_canceled, com.google.android.gms.common.api.ApiException: 12501: , null))
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    Provider.of<UserData>(context, listen: false).currentUserId = user.uid;


    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    await addUserToDatabase(
        user.uid, user.displayName, user.email, user.photoUrl);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => Main()));
    //needs to be checked if user exists
  }

  static Future addUserToDatabase(
      userId, String name, String contactData, String avatar) async {
    print('logged in');
    _firestore.collection('/users').document(userId).setData({
      'name': name,
      'email': contactData,
      'avatar': avatar,
    }, merge: true);
  }
}
