import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream/services/app_localizations.dart';
import '../screens/signup_screen.dart';
import '../services/auth_service.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // bool error_401 = false;
  // String _error401Email = "a";
  // String _error401Password = "a";
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidate: true,
      key: _formKey,
      child: Container(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 50.0, right: 30.0),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('login_greeting_message'),
                    style: GoogleFonts.comfortaa(
                      wordSpacing: 20.0,
                      color: Theme.of(context).textTheme.headline5.color,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('email_form'),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      labelStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .headline5
                              .color
                              .withOpacity(0.6)),
                      // labelStyle: TextStyle(color: Theme.of(context).textTheme.headline5.color),
                    ),
                    validator: (input) => !input.contains('@')
                        ? AppLocalizations.of(context)
                            .translate('email_validator')
                        : null,
                    onSaved: (input) => _email = input,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: TextFormField(
                    showCursor: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)
                          .translate('password_form'),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      labelStyle: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .headline5
                              .color
                              .withOpacity(0.6)),
                    ),
                    validator: (input) {
                      return input.length < 6
                          ? AppLocalizations.of(context)
                              .translate('password_validator')
                          : null;
                    },
                    onSaved: (input) => _password = input,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100.0,
                  margin: EdgeInsets.only(bottom: 30.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50.0,
                        width: double.infinity,
                        child: FlatButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              setState(() {
                                loading = true;
                              });
                              AuthService.login(context, _email, _password);
                            }
                          },
                          color: Theme.of(context).accentColor,
                          padding: EdgeInsets.all(10.0),
                          child: !loading
                              ? Text(
                                  AppLocalizations.of(context)
                                      .translate('ready_button'),
                                  style: TextStyle(
                                    // color: Colors.white,
                                    color: Theme.of(context)
                                        .textTheme
                                        .button
                                        .color,
                                    fontSize: 18.0,
                                  ),
                                )
                              : Container(
                                  height: 30.0,
                                  width: 30.0,
                                  child: CircularProgressIndicator(
                                    // backgroundColor: Colors.blue,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color.fromRGBO(245, 88, 123, 1),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignupScreen()),
                            );
                          },
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('register_ref'),
                                style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
