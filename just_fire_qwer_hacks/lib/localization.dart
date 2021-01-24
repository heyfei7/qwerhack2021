import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

Future<String> _translateText({String input, String from, String to}) async {
  final translator = GoogleTranslator();

  var result = await translator.translate(input, from: from, to: to);
  return result.text;
}

class LanguageManager {
  static String currentLang = "en";

  static Future<String> changeActiveLanguage(
      String textBlock, String newLangAbbrev) async {
    String result = await _translateText(
        input: textBlock, from: currentLang, to: newLangAbbrev);

    currentLang = newLangAbbrev;
    return result;
  }
}
