import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubtitleText extends StatelessWidget {
  final String text1,text2,text3,text4,imagePointer;
  final double height,width,textSize;
  const SubtitleText({super.key, required this.text1, required this.text2, required this.text3, required this.text4, required this.imagePointer, required this.height, required this.width, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    imagePointer,
                    height: height.h,
                    width: width.w,
                  ),
                  20.horizontalSpace,
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        text1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textSize.sp,
                          overflow: TextOverflow.ellipsis
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Row(
                children: [
                  Image.asset(
                    imagePointer,
                    height: height.h,
                    width: width.w,
                  ),
                  20.horizontalSpace,
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        text2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textSize.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Image.asset(
                    imagePointer,
                    height: height.h,
                    width: width.w,
                  ),
                  20.horizontalSpace,
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        text3,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textSize.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Row(
                children: [
                  Image.asset(
                    imagePointer,
                    height: height.h,
                    width: width.w,
                  ),
                  20.horizontalSpace,
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        text4,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: textSize.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
