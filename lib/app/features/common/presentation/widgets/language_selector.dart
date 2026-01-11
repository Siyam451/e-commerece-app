import 'package:ecommerce_project/app/extensions/localization_extension.dart';
import 'package:ecommerce_project/app/provider/language_provider.dart';
import 'package:ecommerce_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(context.localizations.changelanguage),// extension diye korlam
          //dropdown diye language select er ta kora hoi
          DropdownMenu<String>(
            initialSelection: 'en',

            onSelected: (String? language) {
              // provider di korlam j select korle ki korbe
             context.read<LanguageProvider>().changeLocale(Locale(language!));
            },
            dropdownMenuEntries: [
              //bangla select korle bangla dekhabe
           DropdownMenuEntry(value: 'en', label: 'English'),
              DropdownMenuEntry(value: 'bn', label: 'Bangla'),
              DropdownMenuEntry(value: 'de', label: 'Germen')

            ],
          ),
        ]
    );



  }
}
