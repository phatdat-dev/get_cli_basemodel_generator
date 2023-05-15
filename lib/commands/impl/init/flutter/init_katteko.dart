

part of 'init.dart';

Future<void> createInitKatekko() async {
  var canContinue = await createMain();
  if (!canContinue) return;
  if (!PubspecUtils.isServerProject) {
    await installGet();
  }
  var initialDirs = [
    Directory(Structure.replaceAsExpected(path: 'lib/domain/core/interfaces/')),
    Directory(Structure.replaceAsExpected(
        path: 'lib/infrastructure/navigation/bindings/controllers/')),
    Directory(Structure.replaceAsExpected(
        path: 'lib/infrastructure/navigation/bindings/domains/')),
    Directory(
        Structure.replaceAsExpected(path: 'lib/infrastructure/dal/daos/')),
    Directory(
        Structure.replaceAsExpected(path: 'lib/infrastructure/dal/services/')),
    Directory(Structure.replaceAsExpected(path: 'lib/presentation/')),
    Directory(Structure.replaceAsExpected(path: 'lib/infrastructure/theme/')),
  ];

  ArcMainSample().create();
  ConfigExampleSample().create();

  await Future.wait([
    CreateScreenCommand().execute(),
  ]);

  createListDirectory(initialDirs);

  LogService.success(Translation(LocaleKeys.sucess_clean_Pattern_generated).tr);
}
