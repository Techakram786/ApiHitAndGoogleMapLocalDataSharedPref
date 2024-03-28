import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pristine Seeds',
      theme: theme(),
      //home: ShowRoutesScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}

Future<void> requestPermission() async {
  var permission_location = Permission.location;

  if (await permission_location.isDenied || await permission_location.isPermanentlyDenied ) {
    await permission_location.request();
  }

  var permission_notification = Permission.notification;

  if (await permission_notification.isDenied || await permission_notification.isPermanentlyDenied) {
    await permission_notification.request();
  }

  var permission_camera = Permission.camera;

  if (await permission_camera.isDenied || await permission_camera.isPermanentlyDenied) {
    await permission_camera.request();
  }

  _isAndroidPermissionNotificationGranted();
  _requestPermissions_forNotification();
}

Future<bool> _isAndroidPermissionNotificationGranted() async {
  if (Platform.isAndroid) {
    final bool granted = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled() ??
        false;

    return granted;
  }
  return false;
}
Future<void> _requestPermissions_forNotification() async {
  if (Platform.isIOS || Platform.isMacOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  } else
  if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    // final bool? grantedNotificationPermission =
    await androidImplementation?.requestNotificationsPermission();
    // setState(() {
    //   _notificationsEnabled = grantedNotificationPermission ?? false;
    // });
  }
}
}