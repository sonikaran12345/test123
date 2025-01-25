import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logomaker/Screen/Home.dart';
import 'package:logomaker/constant.dart';
import 'package:logomaker/service/gradient_text.dart';
import 'package:logomaker/service/image_press_unpress.dart';
import 'package:permission_handler/permission_handler.dart';

class DialogService {

  static void loadingCloseButton(){
    Get.dialog(
      AlertDialog(
        backgroundColor: dialogBgColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GradientText(
              text: 'Exit Process',
              gradient: const LinearGradient(
                  colors: [
                    pressColor,
                    unPressColor
                  ]
              ),
              fontSize: 75.sp,
              fontWeight: FontWeight.normal,
            ),
            25.verticalSpace,
            GradientText(
              text: 'Are you sure you want to exit? The face-swapping process will be canceled, and credits will be deducted.',
              gradient: const LinearGradient(
                  colors: [
                    pressColor,
                    unPressColor
                  ]
              ),
              fontSize: 45.sp,
              fontWeight: FontWeight.normal,
            ),
            50.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PressUnpress(
                 pressGradient: const LinearGradient(
                      colors: [appColor,unPressColor]
                  ),
                  unPressGradient: const LinearGradient(
                      colors: [unPressColor,appColor]
                  ),
                  onTap: () {
                    Get.back();
                  },
                  height: 130.h,
                  width: 350.w,
                  child: Text('Cancel',style: TextStyle(color: dialogButtonTextColor,fontSize: 55.sp),),
                ),
                PressUnpress(
                  pressGradient: const LinearGradient(
                      colors: [appColor,unPressColor]
                  ),
                  unPressGradient: const LinearGradient(
                      colors: [unPressColor,appColor]
                  ),
                  onTap: () {
                    Get.offAll(() => const Home());
                    Fluttertoast.showToast(msg: "Process canceled. Credits deducted.");
                  },
                  height: 130.h,
                  width: 350.w,
                  child: Text('Exit',style: TextStyle(color: dialogButtonTextColor,fontSize: 55.sp),),
                )
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void backDownloadImageDialog(BuildContext context,String item){
    Get.dialog(
      AlertDialog(
        backgroundColor: dialogBgColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GradientText(
              text: 'Are you sure?',
              gradient: const LinearGradient(
                  colors: [
                    pressColor,
                    unPressColor
                  ]
              ),
              fontSize: 75.sp,
              fontWeight: FontWeight.normal,
            ),
            25.verticalSpace,
            GradientText(
              text: 'Are you sure want to go back without saving this $item.',
              gradient: const LinearGradient(
                  colors: [
                    pressColor,
                    unPressColor
                  ]
              ),
              fontSize: 45.sp,
              fontWeight: FontWeight.normal,
            ),
            50.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                PressUnpress(
                  pressGradient: const LinearGradient(
                      colors: [appColor,unPressColor]
                  ),
                 unPressGradient: const LinearGradient(
                      colors: [unPressColor,appColor]
                  ),
                  onTap: () {
                    Get.back();
                  },
                  height: 130.h,
                  width: 350.w,
                  child: Text('No',style: TextStyle(color: dialogButtonTextColor,fontSize: 55.sp),),
                ),
                PressUnpress(
                  pressGradient: const LinearGradient(
                      colors: [appColor,unPressColor]
                  ),
                  unPressGradient: const LinearGradient(
                      colors: [unPressColor,appColor]
                  ),
                  onTap: () {
                    Get.offAll(() => const Home());
                  },
                  height: 130.h,
                  width: 350.w,
                  child: Text('Yes',style: TextStyle(color: dialogButtonTextColor,fontSize: 55.sp),),
                )
              ],
            ),
          ],
        ),
      ),
      barrierDismissible: true,
    );
  }

  static void showLoading(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: Colors.transparent,
              dialogTheme:
              const DialogTheme(backgroundColor: Colors.transparent),),
            child: const CupertinoAlertDialog(
              title: Center(child: CupertinoActivityIndicator()),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
  }
  
  static void restorePurchasesDialog(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('No Purchases Found'),
            content: const Text(
                "You've no active subscriptions. Kindly purchase any of the given subscriptions."),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
  }

  static void showCheckConnectivity(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const Text('Connection'),
            content: const Text('Check your internet connection.'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            title: const Text('Connection'),
            content: const Text('Check your internet connection.'),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  static void showpermissiondialog(BuildContext context, String item) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text('Allow access to $item in the Setting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text('Setting'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            content: Text('Allow access to $item in the Setting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text('Setting'),
              ),
            ],
          );
        },
      );
    }
  }

}
