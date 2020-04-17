import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream/screens/thread_list_screen.dart';
import '../widgets/custom_login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _checkIfCorrectScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_credentials_key';
    final value = prefs.getString(key) ?? 0;
    if (value != null && value != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ThreadListScreen()),
      );
    }
  }

  // @override
  // void initState() {
  //   _checkIfCorrectScreen();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          child: LoginForm(),
        ),
      ),
    );
  }
}
