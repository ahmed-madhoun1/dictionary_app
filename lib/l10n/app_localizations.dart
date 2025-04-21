import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
  ];

  String get dictionaryTitle {
    return Intl.message(
      'Dictionary',
      name: 'dictionaryTitle',
      locale: locale.toString(),
    );
  }

  String get searchHint {
    return Intl.message(
      'Search for a word',
      name: 'searchHint',
      locale: locale.toString(),
    );
  }

  String get enterWordPrompt {
    return Intl.message(
      'Enter a word to search',
      name: 'enterWordPrompt',
      locale: locale.toString(),
    );
  }

  String get noResultsFound {
    return Intl.message(
      'No results found',
      name: 'noResultsFound',
      locale: locale.toString(),
    );
  }

  String get errorPrefix {
    return Intl.message(
      'Error: ',
      name: 'errorPrefix',
      locale: locale.toString(),
    );
  }

  String get noInternetError {
    return Intl.message(
      'No internet connection. Please check your network.',
      name: 'noInternetError',
      locale: locale.toString(),
    );
  }

  String get serverError {
    return Intl.message(
      'Server error. Please try again later.',
      name: 'serverError',
      locale: locale.toString(),
    );
  }

  String get invalidInputError {
    return Intl.message(
      'Invalid input. Please enter a valid word.',
      name: 'invalidInputError',
      locale: locale.toString(),
    );
  }

  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred.',
      name: 'unexpectedError',
      locale: locale.toString(),
    );
  }

  String get synonymsAndAntonyms {
    return Intl.message(
      'Synonyms & Antonyms',
      name: 'synonymsAndAntonyms',
      locale: locale.toString(),
    );
  }

  String get antonyms {
    return Intl.message(
      'Antonyms:',
      name: 'antonyms',
      locale: locale.toString(),
    );
  }
  String get synonyms {
    return Intl.message(
      'Synonyms:',
      name: 'synonyms',
      locale: locale.toString(),
    );
  }

  String get example {
    return Intl.message(
      'Example:',
      name: 'example',
      locale: locale.toString(),
    );
  }

  String get enterAWordToSearch {
    return Intl.message(
      'Enter a word to search',
      name: 'EnterAWordToSearch',
      locale: locale.toString(),
    );
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}