import 'package:flutter/material.dart';
import 'package:just_fire_qwer_hacks/dbUtils.dart';
import 'package:just_fire_qwer_hacks/langModel.dart';
import 'package:just_fire_qwer_hacks/localization.dart';

class HotswapLangButton extends StatelessWidget {
  String content;
  HotswapLangButton(String c) {
    content = c;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.fireplace),
        onPressed: () {
          Navigator.pushNamed(context, "/hslang");
        });
  }
}

class HotswapLang extends StatefulWidget {
  _HotswapLangState createState() => _HotswapLangState();
}

class _HotswapLangState extends State<HotswapLang> {
  List<FlatButton> langList = [];

  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return Scaffold(
              appBar: AppBar(),
              body: ListView(
                children: langList,
              ),
            );
          else
            return CircularProgressIndicator();
        },
        future: asyncBuild());
  }

  Future<void> asyncBuild() async {
    if (!await DBUtils.getDBExists()) return;
    final langMap = await LangModel.getLangList();

    final abrevs = {
      "en": "English",
      "zh": "中文",
      "hi": "हिंदी",
      "es": "española",
      "fr": "française"
    };
    langMap.forEach((key, value) {
      if (value == "true") {
        langList.add(
          FlatButton(
            onPressed: () {
              LanguageManager.nLang = key;
              Navigator.pop(context);
            },
            child: Text(abrevs[key]),
          ),
        );
      }
    });
  }
}
