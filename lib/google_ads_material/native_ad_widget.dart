import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:logomaker/google_ads_material/ads_variable.dart';
import 'package:logomaker/google_ads_material/nativeAdService.dart';
import 'package:logomaker/google_ads_material/shimmer.dart';
import 'package:logomaker/puarchase/purchase_controller.dart';

class NativeAdWidget extends StatelessWidget {
  final Rx<NativeAd?> nativeAd;
  final Rx<AdLoadState> adLoadState;
  final double height;
  final bool isSmall;

  const NativeAdWidget({
    super.key,
    required this.nativeAd,
    required this.adLoadState,
    required this.height,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    final purchaseController = Get.find<PurchaseController>();
    return Obx(() {
      if (adLoadState.value == AdLoadState.loading) {
        return isSmall ? NativeAdViewShimmer() : NativeAdViewShimmerListTile();
      } else if (adLoadState.value == AdLoadState.failed || purchaseController.isPurchaseActive.value) {
        return const SizedBox.shrink();
      } else if (adLoadState.value == AdLoadState.loaded && nativeAd.value != null) {
        return Container(
          height: height.h,
          decoration: BoxDecoration(
              color: Color(int.parse('0xff${AdsVariable.nativeBGColor}')),
              borderRadius: BorderRadius.circular(20)
          ),
          child: AdWidget(ad: nativeAd.value!),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
