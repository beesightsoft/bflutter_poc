import 'package:bflutter_poc/detail/detail_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Screen')),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                onChanged: (text) {},
                decoration:
                    InputDecoration(hintText: 'Please enter a search term'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemBuilder: (BuildContext context, int index) {
                  return FlatButton(
                    child: Text('entry $index'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen()));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
