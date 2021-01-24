import 'dart:math' show max;
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:http/http.dart' as http;

const articles = [
  {
    "title": "BOOP",
    "url":
        "https://bi.org/en/articles/what-my-parents-think-about-my-bisexuality"
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
  WebViewController _controller;
  double contentHeight = 0;
  bool loaded = false;
  String htmlContent = "";

  @override
  Widget build(BuildContext context) {
    print("Hello World@@!");
    print('[webView/build] url: ${widget.url}');
    check();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: max(MediaQuery.of(context).size.height, contentHeight),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildWebView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebView(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: Set.from([
        JavascriptChannel(
          name: 'JustFire',
          onMessageReceived: (JavascriptMessage message) {
            print('[webView/javascriptChannels] ${message.message}');
            setState(() {
              contentHeight = double.parse(message.message);
            });
          },
        )
      ]),
      onPageFinished: (String url) {
        print('[webView/onPageFinished] finished loading "$url"');
        /*
        if (url.contains('/finalresponse.html')) {
          _controller.evaluateJavascript(
              "(function(){JustFire.postMessage(window.document.body.outerHTML)})();");
        }*/
      },
      onWebViewCreated: (WebViewController ctrl) {
        print('[webView/onWebViewCreated] created');
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
    );
  }

  void check() async {
    var url = 'https://www.googleapis.com/books/v1/volumes?q={http}';
    // Await the http get response, then decode the json-formatted response.
    print("trying to get ${url}");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var itemCount = jsonResponse['totalItems'];
      print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
