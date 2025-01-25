import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logomaker/Screen/Home.dart';
import 'package:logomaker/common_screen/onboarding.dart';
import 'package:logomaker/google_ads_material/InterstitialAdUtil.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';
import 'package:logomaker/google_ads_material/app_open_ad_manager.dart';
import 'package:logomaker/google_ads_material/gdpr_initialized.dart';
import 'package:logomaker/google_ads_material/nativeAdService.dart';
import 'package:logomaker/puarchase/puarchase_screen.dart';
import 'package:logomaker/puarchase/purchase_controller.dart';
import 'package:logomaker/service/checkConnectivity.dart';
import 'package:logomaker/service/sharedPreferencesService.dart';

class InitializationService {
  final AppOpenAdManager appOpenAdManager = AppOpenAdManager();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  InitializationHelper initializationHelper = InitializationHelper();
  final NativeAdManager nativeAdManager = Get.find<NativeAdManager>();
  final PurchaseController purchaseController = Get.put(PurchaseController());

  Future<void> initialize() async {
    try {
      await initializationHelper.initialize();
      _loadNativeAd();
      if (AdsVariable.fullscreen_on_in_splash_screen == '0' &&
          AdsVariable.appopen != '11') {
        _loadAppOpenAd();
      } else {
        if (AdsVariable.appopen != '11') {
          appOpenAdManager.loadAd();
        }
        if (AdsVariable.fullscreen_splash_adsId_high != '11') {
          _loadInterstitialAd(AdsVariable.fullscreen_splash_adsId_high);
        } else {
          nextScreenNavigation();
        }
      }
    } catch (e) {
      print("Initialization error: $e");
    }
  }

  void _loadAppOpenAd() {
    try {
      AppOpenAd.load(
        adUnitId: AdsVariable.appopen,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            try {
              AppOpenAdManager.appOpenAd = ad;
              AppOpenAdManager.appOpenAd!.fullScreenContentCallback =
                  FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  nextScreenNavigation();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  nextScreenNavigation();
                },
              );
              AppOpenAdManager.appOpenAd!.show();
              AppOpenAdManager.appOpenAd = null;
            } catch (e) {
              debugPrint('Error showing AppOpenAd: $e');
              nextScreenNavigation();
            }
          },
          onAdFailedToLoad: (error) {
            debugPrint('AppOpenAd failed to load: $error');
            nextScreenNavigation();
          },
        ),
      );
    } catch (e) {
      debugPrint('Error loading AppOpenAd: $e');
      delayNavigation();
    }
  }

  void _loadInterstitialAd(String adUnitId) {
    try {
      InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            try {
              InterstitialAdManager.interstitialAd = ad;
              InterstitialAdManager.interstitialAd!
                  .fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  try {
                    ad.dispose();
                  } catch (e) {
                    debugPrint('Error disposing InterstitialAd: $e');
                  }
                  nextScreenNavigation();
                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  try {
                    ad.dispose();
                  } catch (e) {
                    debugPrint('Error disposing InterstitialAd: $e');
                  }
                  nextScreenNavigation();
                },
              );
              InterstitialAdManager.interstitialAd!.show();
              InterstitialAdManager.interstitialAd = null;
            } catch (e) {
              debugPrint('Error showing InterstitialAd: $e');
              nextScreenNavigation();
            }
          },
          onAdFailedToLoad: (error) {
            debugPrint('InterstitialAd failed to load: $error');
            try {
              InterstitialAd.load(
                adUnitId: AdsVariable.fullscreen_splash_adsId_normal,
                request: const AdRequest(),
                adLoadCallback: InterstitialAdLoadCallback(
                  onAdLoaded: (ad) {
                    try {
                      InterstitialAdManager.interstitialAd = ad;
                      InterstitialAdManager
                              .interstitialAd!.fullScreenContentCallback =
                          FullScreenContentCallback(
                        onAdDismissedFullScreenContent: (ad) {
                          try {
                            ad.dispose();
                          } catch (e) {
                            debugPrint('Error disposing InterstitialAd: $e');
                          }
                          nextScreenNavigation();
                        },
                        onAdFailedToShowFullScreenContent: (ad, error) {
                          try {
                            ad.dispose();
                          } catch (e) {
                            debugPrint('Error disposing InterstitialAd: $e');
                          }
                          nextScreenNavigation();
                        },
                      );
                      InterstitialAdManager.interstitialAd!.show();
                      InterstitialAdManager.interstitialAd = null;
                    } catch (e) {
                      debugPrint('Error showing fallback InterstitialAd: $e');
                      nextScreenNavigation();
                    }
                  },
                  onAdFailedToLoad: (error) {
                    debugPrint(
                        'Fallback InterstitialAd failed to load: $error');
                    nextScreenNavigation();
                  },
                ),
              );
            } catch (e) {
              debugPrint('Error loading fallback InterstitialAd: $e');
              nextScreenNavigation();
            }
          },
        ),
      );
    } catch (e) {
      debugPrint('Error loading InterstitialAd: $e');
      delayNavigation();
    }
  }

  Future<void> checkConnectivityAndProceed() async {
    final isConnected = await ConnectivityService.checkConnectivity();
    if (isConnected) {
      try {
        purchaseController.checkPurchasesStatus().then((value) {
          if (value) {
            if (purchaseController.isPurchaseActive.value) {
              _navigateToHomeWithoutAds();
            } else {
              _loadNativeAd();
              initialize();
            }
          } else {
            _loadNativeAd();
            initialize();
          }
        });
      } catch (e) {
        delayNavigation();
      }
    } else {
      print('===========================jasoda=====================================');
      delayNavigation();
    }
  }

  void _loadNativeAd() {
    SharedPreferencesService.getUser().then((value) {
      if (value.isEmpty) {
        print("==============nativeads================== ${AdsVariable.native_onboarding_small}");

        nativeAdManager.loadNativeAd(AdsVariable.native_onboarding_small);
      }
    });
  }

  void _navigateToHomeWithoutAds() {
    Timer(const Duration(seconds: 3), () {
      SharedPreferencesService.getUser().then((value) {
        if (value.isNotEmpty) {
          Get.off(() => const Home());
        } else {
          Get.off(() => const OnboardingScreen());
        }
      });
    });
  }

  void delayNavigation() {
    InterstitialAdManager.getInterstitial();
    Timer(const Duration(seconds: 3), () {
      SharedPreferencesService.getUser().then((value) {
        if (value.isNotEmpty) {
          // Get.off(() => const PuarchaseScreen(item: false));
          Get.off(() => const OnboardingScreen());
        } else {
          Get.off(() => const OnboardingScreen());
        }
      });
    });
  }

  void nextScreenNavigation() {
    InterstitialAdManager.getInterstitial();
    SharedPreferencesService.getUser().then((value) {
      if (value.isNotEmpty) {
        // Get.off(() => const PuarchaseScreen(item: false));
        Get.off(() => const OnboardingScreen());
      } else {
        Get.off(() => const OnboardingScreen());
      }
    });
  }
}
