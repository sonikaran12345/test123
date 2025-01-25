// // ignore_for_file: unused_import
//
// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:purchases_flutter/purchases_flutter.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:logomaker/Ads/ads_load_util.dart';
// import 'package:logomaker/Ads/ads_variable.dart';
// import 'package:logomaker/Appstyle/Appstyle.dart';
// import 'package:logomaker/Screen/Home.dart';
// import 'package:logomaker/Setting/TernsOfUse.dart';
// import 'package:logomaker/Setting/privacy_policy.dart';
// import 'package:logomaker/Upsellscreen/constant.dart';
// import 'package:logomaker/Upsellscreen/creditManager.dart';
// import 'package:logomaker/Upsellscreen/initPlatformState.dart';
// import 'package:logomaker/service/dialog.dart';
// import 'package:logomaker/service/press_unpress.dart';
// import 'package:logomaker/service/sharedPreferencesService.dart';
//
// class UpsellScreen extends StatefulWidget {
//   final bool item;
//
//   const UpsellScreen({super.key, required this.item});
//
//   @override
//   State<StatefulWidget> createState() => _UpsellScreenState();
// }
//
// class _UpsellScreenState extends State<UpsellScreen> {
//   Offerings? _offerings;
//
//   // bool week = true;
//   // bool onemonth = false;
//   // bool threeweek = false;
//   bool isClose = false;
//   Map<String, Package>? availablePackages;
//   Map<String, Package>? packageEntry;
//   Package? selectedPackage;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     Future.delayed(const Duration(seconds: 3), () {
//       setState(() {
//         isClose = true;
//       });
//     });
//    AdsLoadUtil.loadPreInterstitialAd(adId: AdsVariable.pre_interstitialAd);
//   }
//
//   Future<void> fetchData() async {
//     Offerings? offerings;
//     try {
//       offerings = await Purchases.getOfferings();
//       if (kDebugMode) {
//         //printJson(offerings.toJson());
//       }
//       availablePackages = {
//         for (var package in offerings.current?.availablePackages ?? [])
//           package.identifier: package
//       };
//       if ((availablePackages?.entries ?? []).length >= 3) {
//         selectedPackage = (availablePackages?.entries ?? []).elementAt(2).value;
//       }
//     } on PlatformException catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//     if (!mounted) return;
//     setState(() {
//       _offerings = offerings;
//     });
//     if (kDebugMode) {
//       print(offerings);
//     }
//   }
//
//   void printJson(Map<String, dynamic>? json, [int indentation = 0]) {
//     json?.forEach((key, value) {
//       if (value is Map<String, dynamic>) {
//         //printJson(value, indentation + 2);
//       }
//     });
//   }
//
//   back() {
//     AdsLoadUtil.showInterstitial(onDismissed: () {
//       widget.item ? Get.back() : Get.off(() => const Home());
//     });
//   }
//
//   int selectimageindex = 3;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Colors.white,
//       body: WillPopScope(
//         onWillPop: () {
//           back();
//           return Future(() => false);
//         },
//         child: SafeArea(
//           child: Container(
//             height: 1920.h,
//             width: 1080.w,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage('assets/Inapppurchase/logo0.png'),
//                   fit: BoxFit.contain,
//                   alignment: Alignment.topCenter),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     isClose
//                         ? PressUnpress(
//                             onTap: () {
//                               back();
//                             },
//                             height: 70.h,
//                             width: 70.h,
//                             imageAssetPress:
//                                 'assets/Inapppurchase/close_press.png',
//                             imageAssetUnPress:
//                                 'assets/Inapppurchase/close_unpress.png',
//                           ).marginOnly(top: 40.h)
//                         : const SizedBox.shrink(),
//                     30.horizontalSpace
//                   ],
//                 ),
//                 const Spacer(),
//                 Text(
//                   'Device Info',
//                   style:TextStyle(
//                     fontSize: 80.sp,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Quicksand-Bold',
//                     color: Colors.black,
//                   )
//                 ),
//                 30.verticalSpace,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/Inapppurchase/pointer.png',
//                               width: 26.w,
//                               height: 32.h,
//                             ),
//                             20.horizontalSpace,
//                             Text('Unlimited Access',),
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/Inapppurchase/pointer.png',
//                               width: 26.w,
//
//                               height: 32.h,
//                             ),
//                             20.horizontalSpace,
//                             Text('Device Info'),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/Inapppurchase/pointer.png',
//                               width: 26.w,
//                               height: 32.h,
//                             ),
//                             20.horizontalSpace,
//                             Text('Unlock Primium Features',)
//                           ],
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Image.asset(
//                               'assets/Inapppurchase/pointer.png',
//                               width: 26.w,
//                               height: 32.h,
//                             ),
//                             20.horizontalSpace,
//                             Text('Ad free Experience',)
//                           ],
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     // ignore: sized_box_for_whitespace
//                     Container(
//                       // height: 320.h,
//                       width: 1118.w,
//                       child: _offerings != null
//                           ? Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: availablePackages!.entries
//                                       .take(3)
//                                       .map((packageEntry) {
//                                         print("ddddd");
//                                         print( packageEntry.value.storeProduct);
//                                     return GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           selectedPackage = packageEntry.value;
//                                         });
//                                       },
//                                       child: Container(
//                                         height: 250.h,
//                                         width: 300.w,
//                                         decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                             image: AssetImage(selectedPackage ==
//                                                     packageEntry.value
//                                                 ?'assets/Inapppurchase/month_bt_press.png' :  'assets/Inapppurchase/week_bt_unpress.png'
//                                                 ),
//                                             fit: BoxFit.fill,
//                                           ),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                                 packageEntry.value.storeProduct
//                                                             .identifier ==
//                                                         'ds.ahmdemotestapp.com.oneweek'
//                                                     ? "Weekly" : packageEntry.value.storeProduct
//                                                     .identifier ==
//                                                     'ds.ahmdemotestapp.com.onemonth' ?"Monthly"
//                                                     : "Life Time",
//                                                 style: AppTextStyles.Appbartext
//                                                     .copyWith(
//                                                   color: selectedPackage ==
//                                                       packageEntry.value ? Colors.white: const Color(0xFF2E2E2E) ,
//                                                 )),
//                                             Text(
//                                               packageEntry.value.storeProduct
//                                                   .priceString,
//                                               style: AppTextStyles.Appbartext
//                                                   .copyWith(
//                                                 color:  selectedPackage ==
//                                                     packageEntry.value ? Colors.white: const Color(0xFF616161),
//                                                 fontSize: 60.sp,
//                                               ),
//                                             ),
//                                             Text(
//                                               packageEntry.value.storeProduct
//                                                           .identifier ==
//                                                       'ds.ahmdemotestapp.com.oneweek'
//                                                   ? "Per Week" :  packageEntry.value.storeProduct
//                                                   .identifier ==
//                                                   'ds.ahmdemotestapp.com.onemonth' ? 'Per Month'
//                                                   : "Life Time",
//                                               style: AppTextStyles.Appbartext
//                                                   .copyWith(
//                                                       color: selectedPackage ==
//                                                           packageEntry.value ? Colors.white: const Color(
//                                                         0xFF828282,
//                                                       ) ,
//                                                       fontSize: 30.sp),
//                                             ),
//                                             Text(
//                                               'Subscribe Now',
//                                               style: AppTextStyles.Appbartext
//                                                   .copyWith(
//                                                       color: selectedPackage ==
//                                                           packageEntry.value ? Colors.white: const Color(
//                                                         0xFF717171,
//                                                       ) ,
//                                                       fontSize: 30.sp),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ],
//                             )
//                           : buildColumn(),
//                     ).marginOnly(top: 100.h),
//                   ],
//                 ),
//                 100.verticalSpace,
//                 // Container(
//                 //   height: 150.h,
//                 //   width: 850.w,
//                 //   decoration:  BoxDecoration(
//                 //     color: Colors.white,
//                 //     borderRadius: BorderRadius.all(Radius.circular(20)),
//                 //     border: Border.all(color: Colors.grey,width: 1.h)
//                 //   ),
//                 //   child: Row(
//                 //     mainAxisAlignment:
//                 //     MainAxisAlignment.center,
//                 //     children: [
//                 //       Column(
//                 //       children: [
//                 //         Text(
//                 //             "Monthly",
//                 //             style: AppTextStyles.Appbartext
//                 //                 .copyWith(
//                 //               color: const Color(0xFF2E2E2E) ,
//                 //             )),
//                 //         Text(
//                 //           "1000",
//                 //           style: AppTextStyles.titleStyle
//                 //               .copyWith(
//                 //             color: const Color(0xFF616161),
//                 //             fontSize: 60.sp,
//                 //           ),
//                 //         ),
//                 //       ],),
//                 //       Text(
//                 //        "Per Month",
//                 //         style: AppTextStyles.Appbartext
//                 //             .copyWith(
//                 //             color:  const Color(
//                 //               0xFF828282,
//                 //             ) ,
//                 //             fontSize: 30.sp),
//                 //       ),
//                 //       Text(
//                 //         'Subscribe Now',
//                 //         style: AppTextStyles.Appbartext
//                 //             .copyWith(
//                 //             color:  const Color(
//                 //               0xFF717171,
//                 //             ) ,
//                 //             fontSize: 30.sp),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 buy_now_button(context),
//                 150.verticalSpace,
//                 privacy_Terms_of_us_restore(context),
//                 20.verticalSpace,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Future storeCredit() async {
//   //   var credit = await SharedPreferencesService.getCreditValue('Credit');
//   //   credit += 20;
//   //   SharedPreferencesService.setCreditValue(credit, 'Credit');
//   //   CreditsManager.saveUserCredits(credit);
//   // }
//
//   PressUnpress buy_now_button(BuildContext context) {
//     return PressUnpress(
//       onTap: () async {
//         DialogService.showLoading(context);
//         try {
//           final customerInfo =
//               await Purchases.purchasePackage(selectedPackage!);
//           appData.entitlementIsActive =
//               customerInfo.entitlements.all[entitlementKey]!.isActive;
//           CheckPurchasesStatus.initPlatformState().then((value) {
//             if (value) {
//               Fluttertoast.showToast(
//                 msg: 'Your plan subscribe successfully',
//                 textColor: const Color(0xFF14e7e2),
//                 fontSize: 16.0,
//                 backgroundColor: Colors.black,
//               );
//               // storeCredit();
//               if (widget.item) {
//                 Navigator.pop(context, true);
//               } else {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (BuildContext context) {
//                     return const Home();
//                   }),
//                   (route) => false,
//                 );
//               }
//             } else {
//               Fluttertoast.showToast(
//                 msg: 'Failed',
//                 textColor: const Color(0xFF14e7e2),
//                 fontSize: 16.0,
//                 backgroundColor: Colors.black,
//               );
//             }
//           });
//           // ignore: use_build_context_synchronously
//           Navigator.pop(context);
//         } on PlatformException catch (e) {
//           // ignore: use_build_context_synchronously
//           Navigator.pop(context);
//           final errorCode = PurchasesErrorHelper.getErrorCode(e);
//           if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
//             if (kDebugMode) {
//               print('User cancelled');
//             }
//           } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
//             if (kDebugMode) {
//               print('User not allowed to purchase');
//             }
//           } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
//             if (kDebugMode) {
//               print('Payment is pending');
//             }
//           }
//         }
//       },
//       height: 160.h,
//       width: 850.w,
//       imageAssetPress: 'assets/Inapppurchase/Continue_gif _press.gif',
//       imageAssetUnPress: 'assets/Inapppurchase/Continue_gif _press.gif',
//       child: Center(
//           child: Text(
//         'Continue',
//         style: AppTextStyles.Appbartext.copyWith(color: Colors.white),
//       )),
//     );
//   }
//
//   Row privacy_Terms_of_us_restore(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         20.horizontalSpace,
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const TermsOfUse(),
//                 ));
//           },
//           child: Text("Terms of use", style: AppTextStyles.Appbartext),
//         ),
//         const Text("|"),
//         TextButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const PrivacyPolicy(),
//                 ));
//           },
//           child: Text("Privacy policy", style: AppTextStyles.Appbartext),
//         ),
//         const Text("|"),
//         TextButton(
//           onPressed: () async {
//             DialogService.showLoading(context);
//             try {
//               final customerInfo = await Purchases.restorePurchases();
//               // ignore: use_build_context_synchronously
//               Navigator.pop(context);
//               bool isActive =
//                   customerInfo.entitlements.all[entitlementKey]?.isActive ??
//                       false;
//               if (kDebugMode) {
//                 print('isActive: $isActive');
//               }
//               if (!isActive) {
//                 // ignore: use_build_context_synchronously
//                 DialogService.restorePurchasesDialog(context);
//               } else {
//                 CheckPurchasesStatus.initPlatformState().then((value) {
//                   if (value) {
//                     Fluttertoast.showToast(
//                       msg: 'Your restore  successfully',
//                       textColor: const Color(0xFF14e7e2),
//                       fontSize: 16.0,
//                       backgroundColor: Colors.black,
//                     );
//                   } else {
//                     Fluttertoast.showToast(
//                       msg: 'Failed',
//                       textColor: const Color(0xFF14e7e2),
//                       fontSize: 16.0,
//                       backgroundColor: Colors.black,
//                     );
//                   }
//                 });
//               }
//             } catch (e) {
//               Navigator.pop(context);
//             }
//           },
//           child: Text("Restore", style: AppTextStyles.Appbartext),
//         ),
//         30.horizontalSpace,
//       ],
//     );
//   }
//
//   Row buildColumnitem() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         PressUnpress(
//           onTap: () {},
//           height: 320.h,
//           width: 420.w,
//           imageAssetUnPress: 'assets/Inapppurchase/week_bt_unpress.png',
//           imageAssetPress: 'assets/Inapppurchase/month_bt_press.png',
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Weekly',
//                 style:
//                     AppTextStyles.Appbartext.copyWith(color: const Color(0xFF2E2E2E)),
//               ),
//               Text(
//                 '\$ 45',
//                 style: AppTextStyles.Appbartext.copyWith(
//                   color: const Color(0xFF616161),
//                   fontSize: 60.sp,
//                 ),
//               ),
//               Text(
//                 'Per Week',
//                 style: AppTextStyles.Appbartext.copyWith(
//                     color: const Color(
//                       0xFF828282,
//                     ),
//                     fontSize: 30.sp),
//               ),
//               Text(
//                 'Subscribe Now',
//                 style: AppTextStyles.Appbartext.copyWith(
//                     color: const Color(
//                       0xFF717171,
//                     ),
//                     fontSize: 30.sp),
//               ),
//             ],
//           ),
//         ),
//         PressUnpress(
//           onTap: () {},
//           height: 320.h,
//           width: 420.w,
//           imageAssetUnPress: 'assets/Inapppurchase/week_bt_unpress.png',
//           imageAssetPress: 'assets/Inapppurchase/month_bt_press.png',
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Weekly',
//                 style:
//                     AppTextStyles.Appbartext.copyWith(color: const Color(0xFF2E2E2E)),
//               ),
//               Text(
//                 '\$ 45',
//                 style: AppTextStyles.Appbartext.copyWith(
//                   color: const Color(0xFF616161),
//                   fontSize: 60.sp,
//                 ),
//               ),
//               Text(
//                 'Per Week',
//                 style: AppTextStyles.Appbartext.copyWith(
//                     color: const Color(
//                       0xFF828282,
//                     ),
//                     fontSize: 30.sp),
//               ),
//               Text(
//                 'Subscribe Now',
//                 style: AppTextStyles.Appbartext.copyWith(
//                     color: const Color(
//                       0xFF717171,
//                     ),
//                     fontSize: 30.sp),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Row buildColumn() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         Shimmer.fromColors(
//             baseColor: const Color(0xff0F67FD),
//             highlightColor: const Color(0XFFFFFFFF),
//             child: Container(
//               height: 320.h,
//               width: 420.w,
//               decoration: BoxDecoration(
//                 color: const Color(0xff242424),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     50.w,
//                   ),
//                 ),
//                 border: Border.all(
//                   color: const Color(0xff3d3d3d),
//                 ),
//               ),
//             )),
//         Shimmer.fromColors(
//             baseColor: const Color(0xff0F67FD),
//             highlightColor: const Color(0XFFFFFFFF),
//             child: Container(
//               height: 320.h,
//               width: 420.w,
//               decoration: BoxDecoration(
//                 color: const Color(0xff242424),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     50.w,
//                   ),
//                 ),
//                 border: Border.all(
//                   color: const Color(0xff3d3d3d),
//                 ),
//               ),
//             )),
//       ],
//     );
//   }
//
// // InkWell buildInkWell(MapEntry<String, Package> packageEntry) {
// //   return InkWell(
// //     splashColor: Colors.transparent,
// //     highlightColor: Colors.transparent,
// //     onTap: () {
// //       setState(() {
// //         week = false;
// //         onemonth = false;
// //         threeweek = false;
// //         selectedPackage = packageEntry.value;
// //       });
// //     },
// //     child: Align(
// //       alignment: Alignment.center,
// //       child: Container(
// //         height: 150.h,
// //         width: 962.w,
// //         padding: EdgeInsets.symmetric(horizontal: 50.w),
// //         margin: EdgeInsets.symmetric(vertical: 20.w),
// //         decoration: BoxDecoration(
// //           color: const Color(0xff242424),
// //           borderRadius: BorderRadius.circular(35.h),
// //           border: Border.all(
// //               color: selectedPackage == packageEntry.value
// //                   ? appColor
// //                   : const Color(0xff404040)),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Row(
// //               children: [
// //                 CircleAvatar(
// //                   radius: 7,
// //                   backgroundColor: selectedPackage == packageEntry.value
// //                       ? appColor
// //                       : textColor,
// //                 ),
// //                 SizedBox(
// //                   width: 40.w,
// //                 ),
// //                 Text(
// //                   (packageEntry.value.identifier ?? "") ==
// //                           'ds.ahmdemotestapp.com.onefourtynine'
// //                       ? '149 Credit'
// //                       : "449 Credit",
// //                   style: TextStyle(
// //                       fontSize: 55.sp, color: CupertinoColors.white),
// //                 ),
// //               ],
// //             ),
// //             Text(
// //               packageEntry.value.storeProduct.priceString,
// //               style: TextStyle(fontSize: 55.sp, color: CupertinoColors.white),
// //             ),
// //           ],
// //         ),
// //       ),
// //     ),
// //   );
// // }
// }
//
// // ignore: camel_case_types
// class sizeWidget extends StatelessWidget {
//   const sizeWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50.h,
//     );
//   }
// }
//
// class AppData {
//   static final AppData _appData = AppData._internal();
//
//   bool entitlementIsActive = false;
//   String appUserID = '';
//
//   factory AppData() {
//     return _appData;
//   }
//
//   AppData._internal();
// }
//
// final appData = AppData();
