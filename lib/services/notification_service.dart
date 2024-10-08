import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
@pragma('vm:entry-point')

class LocalNotificationService {
  LocalNotificationService();

  final localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_stat_add_alert');

    const DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true);

    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    await localNotificationService.initialize(
      settings,
    );
  }

  Future<NotificationDetails> notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'Description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const DarwinNotificationDetails ioSNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails, iOS: ioSNotificationDetails);
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    final details = await notificationDetails();
    await localNotificationService.show(id, title, body, details);
  }
}

void sendPushMessage(String token, String body, String title) async {
  try {
    var response = await http.post(
      Uri.parse("https://fcm.googleapis.com/v1/projects/ept-app-46930/messages:send"),
      headers: <String, String>{
        "Content-Type": "application/json",
        "Authorization":
            "Bearer BIrm64J7k7t9VyzgttSHADxHDk5iYMBpOjXlZAb_CDJt-FGmM4lyRClKExtZ78MVDhS7RPYWDDwiNVS6Jdcb9oY",  // Clé API de Firebase Cloud Messaging v1 (besoin de token OAuth 2.0 pour long terme)
      },
      body: jsonEncode(<String, dynamic>{
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body
          },
          "android": {
            "notification": {
              "channel_id": "dbfood"
            }
          }
        }
      }),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
  } catch (e) {
    print("Error sending push message: $e");
  }
}

// void sendPushMessage(String token, String body, String title) async {
//   try {
//     var response = await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
//         headers: <String, String>{
//           "Content-Type": "application/json",
//           "Authorization":
//               "key=AAAAVIafLa0:APA91bEHCxiZ0-FI8AfGSxwYiPZDOd30TNgRlLXA9hhqmf8dglueUuAuTigHbAUkGl7hZXWEWMCUmreF59ITkQsDRpMonsgAcCAVE43ipc1onphXPCSU25j2tBKRl9zT2U0bqLMBS1Ye"
//         },
//         body: jsonEncode(<String, dynamic>{
//           'priority': 'high',
//           'data': <String, dynamic>{
//             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
//             'status': 'done',
//             'body': body,
//             'title': title
//           },
//           "notification": <String, dynamic>{
//             "title": title,
//             "body": body,
//             "android_channel_id": "dbfood"
//           },
//           "to": token
//         }));

//     print("Response status: ${response.statusCode}");
//     print("Response body: ${response.body}");
//   } catch (e) {
//     print("Error sending push message: $e");
//   }
// }


String? mtoken;
void _requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted permission");
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print("User granted provisional permission");
  } else {
    print("User declined or has not accepted permission");
  }
}
// ignore_for_file: avoid_print

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  ///await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}
bool userauth = false;



Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('Notification permission granted: ${settings.authorizationStatus}');
}

