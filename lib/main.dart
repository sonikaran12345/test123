import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logomaker/common_screen/splash_screen.dart';
import 'package:logomaker/configuration/firebase.dart';
import 'package:logomaker/google_ads_material/nativeAdService.dart';
import 'package:logomaker/puarchase/store_config.dart';
import 'constant.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  Get.put(NativeAdManager());
  await configureStore();
  // DependencyInjection.init();
  await firebaseConfigure();
  MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((v) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    //   statusBarColor: appbackgroundColor,
    //   systemNavigationBarColor: appbackgroundColor,
    //   statusBarIconBrightness: Brightness.light,
    // ),
    // );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return ScreenUtilInit(
      designSize: const Size(1242,2208),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          navigatorKey: navigatorKey,
          darkTheme: ThemeData(
            fontFamily: appFontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: appColor),
            primaryColor: appColor,
          ),
          builder: (context, child) {
            final List<String> diceGifs = [
              // 'assets/dice/1.gif',
              // 'assets/dice/2.gif',
              // 'assets/dice/3.gif',
              // 'assets/dice/4.gif',
              // 'assets/dice/5.gif',
              // 'assets/dice/6.gif',
            ];
            for (var gifPath in diceGifs) {
              precacheImage(AssetImage(gifPath), context);
            }
            return child ?? const SizedBox.shrink();
          },
          home: const SplashScreen(),
        );
      },
    );
  }
}




