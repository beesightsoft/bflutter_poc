import 'dart:convert';
import 'package:bflutter_poc/model/user_base.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bflutter_poc/global.dart';

class SearchBloc {
  //For loading
  BehaviorSubject loadingSubject = BehaviorSubject<bool>();

  //Input
  var _subject = BehaviorSubject<String>();

  Function(String) get push => _subject.add;

  //Output
  Stream<List<UserBase>> get stream => _subject
          .distinct()
          .debounce(Duration(milliseconds: 500))
          .flatMap((input) {
        //show loading
        loadingSubject.add(true);
        if (input.isEmpty) return Observable.just(null);
        return Observable.fromFuture(_fetchUsers(input));
      }).map((data) {
        if (data == null) {
          return <UserBase>[];
        }

        if (data.statusCode == 200) {
          final List<UserBase> result = json
              .decode(data.body)['items']
              .cast<Map<String, dynamic>>()
              .map<UserBase>((item) => UserBase.fromJson(item))
              .toList();
          return result;
        } else {
          throw (data.body);
        }
      }).handleError((error) {
        loadingSubject.add(false);
        throw error;
      }).doOnData((data) {
        loadingSubject.add(false);
      }).asBroadcastStream();

  Future<http.Response> _fetchUsers(String query) {
    String url = '${Global.instance.env.apiBaseUrl}search/users?q=$query';
    return http.get(url);
  }

  void dispose() {
    _subject.close();
  }
}
