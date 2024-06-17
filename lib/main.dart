import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'Adhelper/ad_config.dart';
import 'Adhelper/ad_helper.dart';
import 'routes/app_pages.dart';

Future<void> firebaseMessengingHandle(RemoteMessage message) async {
  await FirebaseMessaging.instance.subscribeToTopic("all");
  await Firebase.initializeApp();
  // print("------------------${message.data}");
  NotificationService.showNotification(message);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyA6Vvp9xLqCe8EUNWUkBISFaj4WvrArStA",
          appId: "1:57502866661:android:2472344ce17ee3ef9bc80c",
          messagingSenderId: "57502866661",
          storageBucket: "videocall-53a52.appspot.com",
          projectId: "videocall-53a52"));

  AdHelper.initAds();
  Config.initConfig();

  FirebaseMessaging.onBackgroundMessage(firebaseMessengingHandle);   
  await FirebaseMessaging.instance.subscribeToTopic("all");

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    // print("------------------${message.data}");
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await NotificationService.initialize();
    NotificationService.showNotification(message);
  });

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  if (!Config.hideAds) {
    AdHelper.loadAppOpenAd();
  }


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ecom',
        scrollBehavior: MyBehavior(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            // backgroundColor: AppColors.whiteColors,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: 16,
              // color: AppColors.darkBlueColors,
              fontWeight: FontWeight.w600,
            ),
          ),
          fontFamily: 'google_sans',
        ),
        // home: const IntroductionScreen(),
        // initialRoute: // userlogin && user != null ? AppPages.adHomeScreen   : AppPages.adminLogin,
        //     userlogin && user != null
        //         ? AppPages.homeScreen
        //         : intro
        //             ? AppPages.login
        //             : AppPages.indroduction,
        // initialRoute: usetLogin ? AppPages.homeScreen : AppPages.login,
        initialRoute: AppPages.mainHome,
        getPages: AppPages.routes,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: doSomething(),
    );
  }

  static Future showNotification(RemoteMessage message) async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
      "default_notification_channel_id",
      "channel",
      enableLights: true,
      enableVibration: true,
      priority: Priority.high,
      importance: Importance.max,
      icon: "@mipmap/ic_launcher",
      playSound: false,
    );

    await _flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.notification!.title,
        message.notification!.body,
        NotificationDetails(android: androidDetails));
  }
}
