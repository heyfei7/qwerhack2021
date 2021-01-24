import 'dart:math' show max;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

const articles = [
  {
    "title": "BOOP",
    "url":
        "https://bi.org/en/articles/what-my-parents-think-about-my-bisexuality",
  },
  {
    "title": "[GUEST POST] WHEN YOUR CHILD COMES OUT AS BISEXUAL",
    "url":
        "https://shameproofparenting.com/guest-post-when-your-child-comes-out-as-bisexual/"
  }
];

class ArticleListPage extends StatefulWidget {
  ArticleListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(child: Container()));
  }
}

class ArticlePage extends StatefulWidget {
  ArticlePage({Key key, this.title, this.url}) : super(key: key);

  final String title;
  final String url;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  _ArticlePageState() : super() {
    _fetchArticle();
  }

  WebViewController _controller;
  dom.Document document;
  double contentHeight = 0;
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    print('[webView/build] url: ${widget.url} ${this.loaded}');

    if (!this.loaded) {
      _fetchArticle();
    } else {
      _loadHtmlFromAssets();
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              WebView(
                initialUrl: 'about:blank',
                onWebViewCreated: (WebViewController webViewController) {
                  this._controller = webViewController;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchArticle() async {
    print("Fetching article ${widget.url}");
    var response = await http.get(widget.url);
    if (response.statusCode == 200) {
      setState(() {
        document = parse(response.body);
        loaded = true;
      });
    } else {
      throw Exception();
    }
  }

  void _loadHtmlFromAssets() async {
    var text = this.document.getElementById("article").text;
    _controller.loadUrl(Uri.dataFromString(text,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
