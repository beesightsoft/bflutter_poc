import 'dart:convert';

import 'package:bflutter_poc/detail/detail_bloc.dart';
import 'package:bflutter_poc/model/user_base.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final UserBase userBase;

  final bloc = DetailBloc();

  DetailScreen({Key key, @required this.userBase}) : super(key: key) {
    if (userBase?.login?.isNotEmpty ?? false) {
      bloc.push(userBase.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen')),
      body: (userBase == null || userBase.login.isEmpty)
          ? Container(child: Text('user empty'))
          : Column(
              children: <Widget>[
                Container(
                  child: StreamBuilder(
                    stream: bloc.loadingSubject,
                    builder: (context, loading) {
                      if (loading.hasData && loading.data) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: bloc.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      return Text(json.encode(snapshot?.data ?? 'No data'));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
