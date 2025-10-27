import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:salonku/app/models/notification_model.dart';

Future<void> handleNotificationRouting(String? payload) async {
  if (payload == null || payload.isEmpty) return;

  try {
    final data = jsonDecode(payload) as Map<String, dynamic>;
    if (data.containsKey("page")) {
      dynamic args;
      if (data.containsKey("arguments") && data["arguments"] is String) {
        args = jsonDecode(data["arguments"]);
      }
      await Get.toNamed(data["page"], arguments: args);
    }
  } catch (e) {
    // print("error parsing notification payload: $e");
  }
}

void onNotificationTapped(NotificationResponse response) {
  developer.log(
    'Local notification tapped: ${response.payload}',
    name: 'NOTIFICATION_SERVICE',
  );
  if (response.payload == null) return;
  handleNotificationRouting(response.payload);
}

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  // 1. Inisialisasi Firebase
  await Firebase.initializeApp();

  // 2. Cek apakah ada data notifikasi
  if (message.data.isEmpty) return;

  final title = message.data['title']?.toString();
  final body = message.data['body']?.toString();

  if (title == null || body == null || title.isEmpty || body.isEmpty) {
    developer.log(
      'Background message received without title or body.',
      name: 'NOTIFICATION_SERVICE',
    );
    return;
  }

  developer.log(
    'Handling a background message: ${message.messageId}',
    name: 'NOTIFICATION_SERVICE',
  );

  // 3. Inisialisasi FlutterLocalNotificationsPlugin secara lokal
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onNotificationTapped,
  );

  // 4. Siapkan detail notifikasi (copy logic dari service Anda)
  const String defaultChannelId = 'superapps_channel';
  const String defaultChannelName = 'Superapps Notifications';
  const String importantChannelId = 'important_channel';
  const String importantChannelName = 'Important Notifications';

  final priority = message.data['priority']?.toString().toLowerCase() ?? '';
  final isHighPriority = priority == 'high';

  final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        isHighPriority ? importantChannelId : defaultChannelId,
        isHighPriority ? importantChannelName : defaultChannelName,
        importance: isHighPriority
            ? Importance.high
            : Importance.defaultImportance,
        priority: isHighPriority ? Priority.high : Priority.defaultPriority,
        playSound: true,
      );

  final NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
  );

  // 5. Tampilkan notifikasi
  await flutterLocalNotificationsPlugin.show(
    DateTime.now().millisecondsSinceEpoch.remainder(100000),
    title,
    body,
    notificationDetails,
    payload: jsonEncode(message.data),
  );
}

class NotificationService extends GetxService {
  static NotificationService get to => Get.find();

  FlutterLocalNotificationsPlugin? _localNotifications;
  FirebaseMessaging? _fcm;

  // Notification channels
  static const String _defaultChannelId = 'superapps_channel';
  static const String _defaultChannelName = 'Superapps Notifications';

  static const String _importantChannelId = 'important_channel';
  static const String _importantChannelName = 'Important Notifications';

  // Observable properties
  final RxBool notificationPermissionGranted = false.obs;
  final RxString fcmToken = ''.obs;

  Future<NotificationService> init() async {
    await _initializeLocalNotifications();
    await _initializeFirebaseMessaging();
    await _requestPermissions();
    await _setupNotificationHandlers();

    return this;
  }

  Future<void> _initializeLocalNotifications() async {
    _localNotifications = FlutterLocalNotificationsPlugin();

    // Android initialization
    const androidInitializationSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    // iOS initialization
    const iosInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotifications?.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTapped,
    );

    final launchDetails = await _localNotifications
        ?.getNotificationAppLaunchDetails();
    final String? initialPayload = launchDetails?.notificationResponse?.payload;
    if (initialPayload != null) {
      await handleNotificationRouting(initialPayload);
      await _localNotifications?.cancel(
        launchDetails?.notificationResponse?.id ?? 0,
      );
    }
  }

  Future<void> _initializeFirebaseMessaging() async {
    try {
      _fcm = FirebaseMessaging.instance;

      if (Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) {
          developer.log('APNS Token is null', name: 'NOTIFICATION_SERVICE');
          return;
        }
      }
      final token = await _fcm!.getToken();
      if (token != null) {
        fcmToken.value = token;
      }
    } catch (e) {
      developer.log(
        'Error initializing Firebase Messaging: $e',
        name: 'NOTIFICATION_SERVICE',
      );
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      final androidPlugin = _localNotifications!
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      final granted = await androidPlugin?.requestNotificationsPermission();
      notificationPermissionGranted.value = granted ?? false;
    } else if (Platform.isIOS) {
      final granted = await _fcm?.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      notificationPermissionGranted.value =
          granted?.authorizationStatus == AuthorizationStatus.authorized;
    }
  }

  Future<void> _setupNotificationHandlers() async {
    if (_fcm == null) return;

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Handle notification tap when app is terminated
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Check if app was launched from notification
    final initialMessage = await _fcm!.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }
  }

  void _handleForegroundMessage(RemoteMessage message) {
    developer.log(
      'Foreground message: ${message.data}',
      name: 'NOTIFICATION_SERVICE',
    );

    if (message.data.containsKey('title') && message.data.containsKey('body')) {
      // Add to notifications list
      // _addNotificationToList(message);

      // Show local notification
      _showLocalNotification(message);
    }
  }

  void _handleNotificationTap(RemoteMessage message) {
    developer.log(
      'Notification tapped: ${message.messageId}',
      name: 'NOTIFICATION_SERVICE',
    );
  }

  // Show local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.normal,
  }) async {
    final channelId = priority == NotificationPriority.high
        ? _importantChannelId
        : _defaultChannelId;

    final androidDetails = AndroidNotificationDetails(
      channelId,
      priority == NotificationPriority.high
          ? _importantChannelName
          : _defaultChannelName,
      importance: priority == NotificationPriority.high
          ? Importance.high
          : Importance.defaultImportance,
      priority: priority == NotificationPriority.high
          ? Priority.high
          : Priority.defaultPriority,
      enableVibration: priority == NotificationPriority.high,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications?.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    if (!notificationPermissionGranted.value) return;
    final title = message.data["title"].toString();
    final body = message.data["body"].toString();
    if (title.isEmpty || body.isEmpty) return;

    await showLocalNotification(
      title: title,
      body: body,
      payload: jsonEncode(message.data),
      priority: _getNotificationPriority(message),
    );
  }

  NotificationPriority _getNotificationPriority(RemoteMessage message) {
    final priority = message.data['priority'] ?? '';
    return priority.toLowerCase() == 'high'
        ? NotificationPriority.high
        : NotificationPriority.normal;
  }

  Future<void> cancelNotification(int id) async {
    await _localNotifications!.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await _localNotifications!.cancelAll();
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}
