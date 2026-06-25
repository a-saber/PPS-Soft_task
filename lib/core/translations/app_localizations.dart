import 'package:flutter/material.dart';
import 'ar.dart';
import 'en.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> get _strings => locale.languageCode == 'ar' ? arStrings : enStrings;

  bool get isArabic => locale.languageCode == 'ar';

  String tr(String key) => _strings[key] ?? key;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Sugar so screens can write `context.tr('save')` instead of the verbose
/// `AppLocalizations.of(context).tr('save')` everywhere.
extension LocalizationExtension on BuildContext {
  String tr(String key) => AppLocalizations.of(this).tr(key);
  bool get isArabic => AppLocalizations.of(this).isArabic;
}
