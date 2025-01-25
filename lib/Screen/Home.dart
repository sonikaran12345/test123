import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logomaker/Appstyle/Appstyle.dart';
import 'package:logomaker/common_screen/setting_screen.dart';
import 'package:logomaker/controller/Homescreencontroller.dart';
import 'package:logomaker/service/Mycreation.dart';
import 'package:logomaker/service/image_press_unpress.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Homescreencontroller controller = Get.put(Homescreencontroller());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PressUnpress(
            onTap: () async {
              Get.to(() => const SettingScreen());
            },
            unPressColor: Colors.transparent,
            height: 100.h,
            width: 100.w,
            imageAssetPress: 'assets/setting/setting_pressed.png',
            imageAssetUnPress: 'assets/setting/setting_unpressed.png',
          ).marginOnly(left: 20.w),
        ),
      ),
      body: SafeArea(
       
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              40.verticalSpace,
              Row(
                children: [
                  70.horizontalSpace,
                  Image.asset('assets/setting/appname.png',height: 133.h,width: 486.w,),
                ],
              ),
              50.verticalSpace,
              Row(
                children: [
                  70.horizontalSpace,
                  Text("Product Photos 🛍️",style: AppTextStyles.Appbartext,),
                ],
              ),
              30.verticalSpace,
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.Productphotoslist.length,
                  itemBuilder: (context, index) {
                  return Container(
                    height: 150,
                    width: 150,
                    margin: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: (){
                            controller.pickImageFunction(context);
                          },
                          child: CachedNetworkImage(
                            imageUrl: controller.Productphotoslist[index],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!, // Dark color for the base
                              highlightColor: Colors.white, // Light color for the shimmer effect
                              child: Container(
                                width: 200,
                                height: 40,
                                color: Colors.black, // Background color is black
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                    ),
                  );
                },).marginOnly(left: 70.w),
              ),
              100.verticalSpace,
              Row(
                children: [
                  70.horizontalSpace,
                  Text("Summer ✨",style: AppTextStyles.Appbartext,),
                ],
              ),
              30.verticalSpace,
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.summerTemplateList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        controller.pickImageFunction(context);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: controller.summerTemplateList[index],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,

                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!, // Dark color for the base
                              highlightColor: Colors.white, // Light color for the shimmer effect
                              child: Container(
                                width: 200,
                                height: 40,
                                color: Colors.black, // Background color is black
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },).marginOnly(left: 70.w),
              ),
              100.verticalSpace,
              Row(
                children: [
                  70.horizontalSpace,
                  Text("PodiumtemplateList ✨",style: AppTextStyles.Appbartext,),
                ],
              ),
              30.verticalSpace,
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.PodiumtemplateList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        controller.pickImageFunction(context);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: controller.PodiumtemplateList[index],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,

                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!, // Dark color for the base
                              highlightColor: Colors.white, // Light color for the shimmer effect
                              child: Container(
                                width: 200,
                                height: 40,
                                color: Colors.black, // Background color is black
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },).marginOnly(left: 70.w),
              ),
              100.verticalSpace,
              Row(
                children: [
                  70.horizontalSpace,
                  Text("Use Colorful Backdrops ✨",style: AppTextStyles.Appbartext,),
                ],
              ),
              30.verticalSpace,
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.colorfulBackdropList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        controller.pickImageFunction(context);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: controller.colorfulBackdropList[index],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,

                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!, // Dark color for the base
                              highlightColor: Colors.white, // Light color for the shimmer effect
                              child: Container(
                                width: 200,
                                height: 40,
                                color: Colors.black, // Background color is black
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },).marginOnly(left: 70.w),
              ),
              100.verticalSpace,
              Row(
                children: [
                  70.horizontalSpace,
                  Text("Jewellery Template ✨",style: AppTextStyles.Appbartext,),
                ],
              ),
              30.verticalSpace,
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.jewellerytemplate.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        controller.pickImageFunction(context);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: controller.jewellerytemplate[index],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,

                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!, // Dark color for the base
                              highlightColor: Colors.white, // Light color for the shimmer effect
                              child: Container(
                                width: 200,
                                height: 40,
                                color: Colors.black, // Background color is black
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },).marginOnly(left: 70.w),
              ),
              100.verticalSpace,
              Row(
                children: [
                  70.horizontalSpace,
                  Text("Gradients ✨",style: AppTextStyles.Appbartext,),
                ],
              ),
              30.verticalSpace,
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.colorfulBackdropList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        controller.pickImageFunction(context);
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                        margin: const EdgeInsets.only(right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: controller.colorfulBackdropList[index],
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[800]!, // Dark color for the base
                              highlightColor: Colors.white, // Light color for the shimmer effect
                              child: Container(
                                width: 200,
                                height: 40,
                                color: Colors.black, // Background color is black
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },).marginOnly(left: 70.w),
              ),
              200.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
