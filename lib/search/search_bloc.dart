import 'dart:convert';
import 'package:bflutter_poc/model/user_base.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bflutter_poc/global.dart';

class SearchBloc {
  //Input
  var _subject = BehaviorSubject<String>();

  Function(String) get push => _subject.add;

  //Output
  Stream<List<UserBase>> get stream =>
      _subject.distinct().debounce(Duration(milliseconds: 300)).asyncMap(_fetchUsers).map(
        (data) {
          if (data.statusCode == 200) {
            final List<UserBase> result = json
                .decode(data.body)['items']
                .cast<Map<String, dynamic>>()
                .map<UserBase>((item) => UserBase.fromJson(item))
                .toList();
            print(result);
            return result;
          } else {
            throw Exception(data.body);
          }
        },
      ).asBroadcastStream();

  Future<http.Response> _fetchUsers(String query) {
    String url = '${Global.instance.env.apiBaseUrl}search/users?q=$query';
    print(url);
    return http.get(url);
  }

  void dispose() {
    _subject.close();
  }
}
