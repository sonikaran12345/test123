import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logomaker/Appstyle/Appstyle.dart';
import 'package:logomaker/service/image_press_unpress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Mycreation_controller extends GetxController {

  RxList<File> imagelist = <File>[].obs;
  RxString selected_image_path = ''.obs;
  RxInt selected_image_index =  0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    featchimage();
  }

  void featchimage() async {
    final directory = await getApplicationDocumentsDirectory();
    final folderName = "${directory.path}";

    // Access the specific folder
    final folder = Directory(folderName);

    // Check if the folder exists
    if (!folder.existsSync()) {
      print("Folder does not exist: $folderName");
    }

    // List all files in the folder
    final files = folder.listSync();
    print(files);

    final imagefile = files.where((file) {
      final fileextesion = file.path
          .split(".")
          .last
          .toLowerCase();
      return ['png', 'jpeg', 'jpg'].contains(fileextesion);
    }).map((file) => File(file.path)).toList();


    imagefile.sort((a, b) {
      final aTime = a.statSync().modified;
      final bTime = b.statSync().modified;
      return bTime.compareTo(aTime); // Newest images first
    });

    print(imagefile);
    imagelist.value = imagefile;
  }
}

class Mycration extends StatelessWidget {

  final Mycreation_controller controller = Get.put(Mycreation_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "My creation",
            style: AppTextStyles.Appbartext,
          )),
      body: Obx( () {
        return GridView.builder(
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              childAspectRatio: 1.2
          ),
          itemCount: controller.imagelist.value.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: ()async{
                controller.selected_image_path = controller.imagelist.value[index].path.obs;
                print(controller.selected_image_path.value);
                controller.selected_image_index.value = index;
              await  Get.to(() => Fullscreen_image());
              controller.featchimage();
              },
              child: Container(
                margin:  EdgeInsets.all(10),
                height: 200.h,
                width: 200.h,
                decoration:  BoxDecoration(color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  // border: Border.all( color: Colors.white,width: 1)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                      controller.imagelist.value[index], fit: BoxFit.contain,)),
              ),
            );
          },
        );
      }),
    );
  }
}


class Fullscreen_image extends StatelessWidget {

 final Mycreation_controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Padding(
              padding: const EdgeInsets.all(12.0),
              child: PressUnpress(onTap: (){
                  Get.back();
              }, height: 50.h, width: 50.h,imageAssetPress: 'assets/videocompress/back_arrow_unpressed.png',imageAssetUnPress: 'assets/videocompress/back_arrow_unpressed.png',),
            ),
            title: Text("Image Preview",style: AppTextStyles.Appbartext,),iconTheme: IconThemeData(color: Colors.white)),
        body: SafeArea(
          child: Column(
            children: [
              100.verticalSpace,
              Row(
                children: [
                  Center(
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(File(controller.selected_image_path.value),fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ],
              ),
              100.verticalSpace,
              PressUnpress(onTap: ()async{
                final file = File(controller.selected_image_path.value);
                if(await file.exists() ){
                  await file.delete();
                  Fluttertoast.showToast(msg: "File deleted !");
                  Get.back();
                }else{
                  Fluttertoast.showToast(msg: 'File not found');
                }
              }, height: 160.h, width: 900.w,imageAssetUnPress: 'assets/AR_logo/delete_unpress.png',imageAssetPress: 'assets/AR_logo/delete_press.png',),
              20.verticalSpace,
              PressUnpress(onTap: ()async{
                await Share.shareXFiles([XFile(controller.selected_image_path.value)]);
              }, height: 160.h, width: 900.w,imageAssetUnPress: 'assets/AR_logo/share_unpress.png',imageAssetPress: 'assets/AR_logo/share_press.png',),

            ],
          ),
        ),
      );
  }
}
