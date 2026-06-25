/// Represents a single language option (used for language-switcher UIs,
/// localization pickers, AND as the single source of truth that drives
/// [TranslationService] — see app_languages.dart).
class LanguageModel {
  /// ISO 639-1 language code (e.g. "en", "ar")
  final String code;

  /// Optional country/locale code used with [code] to build a full locale
  /// (e.g. "US" -> en_US, "SA" -> ar_SA). Leave null if not needed.
  final String? countryCode;

  /// Language name in English (e.g. "Arabic")
  final String name;

  /// Language name in its own native script (e.g. "العربية")
  final String nativeName;

  /// Flag emoji as plain text (e.g. "🇸🇦")
  final String flag;

  /// Whether this language is RTL (right-to-left)
  final bool isRtl;

  /// The GetX translation map for this language (key -> translated text).
  /// `null` means this language is shown in pickers as metadata only but
  /// has NO translations registered yet — [TranslationService] will skip
  /// it when building `keys`/`supportedLocales` until you provide a map.
  final Map<String, String>? translations;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
    this.countryCode,
    this.isRtl = false,
    this.translations,
  });

  /// Full locale string, e.g. "en_US" or just "ar" if no country code.
  /// This is also the exact key GetX expects inside `Translations.keys`.
  String get localeTag =>
      countryCode != null && countryCode!.isNotEmpty ? '${code}_$countryCode' : code;

  /// Whether this language actually has a translation map registered.
  bool get isTranslated => translations != null;

  /// Convenience for display in dropdowns: "🇸🇦 العربية"
  String get displayLabel => '$flag $nativeName';

  /// Convenience for display with English name: "🇸🇦 Arabic"
  String get displayLabelEn => '$flag $name';

  LanguageModel copyWith({
    String? code,
    String? countryCode,
    String? name,
    String? nativeName,
    String? flag,
    bool? isRtl,
    Map<String, String>? translations,
  }) {
    return LanguageModel(
      code: code ?? this.code,
      countryCode: countryCode ?? this.countryCode,
      name: name ?? this.name,
      nativeName: nativeName ?? this.nativeName,
      flag: flag ?? this.flag,
      isRtl: isRtl ?? this.isRtl,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'countryCode': countryCode,
    'name': name,
    'nativeName': nativeName,
    'flag': flag,
    'isRtl': isRtl,
  };

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      code: json['code'] as String,
      countryCode: json['countryCode'] as String?,
      name: json['name'] as String,
      nativeName: json['nativeName'] as String,
      flag: json['flag'] as String,
      isRtl: json['isRtl'] as bool? ?? false,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LanguageModel &&
        other.code == code &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode => Object.hash(code, countryCode);

  @override
  String toString() => 'LanguageModel($flag $name [$localeTag])';
}