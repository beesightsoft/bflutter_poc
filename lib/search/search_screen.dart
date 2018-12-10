import 'package:bflutter_poc/detail/detail_screen.dart';
import 'package:bflutter_poc/model/user.dart';
import 'package:bflutter_poc/model/user_base.dart';
import 'package:bflutter_poc/search/search_bloc.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final bloc = new SearchBloc();

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
                onChanged: bloc.push,
                decoration:
                    InputDecoration(hintText: 'Please enter a search term'),
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
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    print(snapshot.data);
                    List<UserBase> users = snapshot.data;
                    return ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FlatButton(
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(users[index].avatarUrl),
                                radius: 20.0,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text('${users[index].login}'),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen()));
                          },
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
