import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream/screens/login_screen.dart';
import 'package:stream/services/app_localizations.dart';
import '../services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // bool error_401 = false;
  // String _error401Email = "a";
  // String _error401Password = "a";
  String _email;
  String _password;
  String _nickname;
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
                      labelText: AppLocalizations.of(context)
                          .translate('nickname_form'),
                      fillColor: Colors.grey,
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
                    validator: (input) => input.length < 4
                        ? AppLocalizations.of(context)
                            .translate('nick_validator')
                        : null,
                    onSaved: (input) => _nickname = input,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextFormField(
                    showCursor: false,
                    decoration: InputDecoration(
                      labelText:
                          AppLocalizations.of(context).translate('email_form'),
                      fillColor: Colors.grey,
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
                    validator: (input) => !input.contains('@')
                        ? AppLocalizations.of(context)
                            .translate('email_validator')
                        : null,
                    onSaved: (input) => _email = input,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
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
                      Expanded(
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          child: FlatButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                setState(() {
                                  loading = true;
                                });
                                AuthService.signUpUser(
                                  context,
                                  _nickname,
                                  _email,
                                  _password,
                                );
                              }
                            },
                            color: Theme.of(context).accentColor,
                            padding: EdgeInsets.all(10.0),
                            child: !loading
                                ? Text(
                                    AppLocalizations.of(context)
                                        .translate('ready_button'),
                                    style: TextStyle(
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
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('login_ref'),
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
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
