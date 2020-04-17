import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final String imageUrl;
  final String email;
  final String bio;
  User({
    this.id,
    this.name,
    this.imageUrl,
    this.email,
    this.bio,
  });
  factory User.fromDoc(DocumentSnapshot doc) {
    return User(
      id: doc.documentID,
      name: doc["name"],
      imageUrl: doc['profileImageUrl'],
      email: doc["email"],
      bio: doc["bio"] ?? '', //if equal to null [prevents from crushing]
    );
  }
}

class Somebody {
  final int id;
  final String name;
  final String imageUrl;
  final String service;

  Somebody({
    this.id,
    this.name,
    this.imageUrl,
    this.service,
  });
}

class Thread{
  final String threadID;
  final String name;
  final String imageUrl;
  final String service;
  final String time;
  final String message;
  final bool isRead;
  final String byWho;

  Thread({
    this.threadID,
    this.name,
    this.imageUrl,
    this.service,
    this.time,
    this.message,
    this.isRead,
    this.byWho,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      threadID: json['threadID'] as String,
      name: json['name'] as String,
      imageUrl: json['imageSrc'] as String,
      service: json['service'] as String,
      time: json['when'] as String,
      message: json['last_message'] as String,
      isRead: json['isRead'] as bool,
      byWho: json['who'] as String,
    );
  }
}

class ThreadList{
  final List<Thread> threads;
  // var lgt;
  ThreadList({
    this.threads,
  });
  
  factory ThreadList.fromJson(List<dynamic> parsedJson){
    List<Thread> threads = new List<Thread>();
    threads = parsedJson.map((i) => Thread.fromJson(i)).toList();
    return new ThreadList(
      threads: threads,
      // lgt: threads.length
    );
  }
}