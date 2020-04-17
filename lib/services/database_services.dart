import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stream/models/message_model.dart';
import '../models/user_model.dart';
import '../utilities/constants.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';

class DatabaseService {
  static String getChatId(String meId, User user){
    String userId = user.id;
    if(meId.hashCode <= userId.hashCode){
      return '$meId-$userId';
    }else{
      return '$meId-$userId';
    }
  }

  static void updateUser(User user) {
    userRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.imageUrl,
      'bio': user.bio,
    });
  }

  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        userRef.where('name', isLessThanOrEqualTo: name).getDocuments();
        // userRef.sea
    return users;
  }
}
