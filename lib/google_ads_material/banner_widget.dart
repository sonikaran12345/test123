import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:logomaker/puarchase/purchase_controller.dart';
import 'package:shimmer/shimmer.dart';

class BannerWidget extends StatefulWidget {
  final String adsId;

  const BannerWidget({super.key, required this.adsId});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final ValueNotifier<bool> _isLoaded = ValueNotifier<bool>(false);
  PurchaseController purchaseController = Get.put(PurchaseController());
  BannerAd? _anchoredAdaptiveAd;
  Orientation? _currentOrientation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callBanner();
    });
  }

  void callBanner() async {
    _currentOrientation = MediaQuery.of(context).orientation;
    if (widget.adsId != '11') _loadAd();
  }

  Future<void> _loadAd() async {
    try {
      await _anchoredAdaptiveAd?.dispose();
      _anchoredAdaptiveAd = null;
      _isLoaded.value = false;
      final size =
          await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate(),
      );
      if (size == null) {
        return;
      }
      _anchoredAdaptiveAd = BannerAd(
        adUnitId: widget.adsId,
        size: size,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded.value = true;
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
        ),
      );

      await _anchoredAdaptiveAd!.load();
    } catch (e) {}
  }

  Widget _getAdWidget() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _anchoredAdaptiveAd != null &&
            _isLoaded.value) {
          return SizedBox(
            height: _anchoredAdaptiveAd!.size.height.toDouble(),
            width: _anchoredAdaptiveAd!.size.width.toDouble(),
            child: AdWidget(ad: _anchoredAdaptiveAd!),
          );
        }
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd();
        }
        return widget.adsId != '11'
            ? Shimmer.fromColors(
                baseColor: CupertinoColors.destructiveRed,
                highlightColor: CupertinoColors.systemCyan,
                child: Container(
                  height: MediaQuery.of(context).size.height / 13.5,
                  width: double.infinity,
                  color: CupertinoColors.white,
                ),
              )
            : const SizedBox();
      },
    );
  }

  @override
  void dispose() {
    _anchoredAdaptiveAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoaded,
      builder: (BuildContext context, bool value, Widget? child) {
        return Obx(() {
          return purchaseController.isPurchaseActive.value ||
                  widget.adsId == '11'
              ? const SizedBox.shrink()
              : _getAdWidget();
        });
      },
    );
  }
}
