import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logomaker/Appstyle/Appstyle.dart';
import 'package:logomaker/controller/Homescreencontroller.dart';

class Resultscreen extends StatelessWidget {
  const Resultscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Homescreencontroller controller = Get.find();
    print(controller.removedbgpath.value);
    print("ssssssssssss");
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Image Result",
            style: AppTextStyles.Appbartext,
          )),
      body: Column(
        children: [
       Stack(
         children: [
           Image.network(controller.colorfulBackdropList.first),
           Obx(
              () =>
            Image.file(
                 File(controller.removedbgpath.value,)),
           ),
         ],
       )
      ],),
    );
  }
}
