import 'package:flutter/material.dart';

import 'package:just_fire_qwer_hacks/languageHotSwap.dart';
import 'package:just_fire_qwer_hacks/localization.dart';

import 'package:just_fire_qwer_hacks/listInSearch.dart';

import 'package:just_fire_qwer_hacks/pickLang.dart';
import 'package:just_fire_qwer_hacks/pickPref.dart';

import './article.dart';

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
      home: HomePage(title: ''),
      routes: {
        "/lang": (context) => PickLangPage(),
        "/hslang": (context) => HotswapLang(),
        "/article": (context) => ArticlePage(articles[0]),
        "/pref": (context) => PickPrefPage(),
      },
      debugShowCheckedModeBanner: false,
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
  TextEditingController _searchController = TextEditingController();

  List<Widget> _resultsList = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    print(_searchController.text);
  }

  searchResultsList() {
    setState(() {
      _resultsList = buildList();
    });
  }

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
        actions: [
          IconButton(
              icon: Icon(Icons.language),
              alignment: Alignment.centerLeft,
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Pick Your Top Languages'),
                        content: Text(
                            'Pick every language you wish to be able to view the articles in.'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushNamed(context, "/lang");
                            },
                          ),
                        ],
                      );
                    });
              }),
          HotswapLangButton(),
          IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.pushNamed(context, "/pref");
              })
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                Navigator.pushNamed(context, "/article");
              },
            ),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
              //decoration: InputDecoration(hintText: 'Search...'),
            ),
            Container(height: 600.0, child: ListView(children: buildList())),
          ],
        ),
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
