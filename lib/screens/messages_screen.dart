import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream/models/user_data.dart';
import '../models/user_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatefulWidget {
  final User user;
  final String chatId;
  MessagesScreen({this.user, this.chatId});
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController textEditingController =
      new TextEditingController();
  final ScrollController listScrollController = new ScrollController();
  _buildMessage(DocumentSnapshot message) {
    bool isMe = widget.user.id != message['idFrom'];
    timeago.setLocaleMessages('pl', timeago.PlMessages());

    final msg = Container(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: isMe
            ? EdgeInsets.only(top: 8.0, bottom: 8.0, left: 80.0)
            : EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              // timeago.format(int.parse(message['timestamp']).toDate()),
              // timeago.format(message['timestamp']),

              timeago.format(
                DateTime.fromMillisecondsSinceEpoch(message['timestamp']),
                locale: 'pl',
              ),
              // "hey",
              // // message['timestamp'].toDate(),
              // DateFormat('dd MMM kk:mm').format(
              //     DateTime.fromMillisecondsSinceEpoch(message['timestamp'])),
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              message['content'],
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
          borderRadius: isMe
              ? BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      ),
    );
    return msg;
    // return Row(
    //   children: <Widget>[
    //     msg,
    //     IconButton(
    //       icon: message.isLiked
    //           ? Icon(Icons.favorite)
    //           : Icon(Icons.favorite_border),
    //       iconSize: 30.0,
    //       color: message.isLiked
    //           ? Theme.of(context).primaryColor
    //           : Colors.blueGrey,
    //       onPressed: () {},
    //     ),
    //   ],
    // );
  }

  _sendMessage(String content, int type) {
    //type: 0 = text, 1 = image
    textEditingController.clear();
    if (content.trim() != '') {
      var docRef = Firestore.instance
          .collection('messages')
          .document(widget.chatId)
          .collection(widget.chatId)
          .document(DateTime.now().millisecondsSinceEpoch.toString());
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(docRef, {
          'idFrom': Provider.of<UserData>(context, listen: false).currentUserId,
          'idTo': widget.user.id,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'content': content,
          'type': type,
        });
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: "Wyślij wiadomość...",
                // hintStyle: TextStyle()
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).accentColor,
            onPressed: () {
              _sendMessage(textEditingController.text, 0);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          
          widget.user.name,
          style: GoogleFonts.comfortaa(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 4.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('messages')
                      .document(widget.chatId)
                      .collection(widget.chatId)
                      .orderBy('timestamp', descending: true)
                      .limit(20)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.only(top: 15.0),
                        itemBuilder: (BuildContext context, int index) {
                          final DocumentSnapshot message =
                              snapshot.data.documents[index];
                          // final bool isMe = message.sender.id == currentUser.id;
                          return _buildMessage(message);
                        },
                        itemCount: snapshot.data.documents.length,
                        controller: listScrollController,
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
