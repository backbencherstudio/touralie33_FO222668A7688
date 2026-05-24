import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log(
    'Background message received: title=${message.notification?.title}, '
    'body=${message.notification?.body}, data=${message.data}',
  );
  await NotificationService.showNotification(message);
}

class NotificationService {
  NotificationService._();

  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'touralie33_fcm_channel',
    'Touralie Notifications',
    description: 'Shows app notifications while the app is open.',
    importance: Importance.high,
  );

  static Future<void> initialize() async {
    await _requestPermission();
    await _initializeLocalNotifications();
    _listenTokenRefresh();
    await _saveCurrentFcmToken();
    _listenForegroundMessages();
  }

  static Future<void> syncTokenAfterLogin() async {
    await _requestPermission();
    await _saveCurrentFcmToken();
  }

  static Future<void> clearTokenOnLogout() async {
    try {
      await _messaging.deleteToken();
    } catch (error) {
      log('FCM token delete failed: $error');
    } finally {
      await SharedPreferenceData.removeFcmToken();
    }
  }

  static Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
    log('Notification permission: ${settings.authorizationStatus}');
  }

  static Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const initializationSettings = InitializationSettings(
      android: androidSettings,
      iOS: DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(initializationSettings);
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
  }

  static void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log(
        'Foreground message received: title=${message.notification?.title}, '
        'body=${message.notification?.body}, data=${message.data}',
      );
      await showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log(
        'Notification tapped: title=${message.notification?.title}, '
        'body=${message.notification?.body}, data=${message.data}',
      );
    });
  }

  static void _listenTokenRefresh() {
    _messaging.onTokenRefresh.listen((String token) async {
      await SharedPreferenceData.setFcmToken(token);
      log('FCM token refreshed: $token');
    });
  }

  static Future<void> _saveCurrentFcmToken() async {
    try {
      if (!kIsWeb && Platform.isIOS) {
        final apnsToken = await _messaging.getAPNSToken();
        if (apnsToken == null || apnsToken.isEmpty) {
          log('APNs token not available yet on iOS, scheduling retry');
          unawaited(_retrySaveCurrentFcmToken());
          return;
        }
      }

      final token = await _messaging.getToken();
      if (token != null && token.isNotEmpty) {
        await SharedPreferenceData.setFcmToken(token);
        log('FCM token saved: $token');
      }
    } on FirebaseException catch (error) {
      if (error.code == 'apns-token-not-set') {
        return;
      }
      log('FCM token fetch failed: ${error.code} ${error.message}');
      unawaited(_retrySaveCurrentFcmToken());
    } catch (error) {
      log('FCM token fetch failed: $error');
      unawaited(_retrySaveCurrentFcmToken());
    }
  }

  static Future<void> _retrySaveCurrentFcmToken() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    try {
      if (!kIsWeb && Platform.isIOS) {
        final apnsToken = await _messaging.getAPNSToken();
        if (apnsToken == null || apnsToken.isEmpty) {
          log('APNs token still unavailable on iOS');
          return;
        }
      }
      final token = await _messaging.getToken();
      if (token != null && token.isNotEmpty) {
        await SharedPreferenceData.setFcmToken(token);
        log('FCM token saved after retry: $token');
      }
    } catch (error) {
      log('FCM token retry failed: $error');
    }
  }

  static Future<void> showNotification(RemoteMessage message) async {
    await _initializeLocalNotifications();

    final notification = message.notification;
    final title = notification?.title ?? message.data['title']?.toString();
    final body = notification?.body ?? message.data['body']?.toString();

    if ((title == null || title.isEmpty) && (body == null || body.isEmpty)) {
      return;
    }

    await _localNotifications.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }
}
