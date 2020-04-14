import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving data'),
      ),
      body: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Read'),
              onPressed: () {
                _read();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              child: Text('Save'),
              onPressed: () {
                _save();
              },
            ),
          ),
        ],
      ),
    );
  }

  // Replace these two methods in the examples that follow

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = prefs.getString(key) ?? 0;
    print('read: $value');
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'my_int_key';
    final value = '[{ "key": "datr", "value": "5IiQXkEbkAne00pKn_CBj1DV", "domain": "facebook.com", "path": "/", "hostOnly": false, "creation": "2020-04-10T14:55:33.099Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "fr", "value": "1onJo8ezsPzlPOBJ4.AWXll299FwYpBacHAs9A0LnVjzo.BekIjk.8X.AAA.0.0.BekIjl.AWXwcq5W", "expires": "2020-07-09T14:55:29.000Z", "maxAge": 7775996, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:33.128Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "sb", "value": "5IiQXir6ev4oAWWxZTnji4kp", "expires": "2022-04-10T14:55:33.000Z", "maxAge": 63072000, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:33.131Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "c_user", "value": "100049996898966", "expires": "2021-04-10T14:55:31.000Z", "maxAge": 31535998, "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.716Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "xs", "value": "32%3A3feyOm4uDTvDWg%3A2%3A1586530533%3A-1%3A-1", "expires": "2021-04-10T14:55:31.000Z", "maxAge": 31535998, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.718Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "spin", "value": "r.1001973156_b.trunk_t.1586530535_s.1_v.2_", "expires": "2020-04-11T15:55:35.000Z", "maxAge": 90000, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.888Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "presence", "value": "EDvF3EtimeF1586530538EuserFA21B49996898966A2EstateFDutF0Et2F_5b_5dElm2FnullEuct2F1586530538966EtrFnullEtwF1874024300EatF1586530538966CEchFDp_5f1B49996898966F0CC", "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.968Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "locale", "value": "en_US", "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.972Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "a11y", "value": "%7B%22sr%22%3A0%2C%22sr-ts%22%3A1586530538976%2C%22jk%22%3A0%2C%22jk-ts%22%3A1586530538976%2C%22kb%22%3A0%2C%22kb-ts%22%3A1586530538976%2C%22hcm%22%3A0%2C%22hcm-ts%22%3A1586530538976%7D", "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.977Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "datr", "value": "5IiQXkEbkAne00pKn_CBj1DV", "domain": "facebook.com", "path": "/", "hostOnly": false, "creation": "2020-04-10T14:55:33.099Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "fr", "value": "1onJo8ezsPzlPOBJ4.AWXll299FwYpBacHAs9A0LnVjzo.BekIjk.8X.AAA.0.0.BekIjl.AWXwcq5W", "expires": "2020-07-09T14:55:29.000Z", "maxAge": 7775996, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:33.128Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "sb", "value": "5IiQXir6ev4oAWWxZTnji4kp", "expires": "2022-04-10T14:55:33.000Z", "maxAge": 63072000, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:33.131Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "c_user", "value": "100049996898966", "expires": "2021-04-10T14:55:31.000Z", "maxAge": 31535998, "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.716Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "xs", "value": "32%3A3feyOm4uDTvDWg%3A2%3A1586530533%3A-1%3A-1", "expires": "2021-04-10T14:55:31.000Z", "maxAge": 31535998, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.718Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "spin", "value": "r.1001973156_b.trunk_t.1586530535_s.1_v.2_", "expires": "2020-04-11T15:55:35.000Z", "maxAge": 90000, "domain": "facebook.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.888Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "presence", "value": "EDvF3EtimeF1586530538EuserFA21B49996898966A2EstateFDutF0Et2F_5b_5dElm2FnullEuct2F1586530538966EtrFnullEtwF1874024300EatF1586530538966CEchFDp_5f1B49996898966F0CC", "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.968Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "locale", "value": "en_US", "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.972Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "a11y", "value": "%7B%22sr%22%3A0%2C%22sr-ts%22%3A1586530538976%2C%22jk%22%3A0%2C%22jk-ts%22%3A1586530538976%2C%22kb%22%3A0%2C%22kb-ts%22%3A1586530538976%2C%22hcm%22%3A0%2C%22hcm-ts%22%3A1586530538976%7D", "domain": "facebook.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.977Z", "lastAccessed": "2020-04-10T14:55:38.985Z" }, { "key": "sb", "value": "5IiQXir6ev4oAWWxZTnji4kp", "expires": "2022-04-10T14:55:33.000Z", "maxAge": 63072000, "domain": "messenger.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.726Z", "lastAccessed": "2020-04-10T14:55:38.988Z" }, { "key": "c_user", "value": "100049996898966", "expires": "2021-04-10T14:55:31.000Z", "maxAge": 31535998, "domain": "messenger.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.730Z", "lastAccessed": "2020-04-10T14:55:38.988Z" }, { "key": "xs", "value": "32%3A3feyOm4uDTvDWg%3A2%3A1586530533%3A-1%3A-1", "expires": "2021-04-10T14:55:31.000Z", "maxAge": 31535998, "domain": "messenger.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.734Z", "lastAccessed": "2020-04-10T14:55:38.988Z" }, { "key": "fr", "value": "1onJo8ezsPzlPOBJ4.AWXll299FwYpBacHAs9A0LnVjzo.BekIjk.8X.AAA.0.0.BekIjl.AWXwcq5W", "expires": "2020-07-09T14:55:29.000Z", "maxAge": 7775996, "domain": "messenger.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:35.737Z", "lastAccessed": "2020-04-10T14:55:38.988Z" }, { "key": "spin", "value": "r.1001973156_b.trunk_t.1586530535_s.1_v.2_", "expires": "2020-04-11T15:55:35.000Z", "maxAge": 90000, "domain": "messenger.com", "path": "/", "secure": true, "httpOnly": true, "hostOnly": false, "creation": "2020-04-10T14:55:37.421Z", "lastAccessed": "2020-04-10T14:55:38.988Z" }, { "key": "presence", "value": "EDvF3EtimeF1586530538EuserFA21B49996898966A2EstateFDutF0Et2F_5b_5dElm2FnullEuct2F1586530538966EtrFnullEtwF1874024300EatF1586530538966CEchFDp_5f1B49996898966F0CC", "domain": "messenger.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.970Z", "lastAccessed": "2020-04-10T14:55:38.988Z" }, { "key": "locale", "value": "en_US", "domain": "messenger.com", "path": "/", "secure": true, "hostOnly": false, "creation": "2020-04-10T14:55:38.974Z", "lastAccessed": "2020-04-10T14:55:38.988Z" }]';
    prefs.setString(key, value);
    print('saved $value');
  }
}
