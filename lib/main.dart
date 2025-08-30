// lib/main.dart
import 'package:flutter/material.dart';
import 'package:furniture_ui/cardpage/viewmodel/card_viewmodel.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'homepage/view_model/product_viewmodel.dart';
import 'homepage/view_model/theme_viewmodel.dart';
import 'constants/constant.dart';
import 'app_translations.dart';
import 'router/app_router.dart';
import 'config/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final languageConfig = await loadTranslations(); // load your JSONs
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: FurnitureApp(languageConfig: languageConfig),
    ),
  );
}

class FurnitureApp extends StatelessWidget {
  const FurnitureApp({super.key, required this.languageConfig});

  final Map<String, Map<String, String>> languageConfig;

  @override
  Widget build(BuildContext context) {
    // Use Consumer so the GetMaterialApp rebuilds when themeMode changes
    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, child) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Furniture Shopping UI',
          translations: AppTranslations(languageConfig),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeViewModel.themeMode,
          supportedLocales: const [
            Locale('en'),
            Locale('ta'),
            Locale('hi'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // GoRouter integration (your existing appRouter)
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
        );
      },
    );
  }
}
