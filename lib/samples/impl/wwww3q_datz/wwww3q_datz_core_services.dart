// ignore_for_file: camel_case_types

import '../../interface/sample_interface.dart';

class Wwww3qDatz_notification_service_Sample extends Sample {
  Wwww3qDatz_notification_service_Sample() : super('lib/app/core/services/notification_service.dart', overwrite: true);

  @override
  String get content => '''
import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../firebase_options.dart';
import '../utils/utils.dart';

/// flutter_local_notifications: ^14.0.0+1
class NotificationService extends GetxService {
  final localNotification = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel get androidNotifiChannel => const AndroidNotificationChannel(
        'notify_app',
        'my_default_notification_channel_id',
        description: 'Cái này là channel mặc định cho app',
        enableLights: true,
        importance: Importance.max,
        enableVibration: true,
        playSound: true,
        //sound: RawResourceAndroidNotificationSound('social_app_notification_sound'),
        // sound: UriAndroidNotificationSound('assets/sound/gmc_notification_sound.mp3')
      );

  Future<void> notificationServiceInitialize() async {
    await _initLocalNotification();

    await _requestPermissionApp();

    // getDeviceFirebaseToken();

    firebaseMessagingForegroundHandler();
  }

  Future<void> _initLocalNotification() async {
    // ở android, tạo channel cho notification
    await localNotification
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotifiChannel);
    //

    //setting notification
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      // iOS: DarwinInitializationSettings(),
    );

    //add setting
    localNotification.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) async {
        //bắt sự kiện click vào notification đẩy nó vào stream
        Printt.white('onDidReceiveNotificationResponse \${details.payload}');
      },
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
    );
  }

  // gửi yêu cầu đến người dùng cấp quyền cho app
  Future<void> _requestPermissionApp() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
  }

  Future<String?> getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    Printt.cyan('TOKEN DEVICE: \$token');
    return token;
  }

  Future<void> showNotification(RemoteMessage message) async {
    ByteArrayAndroidBitmap? imageBitMap;
    if (message.data['image'] != null) {
      Uint8List bodyBytes = (await NetworkAssetBundle(Uri.parse(message.data['image'])).load(message.data['image'])).buffer.asUint8List();

      imageBitMap = ByteArrayAndroidBitmap.fromBase64String(base64Encode(bodyBytes));
    }

    return localNotification.show(
      message.messageId.hashCode,
      message.notification?.title,
      message.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotifiChannel.id,
          androidNotifiChannel.name,
          channelDescription: androidNotifiChannel.description,
          enableLights: androidNotifiChannel.enableLights,
          importance: androidNotifiChannel.importance,
          enableVibration: androidNotifiChannel.enableVibration,
          playSound: androidNotifiChannel.playSound,
          priority: Priority.max,
          sound: androidNotifiChannel.sound,
          icon: '@mipmap/ic_launcher',
          // largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          largeIcon: imageBitMap,
          styleInformation: imageBitMap != null ? BigPictureStyleInformation(imageBitMap) : null,
        ),
        // iOS: const DarwinNotificationDetails(),
      ),
      payload: message.data['payload'],
    );
  }

  void firebaseMessagingForegroundHandler() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        Printt.white('show notification from \${message.from}}');
        showNotification(message);
      }
    });
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    Printt.white('Handling a background messagee: \${message.messageId}');
  }

  static void onDidReceiveBackgroundNotificationResponse(NotificationResponse details) {
    Printt.white('onDidReceiveBackgroundNotificationResponse \${details.payload}');
  }
}
''';
}

class Wwww3qDatz_translation_service_Sample extends Sample {
  Wwww3qDatz_translation_service_Sample() : super('lib/app/core/services/translation_service.dart', overwrite: true);

  @override
  String get content => '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../constants/app_constant.dart';

// get generate locales assets/translations
//nguồn: https://viblo.asia/p/getx-flutter-multiple-language-support-with-getx-part-3-GrLZDDqBZk0
class TranslationService extends Translations {
  // locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static Locale? locale = Get.deviceLocale;
  // fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('en', 'US');
  // các Locale được support
  static const locales = [
    Locale('en', 'US'),
    Locale('vi', 'VN'),
    Locale('ja', 'JP'),
  ];

  // function change language
  static void changeLocale(Locale localeee) {
    Get.updateLocale(localeee);
    locale = localeee;
    Global.sharedPreferences.setString(StorageConstants.langCode, localeee.languageCode);
  }

  static Locale getLocaleFromLanguage() {
    final langCode = Global.sharedPreferences.getString(StorageConstants.langCode);

    if (langCode == null) return Get.deviceLocale!;

    for (int i = 0; i < locales.length; i++) {
      if (langCode == locales[i].languageCode) return locales[i];
    }

    return Get.deviceLocale!;
  }

  @override
  Map<String, Map<String, String>> get keys => AppTranslation.translations;
}
''';
}
