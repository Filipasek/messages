import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream/screens/thread_list_screen.dart';
import 'package:stream/widgets/custom_signup_form.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  Future<Widget> _isSomething;
  Future<Widget> _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_credentials_key';
    final value = prefs.getString(key) ?? 0;
    // if (value == 0)
    //   return LoginScreen();
    // else
    //   return ThreadListScreen();
    return SignupScreen();
  }

  @override
  void initState() {
    super.initState();
    _isSomething = _read();
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
    return FutureBuilder<Widget>(
      future: _isSomething,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else if (snapshot.hasError)
          return LoginScreen();
        else {
          return Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            height: double.infinity,
          );
        }
      },
    );
    // return TestScreen();
  }
}
