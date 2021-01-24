import 'package:flutter/material.dart';

class _Pref extends StatefulWidget {
  final String prefName;
  bool selected = false;

  _Pref({this.prefName});

  @override
  _PrefState createState() => _PrefState();
}

class _PrefState extends State<_Pref> {
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
            padding: const EdgeInsets.only(left: 1),
            child: Text(
              widget.prefName,
              textScaleFactor: 1.4,
            ),
          )
        ],
      ),
    ]);
  }
}

class PickPrefPage extends StatelessWidget {
  //Will change as more languages get added
  final List<_Pref> pref = [
    _Pref(prefName: "Asexual"),
    _Pref(prefName: "Bisexual"),
    _Pref(prefName: "Cisgender"),
    _Pref(prefName: "Demisexual"),
    _Pref(prefName: "Gay"),
    _Pref(prefName: "Lesbian"),
    _Pref(prefName: "Nonbinary"),
    _Pref(prefName: "Pansexual"),
    _Pref(prefName: "Queer"),
    _Pref(prefName: "Transgender"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preferences"),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(
            top: 16.0, bottom: 16.0, left: 16.0, right: 200.0),
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        crossAxisCount: 1,
        children: pref,
      ),
    );
  }
}
