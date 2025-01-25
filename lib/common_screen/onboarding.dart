import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logomaker/Screen/Home.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';
import 'package:logomaker/google_ads_material/nativeAdService.dart';
import 'package:logomaker/google_ads_material/native_ad_widget.dart';
import 'package:logomaker/puarchase/puarchase_screen.dart';
import 'package:logomaker/puarchase/purchase_controller.dart';
import 'package:logomaker/service/image_press_unpress.dart';
import 'package:logomaker/service/sharedPreferencesService.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  final NativeAdManager nativeAdManager = Get.find<NativeAdManager>();
  final PurchaseController purchaseController = Get.put(PurchaseController());
  int _currentPage = 0;
  bool isLoaded = false;

  bool _isAdUnitIdValid() {
    return AdsVariable.native_onboarding_big != '11';
  }

  late final List<Widget> textImageList = [
    Image.asset('assets/onbording/textsp0.png', height: 335.h, width: 964.w),
    Image.asset('assets/onbording/textsp1.png', height: 335.h, width: 964.w),
    if(_isAdUnitIdValid())Image.asset('assets/onboarding/text.png', height: 335.h, width: 964.w),
    Image.asset('assets/onbording/textsp2.png', height: 335.h, width: 904.w),

  ];

  late final List<Widget> _pages = [
    OnboardingPage(bgImage: 'assets/Splash/bg.png', image: Image.asset('assets/onbording/logo0.png',height: 1100.h,width: 1100.w,fit: BoxFit.contain,alignment: Alignment.topCenter,),),
    OnboardingPage(bgImage: 'assets/Splash/bg.png', image: Image.asset('assets/onbording/logo1.png',height: 1158.h,width: 1242.w,fit: BoxFit.contain,alignment: Alignment.topCenter,),),
    if(_isAdUnitIdValid())SafeArea(
      child: NativeAdWidget(
        nativeAd: nativeAdManager.languageScreenNativeAd,
        adLoadState: nativeAdManager.languageScreenAdLoadState,
        height: double.infinity, isSmall: false,
      ),
    ),
    OnboardingPage(bgImage: 'assets/Splash/bg.png', image: Image.asset('assets/onbording/logo2.png',height: 1138.h,width: 1143.w,fit: BoxFit.contain,alignment: Alignment.topCenter,),),
    // OnboardingPage(bgImage: 'assets/Splash/bg.png', image:  Image.asset('assets/onbording/logo2.png',height: 1233.h,width: 1242.w,fit: BoxFit.contain,alignment: Alignment.topCenter,),),
  ];


  @override
  void didChangeDependencies() {
    if (nativeAdManager.adLoadState.value == AdLoadState.failed) {
      nativeAdManager.loadNativeAd(AdsVariable.native_onboarding_small);
    }
    nativeAdManager.loadLanguageScreenAd(AdsVariable.native_onboarding_big);
   super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _pages[index];
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
              if(index == 3 && _isAdUnitIdValid() && !isLoaded){
                isLoaded = true;
                nativeAdManager.loadNativeAd(AdsVariable.native_onboarding_small);
              }
            },
          ),
          if (_currentPage != 2 || !_isAdUnitIdValid())SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                textImageList[_currentPage],
                50.verticalSpace,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // for (int i = 0; i < _pages.length; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child:
                              // _currentPage == i
                              //     ?
                              Image.asset(
                                      'assets/onbording/indicator${_currentPage}.png',
                                      height: 35.h,
                                      width: 205.w,
                                    )
                                  // : Image.asset(
                                  //     'assets/onbording/indicator0.png',
                                  //     height: 25.h,
                                  //     width: 25.w,
                                  //   ),
                            ),
                        ],
                      ),
                      PressUnpress(
                        imageAssetUnPress: _currentPage == _pages.length - 1
                            ? 'assets/onbording/done_button_unpressed.png'
                            : "assets/onbording/next_button_unpressed.png",
                        imageAssetPress: _currentPage == _pages.length - 1
                            ? 'assets/onbording/done_button_pressed.png'
                            : "assets/onbording/next_button_pressed.png",
                        onTap: () {
                          if (_currentPage < _pages.length - 1) {
                            setState(() {
                              _currentPage++;
                              _pageController.animateToPage(_currentPage,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            });
                          } else {
                            SharedPreferencesService.setUser('username');
                            Get.offAll(!purchaseController.isPurchaseActive.value ?  const Home() : () => Home(), routeName: '/home_screen');
                          }
                        },
                        height: 100.h,
                        width: 240.w,
                      ),
                    ],
                  ),
                ),
                50.verticalSpace,
                if(_currentPage == 0 || !_isAdUnitIdValid() || _currentPage == 4)NativeAdWidget(
                  nativeAd: nativeAdManager.nativeAd,
                  adLoadState: nativeAdManager.adLoadState,
                  height: 475, isSmall: true,
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}


class OnboardingPage extends StatelessWidget {
  final String bgImage;
  final Widget image;

  const OnboardingPage({super.key, required this.bgImage, required this.image,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          )
      ),
      child: image,
    );
  }
}
