import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:stream/models/message_model.dart';
// import 'package:stream/models/user_model.dart';
// import './getters/thread_list.dart';
// import './models/user_model.dart';
import './screens/thread_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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

class _MainState extends State<Main> {
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
    return ThreadListScreen();
  }
}
