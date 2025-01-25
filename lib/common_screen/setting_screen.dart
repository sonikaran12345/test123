import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logomaker/common_screen/privacy_policy.dart';
import 'package:logomaker/configuration/Severce.dart';
import 'package:logomaker/constant.dart';
import 'package:logomaker/google_ads_material/gdpr_initialized.dart';
import 'package:logomaker/service/image_press_unpress.dart';
import 'package:logomaker/service/submitRating.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SubmitRating submitRating = SubmitRating();
  final AdService adService = AdService();
  String data = '';
  bool isShare = false;

  @override
  void initState() {
    super.initState();
    adService.gdprAvailable().then((_) async {
      data = await adService.getData();
      Future.delayed(
        const Duration(seconds: 1),
        () {
          setState(() {});
        },
      );
    });
  }

  final InitializationHelper _initializationHelper = InitializationHelper();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: appbackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PressUnpress(
              onTap: () async {
                Get.back();
              },
              unPressColor: Colors.transparent,
              height: 100.h,
              width: 100.w,
              imageAssetPress: 'assets/videocompress/back_arrow_upressed.png',
              imageAssetUnPress:
              'assets/videocompress/back_arrow_unpressed.png',
            ).marginOnly(left: 20.w),
          ),
          title: Text(
            'Setting',
            style: TextStyle(
              color: Colors.white,
              fontSize: 55.sp,
              fontFamily: "RedHatDisplaysemibold",
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                20.verticalSpace,
                if (data == '1')
                PressUnpress(
                  imageAssetPress: 'assets/setting/gdpr_pressed.png',
                  imageAssetUnPress: 'assets/setting/gdpr_unpressed.png',
                  onTap: () {
                    Get.back();
                  },
                  height: 180.h,
                  width: 1080.w,
                ),
            10.verticalSpace,
                PressUnpress(
                  imageAssetPress: "assets/setting/share_app_unpressed.png",
                  imageAssetUnPress: "assets/setting/share_app_pressed.png",
                  onTap: () {
                    if (!isShare) {
                      isShare = true;
                      submitRating.shareContent(context);
                      Future.delayed(const Duration(seconds: 2), () {
                        isShare = false;
                      });
                    }
                  },
                  height: 180.h,
                  width: 1080.w,
                ),
                10.verticalSpace,
                PressUnpress(
                  imageAssetPress: "assets/setting/rate_app_pressed.png",
                  imageAssetUnPress: "assets/setting/rateapp_unpress.png",
                  onTap: () {
                    submitRating.submitRating(context);

                  },
                  height: 180.h,
                  width: 1080.w,
                ),
                20.verticalSpace,
                PressUnpress(
                  imageAssetPress: "assets/setting/privacy policy_unpressed.png",
                  imageAssetUnPress: "assets/setting/privacy policy_pressed.png",
                  onTap: () async{
                    final didChangePreferences = await _initializationHelper
                        .changePrivacyPreferences();
                    appToast(didChangePreferences
                        ? 'Your privacy choices have been updated'
                        : 'An error occurred while trying to change your privacy choices');
                  },
                  height: 180.h,
                  width: 1080.w,
                ),

                20.verticalSpace,
                // if (data == '1')
                //   PressUnpress(
                //     imageAssetPress: "Assets.settingGdprPress",
                //     imageAssetUnPress: "Assets.settingGdprUnpress",
                //     onTap: () async {
                //       final didChangePreferences = await _initializationHelper
                //           .changePrivacyPreferences();
                //       appToast(didChangePreferences
                //           ? 'Your privacy choices have been updated'
                //           : 'An error occurred while trying to change your privacy choices');
                //     },
                //     height: 221.h,
                //     width: 1155.w,
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}