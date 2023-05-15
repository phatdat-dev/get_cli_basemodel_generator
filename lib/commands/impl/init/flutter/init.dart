import 'dart:io';

import 'package:get_cli/samples/impl/wwww3q_datz/wwww3q_datz_assets.dart';

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
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_core_base.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_core_config.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_core_constants.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_core_services.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_core_utils.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_core_utils_extension.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_firebase_options.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_modules.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_package_cupertino_datetime_picker.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_custom.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_main.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_routes.dart';
import '../../../../samples/impl/wwww3q_datz/wwww3q_datz_usermodel.dart';
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
