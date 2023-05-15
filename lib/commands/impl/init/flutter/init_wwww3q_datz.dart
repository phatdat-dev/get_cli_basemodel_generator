part of 'init.dart';

// https://github.com/wwwwww3q/flutter_getx_base_project
Future<void> createInitWwww3qDatz() async {
  var canContinue = await createMain();
  if (!canContinue) return;

  var isServerProject = PubspecUtils.isServerProject;
  if (!isServerProject) {
    await installGet(); //package:get
    await installPackage([
      'intl',
      'firebase_core',
      'firebase_auth',
      'flutter_local_notifications',
      'cloud_firestore',
      'firebase_messaging',
      'shared_preferences',
      'flutter_form_builder',
      'form_builder_validators',
      'fluttertoast',
      'flutter_svg',
    ]); //package
  }
  var initialDirs = <Directory>[
    Directory(Structure.replaceAsExpected(path: 'lib/package/')),
    Directory(Structure.replaceAsExpected(path: 'lib/generated/')),
    //
    Directory(Structure.replaceAsExpected(path: 'lib/app/core/base/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/core/config/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/core/constants/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/core/services/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/core/utils/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/core/utils/extension/')),
    //
    Directory(Structure.replaceAsExpected(path: 'lib/app/custom/other/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/custom/widget/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/custom/view/')),
    //
    Directory(Structure.replaceAsExpected(path: 'lib/app/models/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/models/request/')),
    Directory(Structure.replaceAsExpected(path: 'lib/app/models/response/')),
    //
    Directory(Structure.replaceAsExpected(path: 'lib/app/modules/')),
    //
    Directory(Structure.replaceAsExpected(path: 'lib/app/routes/')),
  ];

  //copy all file
  //Tạo các file
  Wwww3qDatzMainSample().create();
  Wwww3qDatz_firebase_options_Sample().create();
  // 'lib/package/
  Wwww3qDatzCupertinoDatetimePickerSample().create();

  // 'lib/app/core/base/
  Wwww3qDatzBaseConnectSample().create();
  Wwww3qDatzBaseControllerSample().create();
  Wwww3qDatzBaseModelSample().create();
  Wwww3qDatzBaseProjectSample().create();

  // 'lib/app/core/config/
  Wwww3qDatzApiUrlSample().create();
  Wwww3qDatzThemeConfigSample().create();

  // 'lib/app/core/constants/
  Wwww3qDatz_app_constant_Sample().create();
  Wwww3qDatz_color_constant_Sample().create();
  Wwww3qDatz_global_constant_Sample().create();
  Wwww3qDatz_storage_constant_Sample().create();

  // 'lib/app/core/services/
  Wwww3qDatz_notification_service_Sample().create();
  Wwww3qDatz_translation_service_Sample().create();

  // 'lib/app/core/utils/
  Wwww3qDatz_utils_Sample().create();
  Wwww3qDatz_print_Sample().create();
  Wwww3qDatz_limit_range_text_input_Sample().create();
  Wwww3qDatz_helper_Sample().create();
  Wwww3qDatz_helper_widget_Sample().create();
  Wwww3qDatz_helper_reflect_Sample().create();

  // 'lib/app/core/utils/extension/
  Wwww3qDatz_text_editing_controller_extension_Sample().create();
  Wwww3qDatz_string_extension_Sample().create();
  Wwww3qDatz_num_extension_Sample().create();
  Wwww3qDatz_map_extension_Sample().create();
  Wwww3qDatz_list_extension_Sample().create();
  Wwww3qDatz_iterable_extension_Sample().create();
  Wwww3qDatz_datetime_extension_Sample().create();
  Wwww3qDatz_app_extension_Sample().create();

  // 'lib/app/custom/other/
  Wwww3qDatz_more_dropdown_search_custom_Sample().create();
  Wwww3qDatz_search_controller_custom_Sample().create();
  // 'lib/app/custom/widget/
  Wwww3qDatz_loadding_widget_Sample().create();

  // 'lib/app/models/
  Wwww3qDatz_users_model_Sample().create();

  // 'lib/app/modules/
  Wwww3qDatz_authentication_binding_Sample().create();
  Wwww3qDatz_authentication_controller_Sample().create();
  Wwww3qDatz_authentication_view_Sample().create();
  Wwww3qDatz_custom_prefix_icon_widget_Sample().create();
  Wwww3qDatz_forgot_password_tab_widget_Sample().create();
  Wwww3qDatz_sign_in_tab_widget_Sample().create();
  Wwww3qDatz_sign_up_tab_widget_Sample().create();
  Wwww3qDatz_social_icon_widget_Sample().create();
  Wwww3qDatz_wave_clipper_Sample().create();
  Wwww3qDatz_wave_draw_clippath_widget_Sample().create();

  // 'lib/app/routes/
  Wwww3qDatzRoutesAppPagesSample().create();
  Wwww3qDatzRoutesAppRoutesSample().create();

  // 'assets
  Wwww3qDatzTranslationsENUSSample().create();
  Wwww3qDatzTranslationsJAJPSSample().create();
  Wwww3qDatzTranslationsVIVNSample().create();
  Wwww3qDatzImportResponseJsonSample().create();

  final generateLocalesCommand = GenerateLocalesCommand()..args = ["assets/translations"];
  await Future.wait([
    generateLocalesCommand.execute(),
    CreatePageCommand().execute(), //get create page:home
  ]);

  createListDirectory(initialDirs);

  LogService.success(Translation(LocaleKeys.sucess_getx_pattern_generated));
}
