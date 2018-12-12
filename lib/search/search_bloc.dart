import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:bflutter/bflutter.dart';
import 'package:bflutter_poc/api.dart';
import 'package:bflutter_poc/model/user_base.dart';

class SearchBloc {
  var loading = BlocDefault<bool>();
  var searchUser = Bloc<String, List<UserBase>>();

  SearchBloc() {
    _initSearchUserLogic();
  }

  void _initSearchUserLogic() {
    searchUser.business = (Observable<String> event) =>
        event.distinct().debounce(Duration(milliseconds: 500)).flatMap((input) {
          //show loading
          loading.push(true);
          if (input.isEmpty) return Observable.just(null);
          return Observable.fromFuture(Api().searchUsers(input));
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
          loading.push(false);
          throw error;
        }).doOnData((data) {
          loading.push(false);
        }).asBroadcastStream();
  }

  void dispose() {
    loading.dispose();
    searchUser.dispose();
  }
}
