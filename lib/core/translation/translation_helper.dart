import 'dart:ui';

import 'package:get/get.dart';
import 'package:pps_soft_task/core/cache/cache_data.dart';

import 'app_languages.dart';
import 'language_model.dart';

/// The single GetX [Translations] implementation for the whole app.
///
/// Everything here is GENERATED from [AppLanguages.all] — there is no
/// second hardcoded list of locales or keys anywhere. Add a language with
/// a `translations:` map in `app_languages.dart` and it shows up here
/// automatically.

class TranslationHelper extends Translations {
  TranslationHelper._();
  static final TranslationHelper _instance = TranslationHelper._();
  factory TranslationHelper() => _instance;

  /// GetX requires a key->translations map. Built directly from every
  /// [LanguageModel] in [AppLanguages.all] that has a `translations` map.
  @override
  Map<String, Map<String, String>> get keys => {
    for (final language in AppLanguages.translated)
      language.localeTag: language.translations!,
  };

  /// All Flutter [Locale]s GetX should treat as supported — derived from
  /// the same source, so it can never drift out of sync with [keys].
  static List<Locale> get supportedLocales => AppLanguages.translated
      .map((language) => Locale(language.code, language.countryCode))
      .toList();

  /// The hard default when nothing else applies: no saved choice AND the
  /// device locale isn't one of our supported languages -> English.
  static LanguageModel get fallbackLanguage => AppLanguages.english;

  static Locale get fallbackLocale => Locale(
    fallbackLanguage.code,
    fallbackLanguage.countryCode,
  );

  /// Decides which locale the app should boot with. Order of priority:
  ///
  /// 1. [savedLocaleTag] — pass whatever you read from local storage
  ///    (SharedPreferences/GetStorage). If it matches a translated
  ///    language, that wins, full stop (the user explicitly chose it
  ///    before).
  /// 2. The device's locale ([Get.deviceLocale]) — IF it matches one of
  ///    our translated languages. Tries an exact code+country match first
  ///    (e.g. ar_SA), then falls back to a code-only match (e.g. any "ar"
  ///    we support) so a device set to ar_EG still gets Arabic even if we
  ///    only registered ar_SA.
  /// 3. [fallbackLanguage] (English) — if neither of the above matched,
  ///    e.g. the device is set to a language the app doesn't support yet.
  ///
  /// Call this ONCE on app start and feed the result into
  /// `GetMaterialApp(locale: ...)`.
  static Locale resolveInitialLocale() {
    var savedLocaleTag = CacheData.lang.value;
    if (savedLocaleTag != null) {
      final saved = AppLanguages.findByLocaleTag(savedLocaleTag);
      if (saved != null && saved.isTranslated) {
        return Locale(saved.code, saved.countryCode);
      }
    }

    final device = Get.deviceLocale;
    if (device != null) {
      final match = AppLanguages.findTranslatedByCode(
        device.languageCode,
        countryCode: device.countryCode,
      ) ??
          AppLanguages.findTranslatedByCode(device.languageCode);
      if (match != null) {
        return Locale(match.code, match.countryCode);
      }
    }

    return fallbackLocale;
  }

  /// The currently active [LanguageModel], resolved from GetX's current
  /// locale. Falls back to [fallbackLanguage] if it can't be matched.
  static LanguageModel get currentLanguage {
    final locale = Get.locale;
    if (locale == null) return fallbackLanguage;
    return AppLanguages.findTranslatedByCode(
      locale.languageCode,
      countryCode: locale.countryCode,
    ) ??
        AppLanguages.findTranslatedByCode(locale.languageCode) ??
        fallbackLanguage;
  }

  /// Switches the app language at runtime. Takes a [LanguageModel] instead
  /// of raw strings so the picker, the model, and GetX always agree on
  /// what "language" means.
  ///
  /// Pair this with your storage of choice (SharedPreferences/GetStorage)
  /// to persist `language.localeTag` so [resolveInitialLocale] can read it
  /// back as `savedLocaleTag` next launch.
  static void changeLanguage(LanguageModel language) {
    assert(
    language.isTranslated,
    'Tried to switch to "${language.name}" but it has no translations '
        'registered in app_languages.dart yet.',
    );
    CacheData.lang.set(language.localeTag);
    Get.updateLocale(Locale(language.code, language.countryCode));
  }

  /// Whether the currently active language is RTL — derived from the
  /// matched [LanguageModel], not a hardcoded list of codes.
  static bool get isCurrentLocaleRtl => currentLanguage.isRtl;
}