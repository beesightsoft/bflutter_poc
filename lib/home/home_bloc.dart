import 'dart:convert';
import 'package:bflutter/bflutter.dart';
import 'package:bflutter_poc/api.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bflutter_poc/model/user.dart';

class HomeBloc {
  var getUserInfo = Bloc<String, User>();

  HomeBloc() {
    _initGetUserInfoLogic();
  }

  void _initGetUserInfoLogic() {
    getUserInfo.business =
        (Observable<String> event) => event.asyncMap(Api().getUserInfo).map(
              (data) {
                if (data.statusCode == 200) {
                  return User.fromJson(json.decode(data.body));
                } else {
                  throw Exception(data.body);
                }
              },
            ).asBroadcastStream();
  }

  void getHomeInfo() {
    getUserInfo.push('beesightsoft');
  }

  void dispose() {
    getUserInfo.dispose();
  }
}
