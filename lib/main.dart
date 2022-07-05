import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_version/new_version.dart';
import 'package:usta_bor_android/translations/app_translations.dart';
import 'bindings/main_binding.dart';
import 'core/data_sources/local/local_source.dart';
import 'core/utils/app_color.dart';
import 'core/utils/size_config.dart';
import 'data/provider/api_client.dart';
import 'ui/auth/on_boarding/on_boarding_screen.dart';
import 'ui/main/main_page.dart';

import 'ui/main/widgets/new_version_dialog.dart';

Future main() async {
  await GetStorage.init();
  HttpOverrides.global = new MyHttpOverrides();
  //Firebase Sign In Implementing
  WidgetsFlutterBinding.ensureInitialized();



  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: AppColor.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp( UstaBor());
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',// description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class UstaBor extends StatefulWidget {
  const UstaBor({Key? key}) : super(key: key);

  @override
  State<UstaBor> createState() => _UstaBorState();
}

class _UstaBorState extends State<UstaBor> {

  String _platformVersion = 'Unknown';

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>(debugLabel: "MAIN-MUSTAFO");



  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = FkUserAgent.userAgent!;
      print(platformVersion);
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      LocalSource.getInstance.setUserAgent(_platformVersion);
    });
  }



  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      print("+++++++++++");
      print(text);
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  void initState() {
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'UstaBor',
      debugShowCheckedModeBanner: false,
      // navigatorKey: alice.getNavigatorKey(),
        locale: Locale(LocalSource.getInstance.locale),
        localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      onInit: () async {

        final newVersion = NewVersion(
          iOSId: 'com.rideauction.Ustabor',
          androidId: 'su.keysoft.ustabor',
        );


        final status = await newVersion.getVersionStatus();

        if (status != null && status.canUpdate) {
          updateDialog(context,status);
        }



        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
          await FkUserAgent.init();
          initPlatformState();
        });


        var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_launcher');
        var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
        flutterLocalNotificationsPlugin.initialize(initializationSettings);

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                   channelDescription:  channel.description,
                    color: Colors.blue,
                    // TODO add a proper drawable resource to android, for now using
                    //      one that already exists in example app.
                    icon: "@mipmap/ic_launcher",
                  ),
                ));
          }
        });
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          RemoteNotification? notification = message.notification;
          AndroidNotification? android = message.notification?.android;
          if (notification != null && android != null) {
            showDialog(
               context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text(notification.title.toString()),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(notification.body.toString())],
                      ),
                    ),
                  );
                });
          }
        });
var token =
        await FirebaseMessaging.instance.getToken();

FirebaseMessaging.instance.subscribeToTopic("ustabor");
FirebaseMessaging.instance.subscribeToTopic("ustabor-ios");


        print('-----Firebase TOKEN');
        print(token);
        print('----USER TOKEN');
        print(LocalSource.getInstance.accessToken);
      },
      translationsKeys: AppTranslation.translations,
      fallbackLocale: Locale('ru', 'RU'),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.white,
        primaryColor: AppColor.green,
        primarySwatch: Colors.green,
      ),
      initialBinding: MainBinding(),
      home: Builder(
        builder: (BuildContext context) {
          SizeConfig().init(context);
          if(LocalSource.getInstance.onOpenBoarding){
            return OnBoardingScreen();
          }
          else {
            return MainPage();
          }
        },
      ),
    );
  }
}


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}