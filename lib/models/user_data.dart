import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier{
  String currentUserId;
  Future<void> logout() async {
    // await storage.deleteAll();
    // GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

}
