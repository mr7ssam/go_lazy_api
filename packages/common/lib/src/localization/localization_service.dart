import 'package:common/src/localization/translations.g.dart';

class LocalizationService {
  LocalizationService({String locale = 'en'})
      : _locale = _validateLocale(locale),
        _translations = Translations(_validateLocale(locale));

  final String _locale;
  final Translations _translations;

  String get locale => _locale;

  static String _validateLocale(String locale) {
    return supportedLocales.contains(locale) ? locale : 'en';
  }

  // Direct access to translations object for type-safe access
  Translations get translations => _translations;

  // Static method to parse locale from Accept-Language header
  static String parseLocale(String? acceptLanguageHeader) {
    if (acceptLanguageHeader == null || acceptLanguageHeader.isEmpty) {
      return 'en';
    }

    // Parse Accept-Language header (e.g., "en-US,en;q=0.9,ar;q=0.8")
    final languages = acceptLanguageHeader.split(',');
    if (languages.isEmpty) return 'en';

    // Get the first language code
    final firstLang = languages.first.split(';').first.trim();

    // Extract just the language code (e.g., "en" from "en-US")
    final langCode = firstLang.split('-').first.toLowerCase();

    // Return supported locale or fallback to English
    return ['en', 'ar'].contains(langCode) ? langCode : 'en';
  }
}
