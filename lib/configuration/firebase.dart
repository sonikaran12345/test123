import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:logomaker/configuration/firebase_options.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';


Future<void> firebaseConfigure() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 5),
      ),
    );

    await remoteConfig.fetchAndActivate();
    final Map<String, dynamic> mapValues = jsonDecode(remoteConfig.getValue("ai").asString());

     print(mapValues);
     print("karan");
    AdsVariable.isPurchase = mapValues["isPurchase"] == "true";
    AdsVariable.fullscreen_on_in_splash_screen = mapValues["fullscreen_on_in_splash_screen"] ?? "0";
    AdsVariable.freeUse = mapValues["freeUse"] ?? "4";

    AdsVariable.in_app_continueAdsOnline = mapValues["in_app_continueAdsOnline"] ?? "1";
    AdsVariable.home_continueAdsOnline = mapValues["home_continueAdsOnline"] ?? "1";
    AdsVariable.how_to_play_continueAdsOnline = mapValues["how_to_play_continueAdsOnline"] ?? "1";
    AdsVariable.roulette_continueAdsOnline = mapValues["roulette_continueAdsOnline"] ?? "1";

    AdsVariable.fullscreen_preload_high_adsId = mapValues["fullscreen_preload_high_adsId"] ?? "11";
    AdsVariable.fullscreen_preload_normal_adsId = mapValues["fullscreen_preload_normal_adsId"] ?? "11";
    AdsVariable.fullscreen_splash_adsId_high = mapValues["fullscreen_splash_adsId_high"] ?? "11";
    AdsVariable.fullscreen_splash_adsId_normal = mapValues["fullscreen_splash_adsId_normal"] ?? "11";
    AdsVariable.fullscreen_in_app_adsId = mapValues["fullscreen_in_app_adsId"] ?? "11";
    AdsVariable.fullscreen_home_adsId = mapValues["fullscreen_home_adsId"] ?? "11";
    AdsVariable.fullscreen_how_to_play_adsId = mapValues["fullscreen_how_to_play_adsId"] ?? "11";
    AdsVariable.fullscreen_roulette_adsId = mapValues["fullscreen_roulette_adsId"] ?? "11";

    AdsVariable.banner_chooser_screen = mapValues["banner_chooser_screen"] ?? "11";
    AdsVariable.banner_coin_fliiper_screen = mapValues["banner_coin_fliiper_screen"] ?? "11";
    AdsVariable.banner_homograft_screen = mapValues["banner_homograft_screen"] ?? "11";
    AdsVariable.banner_how_to_play_screen = mapValues["banner_how_to_play_screen"] ?? "11";
    AdsVariable.banner_ranking_screen = mapValues["banner_ranking_screen"] ?? "11";
    AdsVariable.banner_roulette_screen = mapValues["banner_roulette_screen"] ?? "11";
    AdsVariable.banner_spin_bottle_screen = mapValues["banner_spin_bottle_screen"] ?? "11";
    AdsVariable.banner_dice_screen = mapValues["banner_dice_screen"] ?? "11";

    AdsVariable.native_onboarding_small = mapValues["native_onboarding_small"] ?? "11";
    AdsVariable.native_onboarding_big = mapValues["native_onboarding_big"] ?? "11";

    AdsVariable.appopen = mapValues["appopen"] ?? "11";

    AdsVariable.facebookId = mapValues["facebookId"]?.toString() ?? "11";
    AdsVariable.facebookToken = mapValues["facebookToken"]?.toString() ?? "11";

    AdsVariable.nativeBGColor = mapValues["nativeBGColor"] ?? "121212";
    AdsVariable.btnBgColor_start = mapValues["btnBgColor_start"] ?? "92EBFF";
    AdsVariable.btnBgColor_end = mapValues["btnBgColor_end"] ?? "92EBFF";
    AdsVariable.btnTextColor = mapValues["btnTextColor"] ?? "000000";
    AdsVariable.headerTextColor = mapValues["headerTextColor"] ?? "FFFFFF";
    AdsVariable.bodyTextColor = mapValues["bodyTextColor"] ?? "DDDDDD";

    setupFbAdsId();

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } on FirebaseException catch (e) {
    print('jasoda Firebase Exception: $e');
    return;
  } on Exception catch (e) {
    print('jasoda Exception during Firebase Config: $e');
    return;
  }
}

void setupFbAdsId() {
  const platformMethodChannel = MethodChannel('nativeChannel');
  platformMethodChannel.invokeMethod('setToast', {
    'isPurchase': AdsVariable.isPurchase.toString(),
    'facebookId': AdsVariable.facebookId,
    'facebookToken': AdsVariable.facebookToken,
    'nativeBGColor': AdsVariable.nativeBGColor,
    'btnBgColor_start': AdsVariable.btnBgColor_start,
    'btnBgColor_end': AdsVariable.btnBgColor_end,
    'btnTextColor': AdsVariable.btnTextColor,
    'headerTextColor': AdsVariable.headerTextColor,
    'bodyTextColor': AdsVariable.bodyTextColor,
  });
}
