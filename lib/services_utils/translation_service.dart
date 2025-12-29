import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:west_irbid_mobile/services_utils/Lang/ar.dart';
import 'package:west_irbid_mobile/services_utils/Lang/en.dart';

class TranslationService extends Translations {
  GetStorage localStorage = GetStorage();

  static final locale = const Locale('ar', 'SA');

  static final fallbackLocale = const Locale('ar', 'SA');

  static final langs = ['ar_SA', 'en_US'];

  static final locales = [const Locale('ar', 'SA'), const Locale('en', 'US')];

  @override
  Map<String, Map<String, String>> get keys => {'ar_SA': ar, 'en_US': en};

  void changeLocale(String lang) async {
    if (lang == langs[0]) {
      Get.updateLocale(locales[0]);
      await localStorage.write('language', 'ar_SA');
    } else {
      Get.updateLocale(locales[1]);
      await localStorage.write('language', 'en_US');
    }
  }

  Locale getLocale() {
    String? currentLocale = localStorage.read('language');
    if (currentLocale == null || currentLocale == 'ar_SA') return locales[0];

    return locales[1];
  }

  String getLocaleLanguageCode() {
    String? currentLocale = localStorage.read('language');
    if (currentLocale == null || currentLocale == 'ar_SA')
      return locales[0].languageCode;

    return locales[1].languageCode;
  }

  bool isLocaleArabic() {
    return Get.locale == const Locale('ar', 'SA');
  }
}
