import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:furniture_ui/app_translations.dart';
import '../constants/constant.dart';
import 'package:get/get.dart';

class AppTranslations extends Translations {
  final Map<String, Map<String, String>> translations;

  AppTranslations(this.translations);

  @override
  Map<String, Map<String, String>> get keys => translations;
}

Future<Map<String, Map<String, String>>> loadTranslations() async {
  String enJson = await rootBundle.loadString(englishLanguage);
  String taJson = await rootBundle.loadString(tamilLanguage);
  String hiJson = await rootBundle.loadString(hindiLanguage);

  Map<String, dynamic> enMap = json.decode(enJson);
  Map<String, dynamic> taMap = json.decode(taJson);
  Map<String, dynamic> hiMap = json.decode(hiJson);

  return {
    'en': Map<String, String>.from(enMap),
    'ta': Map<String, String>.from(taMap),
    'hi': Map<String, String>.from(hiMap),
  };
}
