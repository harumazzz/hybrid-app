import 'package:flutter/material.dart';
import 'package:hybrid_app/i18n/app_localizations.dart';

class LocalizationHelper {
  static String getValue(BuildContext context, String languageCode) {
    final localizations = AppLocalizations.of(context)!;
    final result = {
      'en': localizations.en,
      'vi': localizations.vi,
    };
    return result[languageCode] ?? languageCode;
  }
}
