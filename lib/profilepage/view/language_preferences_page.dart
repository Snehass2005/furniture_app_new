import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:furniture_ui/app_translations.dart';

class LanguagePreferencesPage extends StatelessWidget {
  const LanguagePreferencesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("select_language".tr)),
      body: Column(
        children: [
          ListTile(
            title: Text("english".tr),
            onTap: () => Get.updateLocale(const Locale('en')),
          ),
          ListTile(
            title: Text("tamil".tr),
            onTap: () => Get.updateLocale(const Locale('ta')),
          ),
          ListTile(
            title: Text("hindi".tr),
            onTap: () => Get.updateLocale(const Locale('hi')),
          ),
        ],
      ),
    );
  }
}
