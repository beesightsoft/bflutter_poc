import 'package:bflutter_poc/env/AppConfig.dart';
import 'package:bflutter_poc/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:bflutter/bflutter.dart';

void main() => runApp(
      AppConfig(
        appName: 'Build flavors DEV',
        flavorName: 'development',
        apiBaseUrl: 'https://api.github.com/',
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: true,
      home: HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final bloc = Bloc<int>();

  void _incrementCounter() {
    bloc.addToBloc(++_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
              stream: bloc.getFromBloc(),
              initialData: 0,
              builder: (context, snapshot) => Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.display1,
                  ),
            ),
            TestStatelessWidget(),
            TestStateFullWidget()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TestStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String msg = 'TestStatelessWidget render ${DateTime.now()}';
    print(msg);
    return Text(msg);
  }
}

class TestStateFullWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TestStateFullSate();
  }
}

class _TestStateFullSate extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    String msg = '_TestStateFullSate render ${DateTime.now()}';
    print(msg);
    return OutlineButton(
      child: Text('BeeSight Soft'),
      onPressed: () {
        setState(() {});
      },
    );
  }
}
