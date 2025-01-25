
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';
import 'package:logomaker/google_ads_material/app_open_ad_manager.dart';

class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    if (appState == AppState.foreground) {
      print('========================foreground============================');
      if (Get.currentRoute == '/home_screen'){

      }
      if(AdsVariable.appopen != '11' && !AdsVariable.isPurchase){
        appOpenAdManager.showAdIfAvailable();
      }
    }
    if(appState == AppState.background){
      print('========================background============================');

    }
  }
}