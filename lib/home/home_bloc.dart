import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bflutter_poc/global.dart';
import 'package:bflutter_poc/model/user.dart';

class HomeBloc {
  //Input
  var _subject = BehaviorSubject<String>();

  //Output
  Stream<User> _outputBloc;

  HomeBloc() {
    _outputBloc = _subject.asyncMap(_fetchUser).map(
      (data) {
        if (data.statusCode == 200) {
          return User.fromJson(json.decode(data.body));
        } else {
          throw Exception(data.body);
        }
      },
    ).asBroadcastStream();
  }

  // Get model from Bloc
  Stream get getState => _outputBloc;

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
