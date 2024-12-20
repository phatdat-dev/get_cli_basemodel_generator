import 'package:dart_style/dart_style.dart';

import '../../common/utils/pubspec/pubspec_utils.dart';

/// Format a dart file
String formatterDartFile(String content) {
  var formatter = DartFormatter(languageVersion: PubspecUtils.sdkVersion);
  return formatter.format(content);
}
