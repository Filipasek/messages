import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import 'package:http/http.dart' as http;

_read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_credentials_key';
    final value = prefs.getString(key) ?? 0;
    // print('read: $value');
    return value;
  }

Future<ThreadList> getThreadList() async {
  final credentials = await _read();
  final response = await http.get(
    'https://messages-server.glitch.me/threadList',
    headers: {
      "JSON-Credentials":
          credentials,
    },
  );
  if (response.statusCode == 200) {
    ThreadList list = new ThreadList.fromJson(json.decode(response.body));

    return list;
  } else {
    throw Exception('Failed to load the Thread List!');
  }
}
