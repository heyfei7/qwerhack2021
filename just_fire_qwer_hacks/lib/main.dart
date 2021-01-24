import 'package:flutter/material.dart';
import 'package:just_fire_qwer_hacks/listInSearch.dart';
import 'package:just_fire_qwer_hacks/pickLang.dart';
import 'package:just_fire_qwer_hacks/pickPref.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Flutter Demo Home Page'),
      routes: {
        "/lang": (context) => PickLangPage(),
        "/pref": (context) => PickPrefPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/lang");
          },
          child: Icon(
            Icons.language,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.pushNamed(context, "/pref");
              })
        ],
      ),
      body: Center(
        child: ListView(children: buildList()),
      ),
    );
  }
}

_searchBar() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(hintText: 'Search...'),
      onChanged: (text) {
        text = text.toLowerCase();
      },
    ),
  );
}
