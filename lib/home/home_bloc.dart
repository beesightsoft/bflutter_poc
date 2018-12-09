import 'dart:async';
import 'dart:convert';
import 'package:bflutter_poc/global.dart';
import 'package:bflutter_poc/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  //Input
  var _subject = BehaviorSubject<String>();

  //Output
  Stream<User> _outputBloc;

  HomeBloc() {
    _outputBloc = _subject
        .distinct()
        .debounce(Duration(milliseconds: 300))
        .asyncMap(_fetchUser)
        .map(
      (data) {
        if (data.statusCode == 200) {
          var user = User.fromJson(json.decode(data.body));
          print(json.encode(user));
          return user;
        } else {
          throw Exception('Failed to load post');
        }
      },
    ).asBroadcastStream();
  }

  // Get model from Bloc
  Stream getFromBloc() => _outputBloc;

  void getHomeInfo() {
    _subject.add('beesightsoft');
  }

  Future<http.Response> _fetchUser(String username) {
    return http.get('${Global.instance.env.apiBaseUrl}users/$username');
  }

  void dispose() {
    _subject.close();
  }
}
