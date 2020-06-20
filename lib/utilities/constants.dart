import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase/firestore.dart';

final _firestore = Firestore.instance;
final StorageReference storageRef = FirebaseStorage.instance.ref();
final CollectionReference userRef = _firestore.collection('users');
final CollectionReference threadsRef = _firestore.collection('messages');