import '../../interface/sample_interface.dart';

class Wwww3qDatzApiUrlSample extends Sample {
  Wwww3qDatzApiUrlSample() : super('lib/app/core/config/api_url.dart', overwrite: true);

  @override
  String get content => '''
// ignore_for_file: non_constant_identifier_names

class ApiUrl {
  static String get base_url => 'https://127.0.0.1'; //baseUrl

  //
  static String post_auth_login() => '/api/auth/login';
  static String post_auth_register() => '/api/auth/register';
}
''';
}

class Wwww3qDatzThemeConfigSample extends Sample {
  Wwww3qDatzThemeConfigSample() : super('lib/app/core/config/theme_config.dart', overwrite: true);

  @override
  String get content => '''
import 'package:flutter/material.dart';

import '../constants/color_constant.dart';

// https://flutter.github.io/samples/web/material_3_demo/#/
class ThemeConfig with ColorConstants {
  ThemeData get lightTheme => ThemeData.light().copyWith(
        // useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: ColorConstants.pink800,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: ColorConstants.pink500,
        ),

        popupMenuTheme: const PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //side: const BorderSide(color: Colors.pink)
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            //side: const BorderSide(color: Colors.pink)
          ),
          //shadowColor: MaterialStateProperty.all<Color>(Colors.red),
          //elevation: MaterialStateProperty.all<double>(0),
          // backgroundColor: ColorConstants.pink800, //background
        )),
      );

  ThemeData get dartTheme => ThemeData.dark(
      // useMaterial3: true,
      );
}
''';
}
