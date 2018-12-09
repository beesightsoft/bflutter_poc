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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text('hello'),
          RaisedButton(
            child: Text('Search Screen'),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
        ],
      ),
    );
  }
}
