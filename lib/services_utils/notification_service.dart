import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/main.dart';
import 'package:west_irbid_mobile/modules/homeDashboard/category_one_view.dart';
import 'package:west_irbid_mobile/modules/news/news_and_events_view.dart';
import 'package:west_irbid_mobile/services_utils/DB/token_db.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

@pragma('vm:entry-point')
class NotificationService {
  static Widget? teacherHomeView;
  static Widget? studentHomeView;
  static Widget? employeeHomeView;
  static Widget? parentHomeView;
  final flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  static String? firebaseToken;
  static RemoteMessage? remoteMessage;
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  Future<void> showNotification(
    int notificationId,
    String? notificationTitle,
    String? notificationContent,
    String payload, {
    String channelId = '0',
    String channelTitle = 'appName',
    String channelDescription = 'notification',
    Priority notificationPriority = Priority.high,
    Importance notificationImportance = Importance.max,
  }) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      playSound: true,
      channelShowBadge: Main.withOutBadge,
      importance: notificationImportance,
      priority: notificationPriority,
      icon: 'app_icon',
    );
    var iOSPlatformChannelSpecifics = new DarwinNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  @pragma('vm:entry-point')
  void start([BuildContext? context]) {
    var initializationSettingsAndroid = new AndroidInitializationSettings(
      'app_icon',
    );
    var initializationSettingsIOS = new DarwinInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if ((TokenDB.getAccessNotification() ?? 'false') == 'false') {
        remoteMessage = message;
        navigateNotification(remoteMessage);
        TokenDB.saveAccessNotification('true');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // if (ConstantsData.currentUser == null) return;

      remoteMessage = message;
      int? notificationID;
      final String? navigationView = remoteMessage?.data['navigation'];
      // if (navigationView == 'news_view') {
      //   Get.to(NewsView());
      // }
      // if (navigationView == 'news_view') {
      //   Get.to(NewsView());
      // }
      // if (navigationView != null &&
      //     navigationView.trim() != "" &&
      //     Routes.routes[navigationView] != null)
      if (navigationView != 'inbox_view' &&
          navigationView != 'school_messages_view')
        if (message.data['ID'] != null)
          notificationID =
              int.tryParse(message.data['ID']) ?? remoteMessage.hashCode;
      showNotification(
        notificationID ?? message.hashCode,
        message.notification?.title ?? '',
        message.notification?.body ?? '',
        "${message.notification?.body}**${message.notification?.body}",
      );
      updateBadge(message);
      TokenDB.saveAccessNotification('false');
    });
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) async {
        print(
          'onDidReceiveNotificationResponse' + remoteMessage!.data.toString(),
        );

        navigateNotification(remoteMessage);
      },
    );
    FirebaseMessaging.instance.requestPermission(
      sound: true,
      badge: Main.withOutBadge,
      alert: true,
      provisional: false,
    );
  }

  Future<void> navigateNotification([RemoteMessage? remoteMessage]) async {
    // if (ConstantsData.currentUser == null) return;
    // if (remoteMessage == null)
    //   remoteMessage =
    //       remoteMessage ?? await FirebaseMessaging.instance.getInitialMessage();

    if (remoteMessage != null) {
      // var generalController = GeneralController.read(
      //   NavigatorKey.instance.currentContext!,
      // );
      String? navigationView = remoteMessage.data['navigation'];
      debugPrint(navigationView);
      String messageID = (remoteMessage.data['id'] ?? "0").toString();
      if (navigationView == 'news_view') {
        //   generalController.initBlockName = navigationView;
        //reload news view
        push(NewsAndEventsView());
      }
      // if (navigationView == 'parents_notes_view' ||
      //     navigationView == 'bus_delay' ||
      //     navigationView == 'birthday_view') {
      //   generalController.initBlockName = navigationView;
      //   if (navigationView == 'birthday_view') {
      //     generalController.isBirthDay = true;
      //   }
      //   if (navigationView == 'parents_notes_view' ||
      //       navigationView == 'bus_delay')
      //     generalController.notificationTitleAndMessage = (
      //       remoteMessage.notification?.title,
      //       remoteMessage.notification?.body,
      //     );
      //   debugPrint(remoteMessage.data.toString());

      // }

      // if (navigationView == 'achievements_and_notes_view') {
      //   var parentController = ParentController.read(
      //     NavigatorKey.instance.currentContext!,
      //   );
      //   parentController.studentDisciplineModelList = [];
      // }

      // if (navigationView == 'school_messages_view') {
      //   //   generalController.initBlockName = navigationView;

      //   return push(SchoolMessagesView(removeAppbar: false));
      // }

      // remoteMessage = null;
      // if (navigationView != null &&
      //     navigationView.trim() != "" &&
      //     Routes.routes[navigationView] != null) {
      //   pushNamed(navigationView);
      //   if (Main.navigateToInboxDetails) generalController.inboxID = messageID;
      // }
    }
  }

  static Future<void> updateBadge(RemoteMessage message) async {
    final String? navigationView = remoteMessage!.data['navigation'];
    // if (navigationView != null &&
    //     navigationView.trim() != "" &&
    //     Routes.routes[navigationView] != null)
    //   if (navigationView == 'school_messages_view') {
    //     if (Main.schoolMessageBadge)
    //       await GeneralController.read(
    //         NavigatorKey.instance.currentContext!,
    //       ).getSchoolMsgCount();
    //   } else if (navigationView == 'inbox_view') {
    //     await GeneralController.read(
    //       NavigatorKey.instance.currentContext!,
    //     ).getMailBoxCount();
    //   }
  }

  void cancelNotification(int Id) {
    flutterLocalNotificationsPlugin.cancel(Id);
  }
}
