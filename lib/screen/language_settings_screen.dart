import 'package:dicoding_moments/common.dart';
import 'package:dicoding_moments/provider/localization_provider.dart';
import 'package:dicoding_moments/utils/localization_switch_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalizationProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)?.languageTitle ?? "App Language",
        ),
      ),
      body: FutureBuilder<Locale>(
        future: provider.locale,
        builder: (BuildContext context, AsyncSnapshot<Locale> snapshot) {
          Locale? localInit = snapshot.data;
          selectedValue = localInit?.languageCode;
          return ListView(
            children: AppLocalizations.supportedLocales.map((Locale locale) {
              final title = Localization.getTitle(locale.languageCode, context);
              return RadioListTile(
                title: Text(
                  title['title'] ?? "Error",
                ),
                subtitle: title['subtitle']?.isNotEmpty ?? false
                    ? Text(
                        title['subtitle'] ?? "Error",
                      )
                    : null,
                value: locale.languageCode,
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                  provider.setLocale(locale);
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
