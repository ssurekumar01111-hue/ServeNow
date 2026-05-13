import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:admin_web/app/routes/app_pages.dart';
import 'package:admin_web/app/utils/app_colors.dart';
import 'package:admin_web/app/utils/app_theme.dart';
import 'package:admin_web/app/utils/dark_theme_provider.dart';
import 'package:admin_web/firebase_options.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set URL strategy for clean web URLs
  usePathUrlStrategy();
  
  // Global error handler
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
  }
  
  // Configure EasyLoading
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = AppColors.primary
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return GetMaterialApp(
            title: 'ServeNow Admin',
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
            builder: EasyLoading.init(),
            scrollBehavior: const MyCustomScrollBehavior(),
          );
        },
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  const MyCustomScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
