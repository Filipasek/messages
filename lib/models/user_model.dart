class User {
  final int id;
  final String name;
  final String imageUrl;
  final String service;

  User({
    this.id,
    this.name,
    this.imageUrl,
    this.service,
  });
}

class ThreadList{
  final String threadID;
  final String name;
  final String imageUrl;
  final String service;
  final String time;
  final String message;
  final bool isRead;
  final String byWho;

  ThreadList({
    this.threadID,
    this.name,
    this.imageUrl,
    this.service,
    this.time,
    this.message,
    this.isRead,
    this.byWho,
  });

  factory ThreadList.fromJson(Map<String, dynamic> json) {
    return ThreadList(
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