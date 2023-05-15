import '../../interface/sample_interface.dart';

class Wwww3qDatzRoutesAppPagesSample extends Sample {
  Wwww3qDatzRoutesAppPagesSample() : super('lib/app/routes/app_pages.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'package:get/get.dart';

import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTHENTICATION;

  static final routes = [
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
  ];
}

''';
}

class Wwww3qDatzRoutesAppRoutesSample extends Sample {
  Wwww3qDatzRoutesAppRoutesSample() : super('lib/app/routes/app_routes.dart', overwrite: true);

  @override
  String get content =>
      '''
// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();
  static const AUTHENTICATION = _Paths.AUTHENTICATION;
}

abstract class _Paths {
  _Paths._();
  static const AUTHENTICATION = '/authentication';
}
''';
}
