import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/shared/network/local/cache_helper.dart';

class LocaleCubit extends Cubit<Locale?> {
  LocaleCubit() : super(CacheHelper.locale);

  changeLocale(Locale locale) {
    CacheHelper.changeLocale(locale.languageCode);

    emit(locale);
  }
}
