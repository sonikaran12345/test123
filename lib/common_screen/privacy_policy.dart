
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logomaker/constant.dart';
import 'package:logomaker/service/image_press_unpress.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..loadRequest(
        Uri.parse(privacyPolicyUrl),
      );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appbackgroundColor,
      appBar: AppBar(
        backgroundColor: appbackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: PressUnpress(
            imageAssetUnPress: 'assets/comenAssest/back_unpress.png',
            imageAssetPress: 'assets/comenAssest/back_press.png',
            onTap: () {
              Navigator.pop(context);
            },
            height: 135.h,
            width: 135.w,
          ),
        ),
        title: Text('Privacy Policy',style: TextStyle(color: Colors.white, fontSize: 75.sp),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
