import 'dart:io';

import '../../../../common/menu/menu.dart';
import '../../../../common/utils/logger/log_utils.dart';
import '../../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
//init_getxpattern
import '../../../../core/structure.dart';
import '../../../../functions/create/create_list_directory.dart';
import '../../../../functions/create/create_main.dart';
//init_katteko
import '../../../../samples/impl/arctekko/arc_main.dart';
import '../../../../samples/impl/arctekko/config_example.dart';
import '../../../../samples/impl/getx_pattern/get_main.dart';
import '../../../interface/command.dart';
import '../../commads_export.dart';
import '../../install/install_get.dart';

part 'init_getxpattern.dart';
part 'init_katteko.dart';
part 'init_wwww3q_datz.dart';

class InitCommand extends Command {
  @override
  String get commandName => 'init';

  @override
  Future<void> execute() async {
    final menu = Menu([
      'GetX Pattern (by wwww3q-Datz)',
      'GetX Pattern (by Kauê)',
      'CLEAN (by Arktekko)',
    ], title: 'Which architecture do you want to use?');
    final result = menu.choose();

    switch (result.index) {
      case 0:
        await createInitWwww3qDatz();
        break;
      case 1:
        await createInitGetxPattern();
        break;
      case 2:
        await createInitKatekko();
        break;
      default:
    }

    if (!PubspecUtils.isServerProject) {
      await ShellUtils.pubGet();
    }
    return;
  }

  @override
  String? get hint => Translation(LocaleKeys.hint_init).tr;

  @override
  bool validate() {
    super.validate();
    return true;
  }

  @override
  String? get codeSample => LogService.code('get init');

  @override
  int get maxParameters => 0;
}
