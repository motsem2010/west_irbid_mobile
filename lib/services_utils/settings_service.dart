import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';

class SettingsService extends GetxService {
  Future<SettingsService> init() async {
    return this;
  }

  ThemeData getLightTheme() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      primaryColor: ConstantsData.primaryClr,
      hoverColor: Colors.grey.shade100,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 3,
        foregroundColor: Colors.white,
        highlightElevation: 6,
        disabledElevation: 2,
      ),
      brightness: Brightness.light,
      dividerColor: Colors.grey,
      focusColor: const Color.fromARGB(255, 77, 3, 90),
      hintColor: Colors.grey,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: const TextStyle(fontWeight: FontWeight.w300),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: ConstantsData.primaryClr,
        secondary: Color.fromARGB(255, 77, 3, 90),
      ),
      textTheme: GoogleFonts.getTextTheme(
        getLocale().toString().startsWith('ar') ? 'Cairo' : 'Poppins',
        // Typography.blackCupertino.copyWith(

        // )
        const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.2,
          ),
          // headline5: TextStyle(
          //     fontSize: 16.0,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.black,
          //     height: 1.2),
          headlineMedium: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.2,
          ),
          // headline3: TextStyle(
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.black,
          //     height: 1.2),
          // headline2: TextStyle(
          //     fontSize: 24.0,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.black,
          //     height: 1.2),
          headlineLarge: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            height: 1.2,
          ),
          titleMedium: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.2,
          ),
          titleSmall: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
            height: 1.2,
          ),
          bodyMedium: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            color: Colors.black,
            height: 1.4,
          ),
          bodyLarge: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
            color: Colors.black,
            height: 1.4,
          ),
          // caption: TextStyle(
          //     fontSize: 12.0,
          //     fontWeight: FontWeight.w100,
          //     color: Colors.black,
          //     height: 1.2),
        ),
      ),
    );
  }

  Locale getLocale() {
    String? localeLang = GetStorage().read<String>('lang');
    String? localeCountry = GetStorage().read<String>('country');
    Locale locale = localeLang == null || localeCountry == null
        ? const Locale('ar', 'SA')
        : const Locale('en', 'US');

    return locale;
  }
}
