import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../getters/credentials.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool error_401 = false;
  String _email;
  String _password;
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidate: true,
      key: _formKey,
      child: new Theme(
        data: new ThemeData(
          primaryColor: Theme.of(context).accentColor,
          accentColor: Theme.of(context).accentColor,
        ),
        child: Container(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 60.0, right: 30.0),
                    child: Text(
                      "Dzień Dobry!",
                      style: GoogleFonts.comfortaa(
                        wordSpacing: 20.0,
                        color: Colors.black,
                        fontSize: 60.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: TextFormField(
                      showCursor: false,
                      decoration: InputDecoration(
                        labelText: "Adres email",
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(),
                      ),
                      // validator: (input) => !input.contains('@') ? 'Podaj prawdziwy mail' : null,
                      validator: (input) {
                        if (!input.contains('@')) {
                          return 'Podaj prawdziwy mail';
                        } else if (error_401) {
                          return 'Nieprawidłowy mail';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: TextFormField(
                      showCursor: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Hasło",
                        border: OutlineInputBorder(),
                      ),
                      validator: (input) {
                        if (input.length < 6) {
                          return 'Hasło musi mieć >= 6 znaków';
                        } else if (error_401) {
                          return 'Nieprawidłowe hasło';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (input) => _password = input,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 50.0,
                    margin: EdgeInsets.only(bottom: 50.0),
                    child: FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (getCredentials(_email, _password, context) ==
                              "401") {
                            setState(() {
                              error_401 = true;
                            });
                          }
                        }
                      },
                      color: Theme.of(context).accentColor,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Wszystko Gotowe!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
