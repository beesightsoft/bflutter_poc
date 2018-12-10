import 'dart:convert';
import 'package:bflutter_poc/model/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bflutter_poc/global.dart';

class DetailBloc {
  //For loading
  BehaviorSubject loadingSubject = BehaviorSubject<bool>();

  //Input
  var _subject = BehaviorSubject<String>();

  Function(String) get push => _subject.add;

  //Output
  Stream<User> get stream => _subject
      .map(
        (query) {
          //show loading
          loadingSubject.add(true);
          return query;
        },
      )
      .asyncMap(_fetchUser)
      .map(
        (data) {
          //hide loading
          loadingSubject.add(false);

          if (data.statusCode == 200) {
            return User.fromJson(json.decode(data.body));
          } else {
            throw Exception(data.body);
          }
        },
      )
      .asBroadcastStream();

  Future<http.Response> _fetchUser(String username) {
    String url = '${Global.instance.env.apiBaseUrl}users/$username';
    return http.get(url);
  }

  void dispose() {
    _subject.close();
  }
}
