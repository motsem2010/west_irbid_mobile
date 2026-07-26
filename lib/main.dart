import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:west_irbid_mobile/modules/login/login_view.dart';
import 'package:west_irbid_mobile/services_utils/DB/token_db.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/notification_service.dart';
import 'package:west_irbid_mobile/services_utils/settings_service.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';

enum PlatformIds { android, huawei, ios, web }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() => SettingsService().init());
  // Get.lazyPut<LoginController>(
  //   () => LoginController(),
  // );

  await Supabase.initialize(
    url: 'https://edcswilizjrbxpmyihfq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVkY3N3aWxpempyYnhwbXlpaGZxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc2NTI4MTEsImV4cCI6MjAzMzIyODgxMX0.-wOtD6yP7bW0UcQDLMJscyMDi7HuzfI-ZU8odn_BU8o',
  );
  // await TokenDB.openTokenBox();
  await Main.initializeApp();
  await GetStorage.init();
  // Gemini.init(apiKey: 'AIzaSyC693wVM6XBue1WiMiy2RM1fUSdZM1jlxo');

  runApp(const MyApp());
}

//android=0, huawe=1, ios=2, web=3

class Main {
  static bool withOutBadge = true;
  static bool? withOutUpdate = true;

  static String? testUsername;
  static String? testPassword;
  static bool showNotification = true;
  static bool showChat = true;
  static PlatformIds? devicePlatform;
  static bool withFirebase = true;
  static void currentPlatform() {
    if (Main.devicePlatform == null) {
      if (Platform.isIOS) {
        Main.devicePlatform = PlatformIds.ios;
        return;
      } else if (Platform.isAndroid) {
        Main.devicePlatform = PlatformIds.android;
        return;
      } else
        Main.devicePlatform = PlatformIds.web;
    }
  }

  static Future<void> initializeApp({
    bool withFireBase = true,
    FirebaseOptions? firebaseOptions,
  }) async {
    if (Main.devicePlatform == null) currentPlatform();
    Main.withFirebase = withFireBase;
    if (!kDebugMode) debugPrint = (String? message, {int? wrapWidth}) {};
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (withFireBase && Main.devicePlatform != PlatformIds.huawei)
      await _initializeFirebase(firebaseOptions);

    // if (!withFireBase && devicePlatform == PlatformIds.huawei)
    //   await NotificationServiceHuawei.start();

    await TokenDB.openTokenBox();

    // if (enableBiometricLogic) await BiometricDB.openBiometricBox();
    // if (enableAppType) await AppTypeDB.openAppTypeBox();
    // if (!kDebugMode) {
    //   debugPrint = (String? message, {int? wrapWidth}) {};
    // } else {
    //   UserDB.saveUserUsername(Main.testUsername);
    //   UserDB.saveUserPassword(Main.testPassword);
    // }
    print("----- Firebase / Huawei Token -----");
    // Main.devicePlatform == PlatformIds.huawei
    //     ? print(NotificationServiceHuawei.huaweiToken)
    //     : print(NotificationService.firebaseToken);
    print(NotificationService.firebaseToken);
  }

  static Future<void> _initializeFirebase(
    FirebaseOptions? firebaseOptions,
  ) async {
    try {
      await Firebase.initializeApp(options: firebaseOptions);
      await FirebaseMessaging.instance.requestPermission();
      final _firebaseMessaging = FirebaseMessaging.instance;
      if (Main.devicePlatform == PlatformIds.ios) {
        var apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          await Future.delayed(const Duration(seconds: 3));
          apnsToken = await _firebaseMessaging.getAPNSToken();
        }
      }
      NotificationService.firebaseToken = await _firebaseMessaging.getToken();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    } catch (e) {
      NotificationService.firebaseToken = "noToken";
      print(e);
      print("Error initializing Firebase");
    }
  }

  @pragma("vm:entry-point")
  static Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    // await Hive.initFlutter();
    await TokenDB.openTokenBox();
    TokenDB.saveAccessNotification("false");
    print("print data :" + message.data.toString());
    print(
      "print  :" +
          message.data["navigation"].toString() +
          "  ${message.data["navigation"] == null}",
    );

    if (message.data["navigation"] == null) return;

    // await GeneralController.read(NavigatorKey.instance.currentContext!)
    //     .getMailBoxCount();
    // if (Main.schoolMessageBadge)
    //   await GeneralController.read(NavigatorKey.instance.currentContext!)
    //       .getSchoolMsgCount();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'West Irbid Mobile',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // getPages: AppPages.routes,
      translations: TranslationService(),
      locale: TranslationService().getLocale(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ConstantsData.primaryClr),
        useMaterial3: true,
      ),
      home: const LoginView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
