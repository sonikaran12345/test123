import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logomaker/Screen/Home.dart';
import 'package:logomaker/Upsellscreen/constant.dart';
import 'package:logomaker/common_screen/privacy_policy.dart';
import 'package:logomaker/common_screen/ternsOfUse.dart';
import 'package:logomaker/constant.dart';
import 'package:logomaker/google_ads_material/InterstitialAdUtil.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';
import 'package:logomaker/puarchase/purchase_controller.dart';
import 'package:logomaker/puarchase/subtitle_text.dart';
import 'package:logomaker/service/dialog.dart';
import 'package:logomaker/service/image_press_unpress.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shimmer/shimmer.dart';

class PuarchaseScreen extends StatefulWidget {
  final bool item;

  const PuarchaseScreen({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => _PuarchaseScreenState();
}

class _PuarchaseScreenState extends State<PuarchaseScreen> {
  PurchaseController purchaseController = Get.put(PurchaseController());
  Offerings? _offerings;
  bool isClose = false;
  Map<String, Package>? availablePackages;
  Map<String, Package>? packageEntry;
  Package? selectedPackage;
  String planeName = 'ds.ahmdemotestapp.com.oneweek';

  @override
  void initState() {
    super.initState();
    fetchData();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isClose = true;
      });
    });
  }

  int currentIndex = 0;

  final List<String> imagePaths = [
    'assets/premium/logo_1.png',
    'assets/premium/logo_2.png',
    'assets/premium/logo_3.png',
    'assets/premium/logo_4.png',
    'assets/premium/logo_5.png',
  ];

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    Offerings? offerings;
    try {
      offerings = await Purchases.getOfferings();
      if (kDebugMode) {
        printJson(offerings.toJson());
      }
      availablePackages = {
        for (var package in offerings.current?.availablePackages ?? [])
          package.identifier: package
      };
      if ((availablePackages?.entries ?? []).length >= 2) {
        selectedPackage = (availablePackages?.entries ?? []).elementAt(1).value;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (!mounted) return;
    setState(() {
      _offerings = offerings;
    });
  }

  void printJson(Map<String, dynamic>? json, [int indentation = 0]) {
    json?.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        printJson(value, indentation + 2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backButton(context);
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/home/bg.png'),
            fit: BoxFit.cover,
          )),
          child: SafeArea(
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: imagePaths.length,
                  itemBuilder: (context, index, realIndex) {
                    return Image(image: AssetImage(imagePaths[index]));
                  },
                  options: CarouselOptions(
                    height: 820.0.h,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < imagePaths.length; i++)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: currentIndex == i
                                ? Image.asset(
                                    'assets/onboarding/press_swipe.png',
                                    height: 25.h,
                                    width: 68.w,
                                  )
                                : Image.asset(
                                    'assets/onboarding/unpress_swipe.png',
                                    height: 25.h,
                                    width: 25.w,
                                  ),
                          ),
                      ],
                    ),
                    Image.asset(
                      'assets/splash/text.png',
                      height: 343.h,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                    50.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.w),
                      child: const SubtitleText(
                        text1: 'Unlimited Access',
                        text2: 'Ads free version',
                        text3: 'Enjoy games with friends',
                        text4: 'Unlimited spin wheels',
                        imagePointer: 'assets/premium/press_point.png',
                        height: 48,
                        width: 48,
                        textSize: 45,
                      ),
                    ),
                    50.verticalSpace,
                    _offerings != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                (availablePackages?.entries ?? []).take(2).map(
                              (packageEntry) {
                                print(selectedPackage?.storeProduct.identifier);
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedPackage = packageEntry.value;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 340.h,
                                        width: 520.w,
                                        padding: EdgeInsets.symmetric(horizontal: 40.w,vertical: 20.h),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: selectedPackage
                                                        ?.storeProduct.identifier ==
                                                    packageEntry.value.storeProduct
                                                        .identifier
                                                ? const Color(0xff7DE7FD)
                                                : const Color(0xff21303E),
                                          ),
                                          color: const Color(0xff2C3038),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                packageEntry.value.storeProduct
                                                            .identifier ==
                                                        planeName
                                                    ? 'Weekly'
                                                    : 'Monthly',
                                                style: TextStyle(
                                                    fontSize: 45.sp,
                                                    color: selectedPackage
                                                                ?.storeProduct
                                                                .identifier ==
                                                            packageEntry
                                                                .value
                                                                .storeProduct
                                                                .identifier
                                                        ? Colors.white
                                                        : const Color(0xff697EA7),
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                packageEntry.value.storeProduct.introductoryPrice?.priceString ?? packageEntry.value.storeProduct.priceString,
                                                style: TextStyle(
                                                    fontSize: 65.sp,
                                                    color: selectedPackage?.storeProduct.identifier == packageEntry.value.storeProduct.identifier
                                                        ? Colors.white
                                                        : const Color(0xff697EA7),
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                packageEntry.value.storeProduct
                                                            .identifier ==
                                                        planeName
                                                    ? 'Pay for 1 week'
                                                    : 'Pay for 1 month',
                                                style: TextStyle(
                                                    fontSize: 40.sp,
                                                    color: selectedPackage
                                                                ?.storeProduct
                                                                .identifier ==
                                                            packageEntry
                                                                .value
                                                                .storeProduct
                                                                .identifier
                                                        ? Colors.white
                                                        : const Color(0xff697EA7),
                                                    fontWeight: FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 20.h,
                                         right: 20.w,
                                         child:  selectedPackage?.storeProduct.identifier == packageEntry.value.storeProduct.identifier ? Image.asset('assets/premium/press_point.png',
                                         height: 48.h,
                                           width: 48.w,
                                         ) : const SizedBox(),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 300.h,
                                width: 553.w,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/premium/credit_unpress_bg.png'),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      '200 Credits',
                                      style: TextStyle(
                                          fontSize: 65.sp, color: Colors.grey),
                                    )),
                                    Flexible(
                                        child: Text(
                                      '\$ 22.66',
                                      style: TextStyle(
                                          fontSize: 65.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                height: 300.h,
                                width: 553.w,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/premium/credit_press_bg.png'),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      '200 Credits',
                                      style: TextStyle(
                                          fontSize: 65.sp, color: Colors.grey),
                                    )),
                                    Flexible(
                                        child: Text(
                                      '\$ 22.66',
                                      style: TextStyle(
                                          fontSize: 65.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                    50.verticalSpace,
                    buy_now_button(context),
                    50.verticalSpace,
                    privacy_Terms_of_us_restore(context),
                  ],
                ),
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Padding(
                    padding: EdgeInsets.only(left: 50.w, top: 40.h),
                    child: isClose
                        ? PressUnpress(
                            imageAssetPress: 'Assets.rouletteClosePress',
                            imageAssetUnPress: 'Assets.rouletteCloseUnpress',
                            onTap: () {
                              backButton(context);
                            },
                            height: 62.h,
                            width: 62.w,
                          )
                        : SizedBox(
                            height: 62.h,
                            width: 62.w,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void backButton(BuildContext context) {
    InterstitialAdManager.showInterstitial(
      continueAdsOnline: AdsVariable.in_app_continueAdsOnline,
      id: widget.item ? AdsVariable.fullscreen_in_app_adsId : '11',
      flagCount: AdsVariable.in_appFlag,
      onAdDismissed: () {
        widget.item
            ? Get.back()
            : Get.offAll(() => const Home(),
                routeName: '/home_screen');
      },
    );
  }

  PressUnpress buy_now_button(BuildContext context) {
    return PressUnpress(
      onTap: () async {
        await puarchase_method(context);
      },
      height: 190.h,
      width: 1063.w,
      imageAssetUnPress: 'assets/premium/get_premium_unpress.png',
      imageAssetPress: 'assets/premium/get_premium_press.png',
    );
  }

  Future<void> puarchase_method(BuildContext context) async {
    DialogService.showLoading(context);
    try {
      final customerInfo = await Purchases.purchasePackage(selectedPackage!);
      appData.entitlementIsActive =
          customerInfo.entitlements.all[entitlementKey]!.isActive;
      purchaseController.checkPurchasesStatus().then(
        (value) {
          if (value) {
            AdsVariable.isPurchase = true;
            Fluttertoast.showToast(
                msg: 'Your plan subscribe successfully',
                backgroundColor: const Color(0xfff94952),
                textColor: Colors.white);
            if (widget.item) {
              Get.back(result: true);
            } else {
              Get.offAll(() => const Home());
            }
          } else {
            Fluttertoast.showToast(msg: 'Filed');
          }
        },
      );
      Get.back();
    } on PlatformException catch (e) {
      Get.back();
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        appToast('User cancelled');
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        appToast('User not allowed to purchase');
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        appToast('Payment is pending');
      }
    }
  }

  Row privacy_Terms_of_us_restore(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TermsOfUse(),
                ));
          },
          child: Text(
            "Terms of use",
            style: TextStyle(
              color: const Color(0xFF9B9B9B),
              fontStyle: FontStyle.normal,
              fontSize: 40.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 60.h,
          width: 4.w,
          color: const Color(0xFF9B9B9B),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PrivacyPolicy(),
                ));
          },
          child: Text(
            "Privacy policy",
            style: TextStyle(
              color: const Color(0xFF9B9B9B),
              fontStyle: FontStyle.normal,
              fontSize: 40.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Container(
          height: 60.h,
          width: 4.w,
          color: const Color(0xFF9B9B9B),
        ),
        TextButton(
          onPressed: () async {
            DialogService.showLoading(context);
            try {
              await Purchases.restorePurchases();
              purchaseController.checkPurchasesStatus().then(
                (value) async {
                  if (value) {
                    if (purchaseController.isPurchaseActive.value) {
                      appToast('Your plan subscribe restore');
                    }
                  } else {
                    DialogService.restorePurchasesDialog(context);
                  }
                },
              );
              Navigator.pop(context);
            } catch (e) {
              print('Exception during restore: $e');
              Navigator.pop(context);
            }
          },
          child: Text(
            "Restore",
            style: TextStyle(
              color: const Color(0xFF9B9B9B),
              fontStyle: FontStyle.normal,
              fontSize: 40.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Column buildColumn() {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: const Color(0xff202020),
          highlightColor: const Color(0xfffca4a4),
          child: Container(
            height: 150.h,
            width: 950.w,
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            margin: EdgeInsets.symmetric(vertical: 20.w),
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.grey),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: const Color(0xff202020),
          highlightColor: const Color(0xfffca4a4),
          child: Container(
            height: 150.h,
            width: 950.w,
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            margin: EdgeInsets.symmetric(vertical: 20.w),
            decoration: BoxDecoration(
              color: const Color(0xff242424),
              borderRadius: BorderRadius.circular(35),
              border: Border.all(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}

class AppData {
  static final AppData _appData = AppData._internal();

  bool entitlementIsActive = false;
  String appUserID = '';

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();
