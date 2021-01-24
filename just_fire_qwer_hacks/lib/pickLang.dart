import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:just_fire_qwer_hacks/langModel.dart';

class Lang extends StatefulWidget {
  final Flag flag;
  final String langName;
  final String langAbbrev;
  bool selected = false;

  Lang({this.flag, this.langName, this.langAbbrev});

  @override
  _LangState createState() => _LangState();
}

class _LangState extends State<Lang> {
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Checkbox(
              value: widget.selected,
              onChanged: (v) {
                setState(() {
                  print(v);
                  widget.selected = v;
                  print(widget.selected);
                });
              }),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: widget.flag,
          ),
        ],
      ),
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 65),
            child: Text(
              widget.langName,
              textScaleFactor: 1.4,
            ),
          )
        ],
      )
    ]);
  }
}

class PickLangPage extends StatefulWidget {
  //Will change as more languages get added
  final List<Lang> langs = [
    Lang(
      flag: Flag(
        "gb",
        height: 80,
        width: 110,
      ),
      langName: "English",
      langAbbrev: "en",
    ),
    Lang(
      flag: Flag(
        "cn",
        height: 80,
        width: 110,
      ),
      langName: "Mandarin",
      langAbbrev: "zh",
    ),
    Lang(
      flag: Flag(
        "in",
        height: 80,
        width: 110,
      ),
      langName: "Hindi",
      langAbbrev: "hi",
    ),
    Lang(
      flag: Flag(
        "es",
        height: 80,
        width: 110,
      ),
      langName: "Spanish",
      langAbbrev: "es",
    ),
    Lang(
      flag: Flag(
        "fr",
        height: 80,
        width: 110,
      ),
      langName: "French",
      langAbbrev: "fr",
    ),
  ];

  _PickLangPageState createState() => _PickLangPageState();
}

class _PickLangPageState extends State<PickLangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Languages"),
      ),
      body: GridView.count(
        primary: false,
        padding: EdgeInsets.fromLTRB(90, 25, 140, 0),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        crossAxisCount: 1,
        children: widget.langs,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, String> langList = {};

          widget.langs.forEach((element) {
            langList[element.langAbbrev] = element.selected.toString();
          });
          await LangModel.insertLangList(langList);
          setState(() {});
          Navigator.pop(context);
        },
      ),
    );
  }
}
