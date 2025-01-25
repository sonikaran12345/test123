
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';

class AppOpenAdManager {
  static AppOpenAd? appOpenAd;
  static bool _isShowingAd = false;
  static bool isLoaded = false;
  static bool dismissed = false;
  static bool shouldShowAd = true;


   void loadAd() {
    AppOpenAd.load(
      adUnitId: AdsVariable.appopen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          appOpenAd = ad;
          isLoaded = true;
        },
        onAdFailedToLoad: (error) {
        },
      ),
    );
  }

  static bool get isAdAvailable {
    return appOpenAd != null;
  }

   bool get isDismissed {
    return dismissed;
  }

   void showAdIfAvailable() {
    if (!shouldShowAd) {
      return;
    }
    if (appOpenAd == null) {
      playOudio();
      dismissed = true;
      loadAd();
      return;
    }
    if (_isShowingAd) {
      playOudio();
      return;
    }
    appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        playOudio();
        _isShowingAd = false;
        dismissed = true;
        ad.dispose();
        appOpenAd = null;
        loadAd();
      },
      onAdDismissedFullScreenContent: (ad) {
        playOudio();
        _isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
        dismissed = true;
        loadAd();
      },
    );
    appOpenAd!.show();
    appOpenAd = null;
  }

   void playOudio() {
     if (Get.currentRoute == '/home_screen'){

     }
   }
}