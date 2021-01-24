import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

Future<String> translateText({String input, String from, String to}) async {
  final translator = GoogleTranslator();

  var result = await translator.translate(input, from: from, to: to);
  return result.text;
}
