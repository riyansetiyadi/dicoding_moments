import 'package:dicoding_moments/common.dart';
import 'package:flutter/material.dart';

class Localization {
  static Map<String, String> getTitle(String code, BuildContext context) {
    switch (code) {
      case 'en':
        return {
          "title":
              AppLocalizations.of(context)?.englishLanguageTitle ?? "English",
          "subtitle":
              AppLocalizations.of(context)?.englishLanguageSubTitle ?? "",
        };
      case 'id':
        return {
          "title":
              AppLocalizations.of(context)?.indonesianLanguageTitle ?? "Bahasa",
          "subtitle":
              AppLocalizations.of(context)?.indonesianLanguageSubTitle ?? "",
        };
      default:
        return {
          "title":
              AppLocalizations.of(context)?.englishLanguageTitle ?? "English",
          "subtitle":
              AppLocalizations.of(context)?.englishLanguageSubTitle ?? "",
        };
    }
  }
}
