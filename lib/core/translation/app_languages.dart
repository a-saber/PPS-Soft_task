import 'languages/ar_sa.dart';
import 'languages/en_us.dart';
import 'language_model.dart';

/// THE single source of truth for every language in the app.
///
/// [TranslationService] reads this list to build GetX's `keys` map and
/// `supportedLocales` — nothing is duplicated or hardcoded a second time.
///
/// To add full support for a new language:
/// 1. Create `languages/xx_yy.dart` exporting a `const Map<String, String>`
///    with the SAME keys as [enUS]/[arSA] (copy one and translate values).
/// 2. Import it below and pass it as `translations:` on a new/existing
///    [LanguageModel] entry in [all].
/// That's it — [TranslationService] will pick it up automatically.
///
/// Languages listed WITHOUT a `translations:` map still show up fine in a
/// language picker (flag + name), they're just not wired into GetX yet.
class AppLanguages {
  AppLanguages._();

  static const LanguageModel arabic = LanguageModel(
    code: 'ar',
    countryCode: 'SA',
    name: 'Arabic',
    nativeName: 'العربية',
    flag: '🇸🇦',
    isRtl: true,
    translations: arSA,
  );

  static const LanguageModel arabicEgypt = LanguageModel(
    code: 'ar',
    countryCode: 'EG',
    name: 'Arabic (Egypt)',
    nativeName: 'العربية (مصر)',
    flag: '🇪🇬',
    isRtl: true,
  );

  static const LanguageModel english = LanguageModel(
    code: 'en',
    countryCode: 'US',
    name: 'English',
    nativeName: 'English',
    flag: '🇺🇸',
    translations: enUS,
  );

  static const LanguageModel englishUk = LanguageModel(
    code: 'en',
    countryCode: 'GB',
    name: 'English (UK)',
    nativeName: 'English (UK)',
    flag: '🇬🇧',
  );

  static const LanguageModel french = LanguageModel(
    code: 'fr',
    countryCode: 'FR',
    name: 'French',
    nativeName: 'Français',
    flag: '🇫🇷',
  );

  static const LanguageModel german = LanguageModel(
    code: 'de',
    countryCode: 'DE',
    name: 'German',
    nativeName: 'Deutsch',
    flag: '🇩🇪',
  );

  static const LanguageModel spanish = LanguageModel(
    code: 'es',
    countryCode: 'ES',
    name: 'Spanish',
    nativeName: 'Español',
    flag: '🇪🇸',
  );

  static const LanguageModel italian = LanguageModel(
    code: 'it',
    countryCode: 'IT',
    name: 'Italian',
    nativeName: 'Italiano',
    flag: '🇮🇹',
  );

  static const LanguageModel portuguese = LanguageModel(
    code: 'pt',
    countryCode: 'PT',
    name: 'Portuguese',
    nativeName: 'Português',
    flag: '🇵🇹',
  );

  static const LanguageModel portugueseBrazil = LanguageModel(
    code: 'pt',
    countryCode: 'BR',
    name: 'Portuguese (Brazil)',
    nativeName: 'Português (Brasil)',
    flag: '🇧🇷',
  );

  static const LanguageModel russian = LanguageModel(
    code: 'ru',
    countryCode: 'RU',
    name: 'Russian',
    nativeName: 'Русский',
    flag: '🇷🇺',
  );

  static const LanguageModel turkish = LanguageModel(
    code: 'tr',
    countryCode: 'TR',
    name: 'Turkish',
    nativeName: 'Türkçe',
    flag: '🇹🇷',
  );

  static const LanguageModel chineseSimplified = LanguageModel(
    code: 'zh',
    countryCode: 'CN',
    name: 'Chinese (Simplified)',
    nativeName: '简体中文',
    flag: '🇨🇳',
  );

  static const LanguageModel japanese = LanguageModel(
    code: 'ja',
    countryCode: 'JP',
    name: 'Japanese',
    nativeName: '日本語',
    flag: '🇯🇵',
  );

  static const LanguageModel korean = LanguageModel(
    code: 'ko',
    countryCode: 'KR',
    name: 'Korean',
    nativeName: '한국어',
    flag: '🇰🇷',
  );

  static const LanguageModel hindi = LanguageModel(
    code: 'hi',
    countryCode: 'IN',
    name: 'Hindi',
    nativeName: 'हिन्दी',
    flag: '🇮🇳',
  );

  static const LanguageModel urdu = LanguageModel(
    code: 'ur',
    countryCode: 'PK',
    name: 'Urdu',
    nativeName: 'اردو',
    flag: '🇵🇰',
    isRtl: true,
  );

  static const LanguageModel dutch = LanguageModel(
    code: 'nl',
    countryCode: 'NL',
    name: 'Dutch',
    nativeName: 'Nederlands',
    flag: '🇳🇱',
  );

  static const LanguageModel swedish = LanguageModel(
    code: 'sv',
    countryCode: 'SE',
    name: 'Swedish',
    nativeName: 'Svenska',
    flag: '🇸🇪',
  );

  static const LanguageModel greek = LanguageModel(
    code: 'el',
    countryCode: 'GR',
    name: 'Greek',
    nativeName: 'Ελληνικά',
    flag: '🇬🇷',
  );

  static const LanguageModel hebrew = LanguageModel(
    code: 'he',
    countryCode: 'IL',
    name: 'Hebrew',
    nativeName: 'עברית',
    flag: '🇮🇱',
    isRtl: true,
  );

  static const LanguageModel indonesian = LanguageModel(
    code: 'id',
    countryCode: 'ID',
    name: 'Indonesian',
    nativeName: 'Bahasa Indonesia',
    flag: '🇮🇩',
  );

  /// Full list — reorder, filter, or trim as needed for your app.
  /// This is the ONE list everything else (pickers, GetX locales/keys,
  /// RTL detection...) is derived from.
  static const List<LanguageModel> all = [
    arabic,
    arabicEgypt,
    english,
    englishUk,
    french,
    german,
    spanish,
    italian,
    portuguese,
    portugueseBrazil,
    russian,
    turkish,
    chineseSimplified,
    japanese,
    korean,
    hindi,
    urdu,
    dutch,
    swedish,
    greek,
    hebrew,
    indonesian,
  ];

  /// Only the languages that actually have a translation map registered.
  /// This is what [TranslationService] uses to build `keys` and
  /// `supportedLocales` — adding a `translations:` map above is all it
  /// takes for a language to appear here automatically.
  static List<LanguageModel> get translated =>
      all.where((lang) => lang.isTranslated).toList();

  /// Find a language by its code (and optionally country code).
  /// Searches the FULL list, including languages without translations yet.
  static LanguageModel? findByCode(String code, {String? countryCode}) {
    try {
      return all.firstWhere(
            (lang) =>
        lang.code == code &&
            (countryCode == null || lang.countryCode == countryCode),
      );
    } catch (_) {
      return null;
    }
  }

  /// Same as [findByCode] but only searches languages that actually have a
  /// translation map registered. Used when resolving the device locale,
  /// since matching an untranslated language would leave GetX with no
  /// strings to show.
  static LanguageModel? findTranslatedByCode(String code, {String? countryCode}) {
    try {
      return translated.firstWhere(
            (lang) =>
        lang.code == code &&
            (countryCode == null || lang.countryCode == countryCode),
      );
    } catch (_) {
      return null;
    }
  }

  /// Find a language by GetX's locale tag, e.g. "ar_SA" or "en".
  static LanguageModel? findByLocaleTag(String localeTag) {
    try {
      return all.firstWhere((lang) => lang.localeTag == localeTag);
    } catch (_) {
      return null;
    }
  }
}