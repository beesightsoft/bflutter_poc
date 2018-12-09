import 'dart:convert';

import 'package:bflutter_poc/home/home_bloc.dart';
import 'package:bflutter_poc/model/user.dart';
import 'package:bflutter_poc/search/search_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: _HomeInfo(),
    );
  }
}

class _HomeInfo extends StatefulWidget {
  @override
  __HomeInfoState createState() => __HomeInfoState();
}

class __HomeInfoState extends State<_HomeInfo> {
  var bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: bloc.getFromBloc(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text(json.encode(snapshot.data));
              },
            ),
            RaisedButton(
              child: Text('Search Screen'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.getHomeInfo();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
