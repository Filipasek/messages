import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream/models/message_model.dart';
// import 'package:stream/models/user_model.dart';
import 'package:stream/services/app_localizations.dart';
// import '../getters/thread_list.dart';
// import '../models/user_model.dart';
import '../services/auth_service.dart';
import './search_screen.dart';
import 'package:provider/provider.dart';
import '../models/user_data.dart';
import '../utilities/constants.dart';
import '../models/threads_model.dart';
import 'package:timeago/timeago.dart' as timeago;


class ThreadListScreen extends StatefulWidget {
  @override
  _ThreadListScreenState createState() => _ThreadListScreenState();
}

String _firstName(String _name) {
  try {
    return _name.substring(0, _name.indexOf(" "));
  } catch (e) {
    print(e);
    return _name;
  }
}

class _ThreadListScreenState extends State<ThreadListScreen> {
  bool isCompleted;

  // Future<ThreadList> threadList;
  Future<void> saveThreadList() async {
    // threadList = null;
    // setState(() {
    //   threadList = getThreadList();
    // });
    isCompleted = true;
  }

  Future<Map> _getUserData({@required id}) async {
    // Future<QuerySnapshot> users =
    //     userRef.where('name', isLessThanOrEqualTo: name).getDocuments();
    var data = await userRef.document(id).get().then((_) {
      return _.data;
    });
    // print('data: '+data.toString());
    // throw Exception();
    String name = data['name'];
    String picUrl = data['avatar'] ??
        'assets'; //in case no imageUrl is provided, use from assets
    return {'name': name, 'imageUrl': picUrl};
  }

  List<Future<Thread>> getList(List<DocumentSnapshot> _list) {
    var uid = Provider.of<UserData>(context, listen: false).currentUserId;
    return _list.map((DocumentSnapshot ds) {
      var list = ds.reference
          .collection('threads')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .getDocuments()
          .then((QuerySnapshot querySnapshot) async {
        var data = querySnapshot.documents[0].data;
        Map userInfo;
        if (data['idFrom'] == uid) {
          userInfo = (await _getUserData(id: data['idTo']));
        } else {
          userInfo = (await _getUserData(id: data['idFrom']));
        }
        return Thread.fromList(data, userInfo);
      });
      return list;
    }).toList();
  }

  @override
  void initState() {
    // saveThreadList();
    // getList();
    super.initState();
  }

