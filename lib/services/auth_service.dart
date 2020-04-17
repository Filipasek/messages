import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user_data.dart';
import 'package:provider/provider.dart';

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
        Provider.of<UserData>(context).currentUserId = signedInUser.uid;
        // Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  static void logout() {
    _auth.signOut();
    
    // Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

  static void login(String email, String password) async {
    email = email.trim();
    password = password.trim();
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      print(e);
    }
  }
}
