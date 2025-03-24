// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:module_ekyc/generated/locales.g.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';

// import 'base_app/controllers_base/app_controller/app_controller.dart';
// import 'core/core.src.dart';
// import 'shares/shares.src.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // ErrorWidget.builder = (FlutterErrorDetails details) => Text(
//   //       details.exception.toString(),
//   //       style: TextStyle(color: AppColors.statusRed),
//   //     ).paddingAll(AppDimens.padding8);
//   runApp(const Application());
// }
// class Application extends StatefulWidget {
//   const Application({super.key});

//   @override
//   State<Application> createState() => _Application();
// }

// class _Application extends State<Application> {
//   @override
//   void initState() {
//     // initialize();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//     ]);
//     // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//     //     // systemNavigationBarColor: AppColors.color,
//     //     statusBarColor: Colors.deepOrangeAccent,
//     //     statusBarBrightness: Brightness.dark,
//     //     statusBarIconBrightness: Brightness.dark));

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: KeyBoard.hide,
//       child: GetMaterialApp(
//         locale: const Locale('vi', 'VN'),
//         debugShowCheckedModeBanner: false,
//         // translationsKeys: AppTranslation.translations,
//         initialRoute: AppRoutes.initApp,
//         getPages: RouteAppPage.route,
//         builder: (context, child) => ScrollConfiguration(
//           behavior: MyBehavior(),
//           child: MediaQuery(
//               data:
//                   MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//               child: child ?? Container()),
//         ),
//         localizationsDelegates: const [
//           GlobalCupertinoLocalizations.delegate,
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           DefaultCupertinoLocalizations.delegate
//         ],
//         supportedLocales: const [
//           Locale('vi', ''),
//           Locale('en', ''),
//         ],
//         title: LocaleKeys.app_name.tr,
//         theme: getThemeByAppTheme(false).copyWith(),
//       ),
//     );
//   }
// }

// class MyBehavior extends ScrollBehavior {
//   @override
//   Widget buildOverscrollIndicator(
//     BuildContext context,
//     Widget child,
//     ScrollableDetails details,
//   ) {
//     return child;
//   }
// }
