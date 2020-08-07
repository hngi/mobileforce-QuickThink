import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:rxdart/rxdart.dart';


class NotificationsManager{

  final BehaviorSubject<String> selectNotificationSubject =
  BehaviorSubject<String>();

  NotificationAppLaunchDetails notificationAppLaunchDetails;

  var initializationSettings;

  NotificationsManager._internal();
  static final NotificationsManager _shared =  NotificationsManager._internal();
  static final List<String> notificationMessages = [
    'Greatness is achievable. Play Now!',
    'You can do the impossible. Play Now!',
    'Your time is now! Play Now!',
    'Break new grounds. Play Now!',
    'Today is a new day! Beat your records',
    'Everything is possible. Play Now!',
    'Challenge yourself. Play Now'
  ];

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  factory NotificationsManager() {
    return _shared;
  }
  Future<void> initializeNotifications() async {
    notificationAppLaunchDetails =
        await _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false
        );
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
  }

  FlutterLocalNotificationsPlugin getCurrentNotificationPlugin() {
    return _flutterLocalNotificationsPlugin;
  }

  Future<void> cancelNotificationWith(int i) async {
    await _flutterLocalNotificationsPlugin.cancel(i);
  }

  void scheduleDailyNotifications(int parse) {
    _showDailyAtTime(parse);
  }

  void requestPermission() {
    NotificationPermissions.requestNotificationPermissions();
  }

  Future<void> _showDailyAtTime(int hour) async {
    var time = Time(hour, 0, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '999',
        'Daily Reminder',
        'Schedule daily reminders!');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await _flutterLocalNotificationsPlugin.showDailyAtTime(
        999,
        'QuickThink',
        _getNotificationMessage(),
        time,
        platformChannelSpecifics);
  }

  String _getNotificationMessage() {
    return notificationMessages[Random().nextInt(notificationMessages.length)];
  }

  setOnNotificationClick() async {
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          selectNotificationSubject.add(payload);
        });
  }


}
