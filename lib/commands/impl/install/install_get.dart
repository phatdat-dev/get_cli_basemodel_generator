import '../../../common/utils/pubspec/pubspec_utils.dart';

Future<void> installGet([bool runPubGet = false]) async {
  PubspecUtils.removeDependencies('get', logger: false);
  await PubspecUtils.addDependencies('get', runPubGet: runPubGet);
}

Future<void> installPackage(List<String> packageName) async {
  for (var element in packageName) {
  PubspecUtils.removeDependencies(element, logger: false);
  await PubspecUtils.addDependencies(element, runPubGet: false);
    
  }
}
