import '../services/auth_service.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: () {
    //     FocusScopeNode currentFocus = FocusScope.of(context);
    //     if (!currentFocus.hasPrimaryFocus) {
    //       currentFocus.unfocus();
    //     }
    //   },
    //   child: Scaffold(
    //     backgroundColor: Theme.of(context).primaryColor,
    //     body: Container(
    //       child: LoginForm(),
    //     ),
    //   ),
    // );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: FlatButton(
          onPressed: () {
            //TODO: maybe show loading
            AuthService.signInWithGoogle(context);
          },
          child: Text(
            'Zaloguj się poprzez Google',
            style: TextStyle(
              // color: Provider.of<ColorData>(context).secondaryTextColor,
              color: Theme.of(context).textTheme.bodyText2.color,
            ),
          ),
        ),
      ),
    );
  }
}
