import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/thread_list_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: new Theme(
        data: new ThemeData(
          primaryColor: Theme.of(context).accentColor,
        ),
        child: Container(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
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
                      alignLabelWithHint: true,
                      hintText: "Oczywiście taki, jak na Messengerze",
                      border: OutlineInputBorder(),
                    ),
                    validator: (input) =>
                        !input.contains('@') ? 'Podaj prawdziwy mail' : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: TextFormField(
                    showCursor: false,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Hasło",
                      alignLabelWithHint: true,
                      hintText: "Oczywiście takie, jak na Messengerze",
                      border: OutlineInputBorder(),
                    ),
                    validator: (input) =>
                        input.length < 6 ? 'Hasło musi mieć >= 6 znaków' : null,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: FlatButton(
                    // onPressed: () {
                    //   if (_formKey.currentState.validate()) {
                    //     Scaffold.of(context).showSnackBar(SnackBar(
                    //       content: Text('Przetwarzanie danych'),
                    //     ));
                    //   }
                    // },
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ThreadListScreen()),
                    ),
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
    );
  }
}
