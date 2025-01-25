import 'dart:io';

import 'package:action_slider/action_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logomaker/Appstyle/Appstyle.dart';
import 'package:logomaker/Screen/Imagepickerresultscreen.dart';
import 'package:logomaker/Screen/ResultScreen.dart';
import 'package:logomaker/controller/Homescreencontroller.dart';
import 'package:shimmer/shimmer.dart';

class Imagepickerscreen extends StatelessWidget {
  const Imagepickerscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Homescreencontroller controller = Get.find();
    double opacity = 1.0;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Image Preview",
            style: AppTextStyles.Appbartext,
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AspectRatio(
                  aspectRatio: controller.aspectRatio.value,
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: Get.width / 2, maxHeight: Get.height / 2),
                    child: ClipRRect(
                        // borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                      File(controller.selectedFile!.path),
                      fit: BoxFit.cover,
                    )),
                  ),
                ),
              ),
            ),
            150.verticalSpace,

            ActionSlider.standard(
              sliderBehavior: SliderBehavior.stretch,
              width: 300.0,
              backgroundColor: Color(0XFF2D3036),
              toggleColor: Colors.white,
              action: (controllerss) async {
                controllerss.loading(); //starts loading animation
                controller.Removedbackground();
                await Future.delayed(const Duration(seconds: 3));
                controllerss.success(); //starts success animation
                Get.to(() => Resultscreen());
                await Future.delayed(const Duration(seconds: 1));
                controllerss.reset();
              },
              child: Shimmer.fromColors(
                baseColor: Colors.grey, // Base shimmer color
                highlightColor: Colors.black, // Highlight shimmer color
                child: const Text(
                  'Slide to Remove Background',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12, // Adjusted font size for better readability
                    color: Color(0xff929497), // Text color
                    fontWeight: FontWeight.w200, // Bold font weight
                  ),
                ),
              ),
            ),
           100.verticalSpace,
            // ElevatedButton(onPressed: (){
            //   controller.Removedbackground();
            // }, child: Text("Continue"))
          ],
        ),
      ),
    );
  }
}
