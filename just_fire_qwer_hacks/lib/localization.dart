import 'package:flutter/material.dart';
import 'package:just_fire_qwer_hacks/langModel.dart';
import 'package:translator/translator.dart';
import "pickLang.dart";

Future<String> _translateText({String input, String from, String to}) async {
  final translator = GoogleTranslator();

  var result = await translator.translate(input, from: from, to: to);
  return result.text;
}

class LanguageManager {
  static String _currentLang = "en";

  static Future<String> changeActiveLanguage(
      String textBlock, String newLangAbbrev) async {
    String result = await _translateText(
        input: textBlock, from: _currentLang, to: newLangAbbrev);

    _currentLang = newLangAbbrev;
    return textBlock;
  }
}

class LanguageDropdown extends StatefulWidget {
  @override
  _LanguageDropdownState createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  List<DropdownMenuItem<Text>> langList = [];

  @override
  Widget build(BuildContext context) {
    buildItems();
    return DropdownButton(items: langList, onChanged: null);
  }

  Future<void> buildItems() async {
    langList.clear();
    final langMap = await LangModel.getLangList();

    final abrevs = {
      "en": "English",
      "zh": "中文",
      "hi": "हिंदी",
      "es": "española",
      "fr": "française"
    };

    langMap.forEach((key, value) {
      if (value == "true")
        langList.add(DropdownMenuItem<Text>(
          child: Text(abrevs[key]),
          onTap: () async {
            LanguageManager._currentLang = key;
          },
        ));
    });
  }
}
