import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'base_app/controllers_base/app_controller/app_controller.dart';
import 'core/core.src.dart';
import 'shares/shares.src.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize();
  runApp(const Application());
  // runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('2id.ekyc');
  String? argument;

  @override
  void initState() {
    super.initState();
    initialize();
    // platform.setMethodCallHandler((call) async {
    //   if (call.method == "getArguments") {
    //     setState(() {
    //       argument = call.arguments['key'];
    //       print("Received from iOS: $argument");
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(argument ?? "No argument received"),
        ),
      ),
    );
  }

  void initialize() {
    platform.setMethodCallHandler((MethodCall call) async {
      // if (call.method == "setInitialNFC") {
      //   setState(() {
      //     argument = call.arguments['key'];
      //     print("Received from iOS: $argument");
      //   });
      // }
      if (call.method == 'setInitialNFC') {
        final String? data = call.arguments['key'];

        setState(() {
          argument = data;
          print("Received from iOS: $argument");
        });
        // Xử lý dữ liệu từ iOS

        isOnlyNFC = true;
        // Trả kết quả về nếu cần
        // return 'Flutter đã nhận dữ liệu';
      }
      return null;
    });
  }
}

void initialize() {
  platform.setMethodCallHandler((MethodCall call) async {
    if (call.method == 'setInitialNFC') {
      // final String? data = call.arguments as String?;
      // Xử lý dữ liệu từ iOS
      print("Received from iOS: true");
      isOnlyNFC = true;

      try {
        Get.offAllNamed(AppRoutes.routeLogin);
      } catch (e) {
        print("Error navigating: $e");
      }
    }
    return null;
  });
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _Application();
}

class _Application extends State<Application> {
  @override
  void initState() {
    // initialize();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     // systemNavigationBarColor: AppColors.color,
    //     statusBarColor: Colors.deepOrangeAccent,
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.dark));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: KeyBoard.hide,
      child: GetMaterialApp(
        locale: const Locale('vi', 'VN'),
        debugShowCheckedModeBanner: false,
        translationsKeys: AppTranslation.translations,
        initialRoute: AppRoutes.initApp,
        getPages: RouteAppPage.route,
        builder: (context, child) => ScrollConfiguration(
          behavior: MyBehavior(),
          child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child ?? Container()),
        ),
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('vi', ''),
          Locale('en', ''),
        ],
        title: LocaleKeys.app_name.tr,
        theme: getThemeByAppTheme(false).copyWith(),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