  Widget intro() {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('vertical_thread_list_screen_info')
                        .toUpperCase(),
                    style: GoogleFonts.raleway(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    icon: Icon(Icons.clear),
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () {},
                    iconSize: 18.0,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 115.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) return SizedBox(width: 20.0);
                return _active(i - 1);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _container(i, _avatarUrl, _name, _unread, _time, _message) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: 10.0),
      child: false
          ? Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('messages_section_info')
                        .toUpperCase(),
                    style: GoogleFonts.raleway(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: IconButton(
                    icon: Icon(Icons.drafts),
                    color: Theme.of(context).iconTheme.color,
                    onPressed: () {},
                    iconSize: 18.0,
                  ),
                )
              ],
            )
          : Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 15.0),
              child: Container(
                height: 120.0,
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  color: Theme.of(context).textTheme.headline4.color,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      // color: Colors.grey[100],
                      color: Theme.of(context).textTheme.headline6.color,
                      blurRadius: 5.0, // has the effect of softening the shadow
                      spreadRadius:
                          0.0, // has the effect of extending the shadow
                      offset: Offset(
                        0.0, // horizontal, not moving right
                        5.0, // vertical, move down 5
                      ),
                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            left: 14.0,
                            top: 10,
                          ),
                          height: 40.0,
                          width: 40.0,
                          padding: EdgeInsets.all(0.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                //TODO: add image
                                fit: BoxFit.cover,
                                // image: !snapshot.hasData
                                image: _avatarUrl == 'assets'
                                    ? AssetImage(
                                        "assets/images/user_placeholder.jpg")
                                    : NetworkImage(_avatarUrl)),
                          ),
                          // child: !snapshot.hasData ? CircleAvatar(
                          //   radius: 20.0,
                          //   backgroundImage: AssetImage(
                          //     _avatarUrl,
                          //   ),
                          // ) : Image.network(_avatarUrl, fit: BoxFit.cover, ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 23.0, 15.0, 4.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    _name,
                                    style: GoogleFonts.comfortaa(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: _unread
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .color
                                          : Theme.of(context).iconTheme.color,
                                    ),
                                  ),
                                ),
                                Text(
                                  _time,
                                  style: TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                _message,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  height: 1.6,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _active(i) {
    return Container(
      height: 115.0,
      padding: EdgeInsets.only(bottom: 10.0, top: 5.0, right: 20.0),
      child: Container(
        width: 75.0,
        height: 100.0,
        decoration: BoxDecoration(
          // color: Theme.of(context).textTheme.headline4.color,
          color: Theme.of(context).textTheme.headline4.color.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              // color: Colors.grey[100],
              color: Theme.of(context).textTheme.headline6.color,
              blurRadius: 5.0, // has the effect of softening the shadow
              spreadRadius: 0.0, // has the effect of extending the shadow
              offset: Offset(
                0.0, // horizontal, not moving right\
                5.0, // vertical, move down 5
              ),
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 4.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage(favorites[i].imageUrl),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  _firstName(favorites[i].name),
                  style: GoogleFonts.comfortaa(
                    fontSize: 13.0,
                    color: Theme.of(context).textTheme.headline5.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                favorites[i].service,
                style: TextStyle(
                  fontSize: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<UserData>(context, listen: false).currentUserId;
    _remove() async {
      // final prefs = await SharedPreferences.getInstance();
      // final key = 'my_credentials_key';
      // prefs.remove(key);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_) => LoginScreen()),
      // );
      AuthService.logout(context);
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => LoginScreen()),
      //     (Route<dynamic> route) => false);
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 110.0,
              backgroundColor: Theme.of(context).primaryColor,
              floating: false,
              pinned: true,
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
                color: Theme.of(context).iconTheme.color,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  color: Theme.of(context).iconTheme.color,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SearchScreen()));
                  },
                ),
                IconButton(
                    icon: Icon(Icons.exit_to_app),
                    color: Theme.of(context).iconTheme.color,
                    // onPressed: () => _remove(),
                    onPressed: () {
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)
                                    .translate('log_out_prompt_title'),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        .color),
                              ),
                              content: Text(
                                AppLocalizations.of(context)
                                    .translate('log_out_prompt_description'),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(AppLocalizations.of(context)
                                      .translate('no')),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                FlatButton(
                                  child: Text(AppLocalizations.of(context)
                                      .translate('yes')),
                                  onPressed: () => _remove(),
                                ),
                              ],
                            );
                          });
                    })
              ],
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double percent = ((constraints.maxHeight - kToolbarHeight) *
                      100 /
                      (160.0 - kToolbarHeight));
                  double dx = 0;

                  dx = 100 - percent;
                  if (constraints.maxHeight == 100) {
                    dx = 0;
                  }

                  return Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: (kToolbarHeight / 4) + 0.2, left: 0.0),
                        child: Transform.translate(
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('big_thread_list_header'),
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.7,
                              color:
                                  Theme.of(context).textTheme.headline5.color,
                            ),
                          ),
                          offset: Offset(
                              dx, constraints.maxHeight - kToolbarHeight),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ];
        },
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('messages')
              .where(uid, isEqualTo: true)
              .limit(50)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // throw Exception();
              var data = getList(snapshot.data.documents);
              // print(data);
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int i) {
                  return FutureBuilder(
                    future: data[i],
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Thread threadData = snapshot.data;
                        // return Center(child: Text(threadData.otherPerson));
                        return _container(
                            i,
                            threadData.imageUrl,
                            threadData.otherPerson,
                            false,
                            timeago.format(
                              DateTime.fromMillisecondsSinceEpoch(
                                  threadData.timestamp),
                              locale: 'pl',
                            ),
                            threadData.message);
                      }
                      return Center(child: LinearProgressIndicator());
                    },
                  );
                },
              );
            } else {
              return LinearProgressIndicator(
                backgroundColor: Color.fromRGBO(250, 211, 207, 1),
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).accentColor),
              );
            }

            // print('Length: ' + snapshot.data.documents.length.toString());
            //   return ListView.builder(
            //     itemCount:
            //         snapshot.hasData ? snapshot.data.documents.length + 1 : 1,
            //     itemBuilder: (context, i) {
            //       // print('Current: ' + i.toString());
            //       int index = i - 2;
            //       String _name;
            //       String _time;
            //       String _message;
            //       String _avatarUrl;
            //       bool _unread;
            //       if (snapshot.hasData) {
            //         if (i == 0) {
            //           return intro();
            //         } //else if (false) {
            //         //   _container(i, "", "", false, '', '_message');
            //         // }
            //         // print(i);
            //         DocumentSnapshot ds = snapshot.data.documents[i-1];
            //         var data = ds.reference
            //             .collection('threads')
            //             .orderBy('timestamp', descending: true)
            //             .limit(1)
            //             .getDocuments()
            //             .then((querySnapshot) {
            //           return querySnapshot.documents[i-1].data;
            //         });
            //         return FutureBuilder(
            //           future: data,
            //           builder: (BuildContext context, AsyncSnapshot snapshot) {
            //             if (snapshot.hasData) {
            //               var _thread = snapshot.data;
            //               var _userInfo = _getName(_thread['idFrom']);
            //               return FutureBuilder(
            //                 future: _userInfo,
            //                 builder:
            //                     (BuildContext context, AsyncSnapshot snapshot) {
            //                   if (snapshot.hasData) {
            //                     return _container(
            //                         i,
            //                         snapshot.data['avatar'] ?? 'assets',
            //                         snapshot.data['name'],
            //                         true,
            //                         _thread['timestamp'].toString(),
            //                         _thread['content']);
            //                   }
            //                   return Center(
            //                     child: SizedBox(),
            //                   );
            //                 },
            //               );
            //             }
            //             return Center(
            //               child: SizedBox(),
            //             );
            //           },
            //         );
            //         try {
            //           if (index >= 0 && false) {
            //             // _name = da.then((_) => _.documents[0].data).toString();
            //             _time = snapshot.data.threads[index].time;
            //             _message = snapshot.data.threads[index].message;
            //             _unread = snapshot.data.threads[index].isRead;
            //             _avatarUrl = snapshot.data.threads[index].imageUrl;
            //           }
            //         } catch (e) {
            //           print(e);
            //         }
            //       } else if (snapshot.hasError) {
            //         _name = "ERROR";
            //         _time = "ERROR";
            //         _message = "ERROR";
            //         _unread = false;
            //         _avatarUrl = 'assets/images/user_placeholder.jpg';
            //       } else {
            //         return Container(
            //           height: 4.0,
            //           child: LinearProgressIndicator(
            //             backgroundColor: Color.fromRGBO(250, 211, 207, 1),
            //             valueColor: AlwaysStoppedAnimation<Color>(
            //                 Theme.of(context).accentColor),
            //           ),
            //         );
            //       }
            //       // bool _unread = i % 3 == 0;

            //       // return _container(i, _avatarUrl, _name, _unread, _time, _message);
            //     },
            //   );
          },
        ),
      ),
    );
  }
}
