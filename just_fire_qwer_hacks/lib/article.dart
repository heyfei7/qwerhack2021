import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class Article {
  Article({this.title, this.url, this.getContent});
  final String title;
  final String url;
  final Function getContent;
}

var articles = [
  Article(
      title: "What my parents think about my bisexuality...",
      url:
          "https://bi.org/en/articles/what-my-parents-think-about-my-bisexuality",
      getContent: (document) {
        return document.getElementById("article").text;
      }),
  Article(
      title: "Tips for Parents of LGBTQ Youth",
      url:
          "https://www.hopkinsmedicine.org/health/wellness-and-prevention/tips-for-parents-of-lgbtq-youth",
      getContent: (document) {
        var rtf = document.getElementsByClassName('rtf');
        return rtf[0].text;
      }),
];

class ArticlePage extends StatefulWidget {
  ArticlePage(this.article, {Key key}) : super(key: key);

  final Article article;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  WebViewController _controller;
  String content = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print('[webView/build] ${widget.article.url}');
            if (content == "") {
            } else if (_controller != null) {
              _controller.loadUrl(Uri.dataFromString(content,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))
                  .toString());
            }
            return Scaffold(
              appBar: AppBar(
                // Here we take the value from the MyHomePage object that was created by
                // the App.build method, and use it to set our appbar title.
                title: Text(widget.article.title),
              ),
              body: Center(
                child: Container(
                  child: WebView(
                    initialUrl: 'about:blank',
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller = webViewController;
                    },
                  ),
                ),
              ),
            );
          } else
            return Scaffold(
              appBar: AppBar(title: Text(widget.article.title)),
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      content,
                      textScaleFactor: 1.2,
                    ),
                  )
                ],
              ),
            );
        },
        future: _fetchArticle());
  }

  Future<String> _fetchArticle() async {
    print("[webView/_fetchArticle] fetching ${widget.article.url}");
    var response = await http.get(widget.article.url);
    print("[webView/_fetchArticle] fetched ${response.statusCode}");
    if (response.statusCode == 200) {
      var document = parse(response.body);
      setState(() {
        content = widget.article.getContent(document);
      });
    } else {
      throw Exception();
    }
    return content;
  }
}
