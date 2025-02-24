import 'package:flutter/material.dart';
import 'package:hybrid_app/i18n/app_localizations.dart';

extension Localization on BuildContext {
  AppLocalizations get localization => AppLocalizations.of(this)!;
}
