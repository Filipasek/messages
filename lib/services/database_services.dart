import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../utilities/constants.dart';

class DatabaseService {
  ///Returns chatId, doesn't matter who is who as long as you assing them to their correct Types.
  static String getChatId({String meId, User user, String userId}) {
    String otherUserId = userId ?? user.id;
    assert(otherUserId != null);
    assert(meId != null);
    if (meId.hashCode <= otherUserId.hashCode) {
      assert(meId != null);
      assert(otherUserId != null);

      return '$meId-$otherUserId';
    } else {
      assert(meId != null);
      assert(otherUserId != null);

      return '$otherUserId-$meId';
    }
  }

  static void updateUser(User user) {
    userRef.document(user.id).updateData({
      'name': user.name,
      'profileImageUrl': user.imageUrl,
      'bio': user.bio,
    });
  }

  ///Searches for user with similar name (not really good at its job).
  static Future<QuerySnapshot> searchUsers(String name) {
    Future<QuerySnapshot> users =
        userRef.where('name', isLessThanOrEqualTo: name).getDocuments();
    // userRef.sea
    return users;
  }
}
