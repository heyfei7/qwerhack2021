import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class _Lang extends StatefulWidget {
  final Flag flag;
  final String langName;
  bool selected = false;

  _Lang({this.flag, this.langName});

  @override
  _LangState createState() => _LangState();
}

class _LangState extends State<_Lang> {
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

class PickLangPage extends StatelessWidget {
  //Will change as more languages get added
  final List<_Lang> langs = [
    _Lang(
        flag: Flag(
          "gb",
          height: 80,
          width: 110,
        ),
        langName: "English"),
    _Lang(
        flag: Flag(
          "cn",
          height: 80,
          width: 110,
        ),
        langName: "Mandarin"),
    _Lang(
        flag: Flag(
          "in",
          height: 80,
          width: 110,
        ),
        langName: "Hindi"),
    _Lang(
        flag: Flag(
          "es",
          height: 80,
          width: 110,
        ),
        langName: "Spanish"),
    _Lang(
        flag: Flag(
          "fr",
          height: 80,
          width: 110,
        ),
        langName: "French"),
  ];

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
        children: langs,
      ),
    );
  }
}
