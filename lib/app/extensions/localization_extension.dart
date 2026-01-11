import 'package:ecommerce_project/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
//nijer ekta exention banano jate AppLocalizations.of(context) bar bar lekhte na hoi ar amra shudu context dilei kaj hoi jai

extension LocalizationExtension on BuildContext{
  AppLocalizations get localizations{
    return AppLocalizations.of(this)!;
  }
}