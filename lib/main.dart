import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:pps_soft_task/core/cache/cache_helper.dart';
import 'package:pps_soft_task/core/services/service_locator.dart';
import 'package:pps_soft_task/core/theme/theme_helper.dart';

import 'core/theme/app_theme.dart';
import 'core/translation/translation_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.setupLocator();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: TranslationHelper(),
      locale: TranslationHelper.resolveInitialLocale(),
      fallbackLocale: TranslationHelper.fallbackLocale,
      supportedLocales: TranslationHelper.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeHelper.resolveInitialThemeMode(),
    );
  }
}


