import 'package:clinic_app/Patients/Screens/medicine_remainder_screen/medicine_remainder_home/medicine_remainder_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/subjects.dart';


class NotificationService {
    late BuildContext _context;


  String? selectedNotificationPayload;
  
  final BehaviorSubject<String?> selectNotificationSubject = BehaviorSubject<String?>();

  static final NotificationService _notificationService = NotificationService._internal();
  
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

    //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();

  
  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    //initialize timezone package here 
    tz.initializeTimeZones();  //  <----

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? Payload) async {
        showDialog(
          context: _context,
          builder: (_) {
            return new AlertDialog(
              title: Text("Successfully Notified"),
              content: Text("Payload : $Payload"),
            );
          },
        );
     }
    );
  }


  Future selectNotification(String payload, _context) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(
      _context,
      MaterialPageRoute<void>(builder: (context) => MedicineRemainderHomeScreen()),
    );
}

void requestIOSPermissions(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
  }
  
  static const NotificationDetails platformChannelSpecifics = 
  NotificationDetails(
    android: AndroidNotificationDetails(
        'medicines_id',
        'medicines',
        channelDescription: 'channel description',
        playSound: true,
        priority: Priority.high,
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('notification_tone'),
      )
,
    iOS: IOSNotificationDetails()
  );

  Future<void> showNotifications(String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

    Future<void> scheduleNotifications(String title, String body, int time, int notifyId) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        notifyId,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: time)),
        //tz.TZDateTime.now(tz.local).add(const Duration(minutes: 5)),

        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
        
        //print("**********showNotification***********"+notifyId.toString());

  }


     Future<void> cancelNotifications(int NOTIFICATION_ID) async {
      await flutterLocalNotificationsPlugin.cancel(NOTIFICATION_ID);
    }
 

}
