import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream/models/message_model.dart';
import 'package:stream/models/user_model.dart';
import './getters/thread_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setApplicationSwitcherDescription(
    //   ApplicationSwitcherDescription(
    //     label: 'Wiadomości',
    //     primaryColor: Theme.of(context).primaryColor.value,
    //   ),
    // );
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Color.fromRGBO(255, 182, 185, 1),
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Color.fromRGBO(205, 205, 205, 1)),
        textTheme: TextTheme(
            bodyText2: TextStyle(color: Color.fromRGBO(205, 205, 205, 1))),
      ),
      darkTheme: ThemeData(
        // primaryColor: Color.fromRGBO(34, 40, 49, 1),
        // primaryColor: Colors.black,
        primaryColor: Color.fromRGBO(40, 44, 55, 1),
        accentColor: Color.fromRGBO(217, 217, 243, 1),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Color.fromRGBO(205, 205, 205, 1)),
        textTheme: TextTheme(
            bodyText2: TextStyle(color: Color.fromRGBO(205, 205, 205, 1))),
      ),
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

String _firstName(String _name) {
  try {
    return _name.substring(0, _name.indexOf(" "));
  } catch (e) {
    print(e);
    return _name;
  }
}

class _MainState extends State<Main> {
  Future<ThreadList> threadList;
  @override
  void initState() {
    super.initState();
    threadList = getThreadList();
  }

  Widget _active(i) {
    return Container(
      height: 115.0,
      padding: EdgeInsets.only(bottom: 10.0, top: 5.0, right: 20.0),
      child: Container(
        width: 75.0,
        height: 100.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100],
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
            CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage(favorites[i].imageUrl),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  _firstName(favorites[i].name),
                  style: GoogleFonts.comfortaa(
                    fontSize: 13.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 1.0),
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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).primaryColor,
        systemNavigationBarIconBrightness:
            MediaQuery.of(context).platformBrightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );
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
              leading: Icon(
                Icons.arrow_back,
                color: Color.fromRGBO(205, 205, 205, 1),
              ),
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
                            "Wiadomości",
                            style: GoogleFonts.sourceSansPro(
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.7,
                              color: Colors.black,
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
        body: ListView.builder(
            itemCount: chats.length + 2,
            itemBuilder: (context, i) {
              bool _unread = i % 3 == 0;
              int index = i - 2;
              if (i == 0) {
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
                                "Aktywni użytkownicy".toUpperCase(),
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
              return Container(
                padding: EdgeInsets.only(left: 20.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    i == 1
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "twoje wiadomości".toUpperCase(),
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
                                  onPressed: () {},
                                  iconSize: 18.0,
                                ),
                              )
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.only(
                                right: 20.0, bottom: 15.0),
                            child: Container(
                              height: 120.0,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[100],
                                    blurRadius:
                                        5.0, // has the effect of softening the shadow
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
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                chats[index].sender.imageUrl),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10.0, 23.0, 15.0, 4.5),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: FutureBuilder<ThreadList>(
                                                    future: threadList,
                                                    builder:
                                                        (context, snapshot) {
                                                      String output;
                                                      if (snapshot.hasData) {
                                                        output = snapshot.data.name;
                                                      }else if(snapshot.hasError){
                                                        output = "Wystąpił błąd";
                                                      }else{
                                                        output = "Ładowanie...";
                                                      }
                                                      return Text(
                                                          output,
                                                          style: GoogleFonts
                                                              .comfortaa(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18.0,
                                                            color: _unread
                                                                ? Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    .color
                                                                : Colors
                                                                    .black87,
                                                          ),
                                                        );
                                                    }),
                                              ),
                                              Text(
                                                chats[index].time,
                                                style:
                                                    TextStyle(fontSize: 12.0),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              chats[index].text,
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
                  ],
                ),
              );
            }),
      ),
    );
  }
}
