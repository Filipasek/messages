import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream/screens/thread_list_screen.dart';
import 'package:stream/widgets/custom_signup_form.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './models/user_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        color: Colors.white,
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
      ),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Widget _getScreenId(context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Provider.of<UserData>(context).currentUserId = snapshot.data.uid;
          return ThreadListScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var brightness =
        MediaQuery.of(context).platformBrightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brightness,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: brightness,
      ),
    );
    return _getScreenId(context);
    // return TestScreen();
  }
}
