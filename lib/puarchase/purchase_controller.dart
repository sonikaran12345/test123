
import 'package:get/get.dart';
import 'package:logomaker/Upsellscreen/constant.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';
import 'package:logomaker/puarchase/puarchase_screen.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseController extends GetxController {

  RxBool isPurchaseActive = false.obs;
  RxInt freeUse = 0.obs;

  get prefs => null;


  @override
  void onInit() {
    getFreeUse();
    super.onInit();
  }

  getFreeUse() async {
    final prefs = await SharedPreferences.getInstance();
    var getFreeUse = prefs.getInt('freeUse') ?? 0;
    freeUse.value = getFreeUse;
  }

  setFreeUse() async {
    final prefs = await SharedPreferences.getInstance();
    freeUse.value++;
    await prefs.setInt('freeUse', freeUse.value);
  }

  bool checkFreeUse(){
    if(isPurchaseActive.value){
      return false;
    }
    if (freeUse.value > int.parse(AdsVariable.freeUse)) {
      Get.to(() => const PuarchaseScreen(item: true));
      return true;
    }else{
      setFreeUse();
      return false;
    }
  }

  Future<bool> checkPurchasesStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      if (customerInfo.entitlements.all[entitlementKey] != null && customerInfo.entitlements.all[entitlementKey]!.isActive == true) {
        AdsVariable.isPurchase = true;
        _updateAdsVariable();
        isPurchaseActive.value = true;
        return true;
      }
      return false;
    } catch (e) {
      print("Error checking purchase status: $e");
      return false;
    }
  }

  void _updateAdsVariable() {

    AdsVariable.fullscreen_preload_high_adsId = '11';
    AdsVariable.fullscreen_preload_normal_adsId = '11';
    AdsVariable.fullscreen_splash_adsId_high = '11';
    AdsVariable.fullscreen_splash_adsId_normal = '11';
    AdsVariable.fullscreen_in_app_adsId = '11';
    AdsVariable.fullscreen_home_adsId = '11';
    AdsVariable.fullscreen_how_to_play_adsId = '11';
    AdsVariable.fullscreen_roulette_adsId = '11';

    AdsVariable.banner_chooser_screen = '11';
    AdsVariable.banner_coin_fliiper_screen = '11';
    AdsVariable.banner_homograft_screen = '11';
    AdsVariable.banner_how_to_play_screen = '11';
    AdsVariable.banner_ranking_screen = '11';
    AdsVariable.banner_roulette_screen = '11';
    AdsVariable.banner_spin_bottle_screen = '11';
    AdsVariable.banner_dice_screen = '11';

    AdsVariable.native_onboarding_small = "11";
    AdsVariable.native_onboarding_big = "11";

    AdsVariable.appopen = '11';
  }
}
