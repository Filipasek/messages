import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stream/screens/thread_list_screen.dart';
import 'package:flutter/material.dart';

_save(String _value) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'my_credentials_key';
  final value = _value;
  prefs.setString(key, value);
  print('saved $value');
}

Future<String> getCredentials(_mail, _password, context) async {
  print(_mail);
  print(_password);
  final String _query = '{"email": "$_mail","password": "$_password"}';
  final response = await http.get(
    'https://messages-server.glitch.me/createCredentials',
    headers: {
      "JSON-Credentials": _query,
    },
  );
  if (response.statusCode == 200) {
    print(response.toString());
    _save(response.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ThreadListScreen(),
      ),
    );
    return "200";
  } else if(response.statusCode == 401){
    return "401";
  }else {
    throw Exception('Failed to load the Credentials!');
  }
}
