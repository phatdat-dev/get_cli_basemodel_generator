import 'package:get_cli/common/utils/logger/log_utils.dart';
import 'package:get_cli/exception_handler/exception_handler.dart';
import 'package:get_cli/functions/version/version_update.dart';
import 'package:get_cli/get_cli.dart';

//dart pub global activate --source path .
//get.bat from     %USERPROFILE%\AppData\Local\Pub\Cache\bin
Future<void> main(List<String> arguments) async {
  var time = Stopwatch();
  time.start();
  // test command
  // arguments = ["generate", "model", "on", "models/response", "with", "assets/import_response.json", "--copyWith"];
  // run
  final command = GetCli(arguments).findCommand();

  if (arguments.contains('--debug')) {
    if (command.validate()) {
      await command.execute().then((value) => checkForUpdate());
    }
  } else {
    try {
      if (command.validate()) {
        await command.execute().then((value) => checkForUpdate());
      }
    } on Exception catch (e) {
      ExceptionHandler().handle(e);
    }
  }
  time.stop();
  LogService.info('Time: ${time.elapsed.inMilliseconds} Milliseconds');
}

/* void main(List<String> arguments) {
 Core core = Core();
  core
      .generate(arguments: List.from(arguments))
      .then((value) => checkForUpdate()); 
} */
