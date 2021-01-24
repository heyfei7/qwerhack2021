import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

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
        return rtf[0].innerHTML;
      }),
];

class ArticlePage extends StatefulWidget {
  ArticlePage({Key key, this.article}) : super(key: key);

  final Article article;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool loaded = false;
  String content = "";

  @override
  Widget build(BuildContext context) {
    print('[webView/build] url: ${widget.article.url} ${this.loaded}');

    /*
    if (!this.loaded) {
      _fetchArticle();
    }*/
    _fetchArticle();

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.article.title),
      ),
      body: Center(
        child: Container(
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Text(
                content,
                //maxLines: 10,
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[800], fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _fetchArticle() async {
    print("Fetching article ${widget.article.url}");
    var response = await http.get(widget.article.url);
    if (response.statusCode == 200) {
      var document = parse(response.body);
      setState(() {
        loaded = true;
        content = widget.article.getContent(document);
        if (this.content == null) {
          content = "";
        }
      });
    } else {
      throw Exception();
    }
  }
}