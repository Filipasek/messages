import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stream/services/database_services.dart';

class Thread {
  final String threadID;
  final String idFrom;
  final String idTo;
  final String imageUrl;
  // final String service;
  final timestamp;
  final String message;
  // final bool isRead;
  final String otherPerson;
  final String email;

  Thread({
    this.threadID,
    this.idFrom,
    this.idTo,
    this.imageUrl,
    // this.service,
    this.timestamp,
    this.message,
    // this.isRead,
    this.otherPerson,
    this.email,
  });

  factory Thread.fromList(Map<String, dynamic> json, Map userInfo) {
    return Thread(
      idFrom: json['idFrom'] as String,
      idTo: json['idTo'] as String,
      imageUrl: userInfo['imageUrl'] as String,
      timestamp: json['timestamp'],
      message: json['content'] as String,
      otherPerson: userInfo['name'] as String,
      threadID: DatabaseService.getChatId(
          meId: json['idFrom'],
          userId: json['idTo']), //doesn't really matter who is who
      email: userInfo['email'],
    );
  }
}

// class ThreadList{
//   final List<Thread> threads;
//   // var lgt;
//   ThreadList({
//     this.threads,
//   });

// factory ThreadList.fromList(List<dynamic> _list) {
// print('here2!');

// List<Future<Thread>> threads = new List<Future<Thread>>();
// threads = _list.map((DocumentSnapshot ds) async {
//   return await ds.reference
//       .collection('threads')
//       .orderBy('timestamp', descending: true)
//       .limit(1)
//       .getDocuments()
//       .then((QuerySnapshot querySnapshot) {
//     return Thread.fromList(querySnapshot.documents[0].data);
//   });
// }).toList();
// print('here3!');

// List<Thread> threads = new List<Thread>();
// threads = _list.map((i) {
//   return Thread.fromList(i);
// }).toList();
// return new ThreadList(
//   threads: threads,
//   // lgt: threads.length
// );
//   }
// }
