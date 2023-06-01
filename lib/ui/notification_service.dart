import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async{
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('logo');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // **********************************************This is for the breakfast notification*****************************************

  void showNotificationBreakfast(int id,String title,String body) async{
    var time = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,7,0,0);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(time, tz.local),
        NotificationDetails(
          android: AndroidNotificationDetails(
            id.toString(),
            'Have Breakfast',
            importance: Importance.max,
            priority: Priority.max,
            icon: 'logo',
          ),
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,

    );
  }

  // **********************************************This is for the Lunch notification*****************************************
  void showNotificationLunch(int id,String title,String body) async{
    var time = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,13,0,0);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          'Have Lunch',
          importance: Importance.max,
          priority: Priority.max,
          icon: 'logo',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // **********************************************This is for the Dinner notification*****************************************
  void showNotificationDinner(int id,String title,String body) async{
    var time = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,21,30,0);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          'Have Dinner',
          importance: Importance.max,
          priority: Priority.max,
          icon: 'logo',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  //***************************************************This is for People talked to***************************************************

  void showNotificationPeople(int id,String title,String body) async{
    var time = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day,23,0,0);
    tz.initializeTimeZones();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          'People Talked To',
          importance: Importance.max,
          priority: Priority.max,
          icon: 'logo',
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  //****************************************************This is for drinking water****************************************************

  void showNotificationWater(int id,String title,String body) async{
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      // RepeatInterval.everyMinute,
      NotificationDetails(
        android: AndroidNotificationDetails(
          id.toString(),
          'Drink Water',
          importance: Importance.max,
          priority: Priority.max,
          icon: 'logo',
        ),
      ),
    );
  }

  void stopReminder() async{
    flutterLocalNotificationsPlugin.cancel(4);
  }

}