import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial());

  void changeLanguage(
      {required String? languageCode, required BuildContext context}) {
    if (languageCode == 'Arabic') {
      EasyLocalization.of(context)!.setLocale(const Locale('ar'));
    } else if (languageCode == 'Russian') {
      EasyLocalization.of(context)!.setLocale(const Locale('ru'));
    } else if (languageCode == 'French') {
      EasyLocalization.of(context)!.setLocale(const Locale('fr'));
    } else if (languageCode == 'English') {
      EasyLocalization.of(context)!.setLocale(const Locale('en'));
    } else if (languageCode == null) {
      EasyLocalization.of(context)!.setLocale(const Locale('en'));
    }
    emit(LanguageChanged());
  }
}
