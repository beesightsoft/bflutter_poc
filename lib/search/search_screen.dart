import 'package:bflutter_poc/detail/detail_screen.dart';
import 'package:bflutter_poc/model/user_base.dart';
import 'package:bflutter_poc/search/search_bloc.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final bloc = SearchBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search Screen')),
      body: Container(
          child: GestureDetector(
        onTap: () {
          bloc.focusNode.unfocus();
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  Expanded(
                    child: TextField(
                      onChanged: bloc.searchUser.push,
                      autofocus: true,
                      focusNode: bloc.focusNode,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Please enter a search term',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Container(
              child: StreamBuilder(
                stream: bloc.loading.stream(),
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
                stream: bloc.searchUser.stream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (!snapshot.hasData || (snapshot?.data)?.length == 0) {
                    return Text('No data');
                  }
                  List<UserBase> users = snapshot.data;
                  return ListView.builder(
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
                                  builder: (context) =>
                                      DetailScreen(userBase: users[index])));
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
