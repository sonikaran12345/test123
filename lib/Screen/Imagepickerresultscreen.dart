import 'package:flutter/material.dart';
import 'package:logomaker/Appstyle/Appstyle.dart';

class Imagepickerresultscreen extends StatelessWidget {
  const Imagepickerresultscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          title: Text(
            "Image Preview",
            style: AppTextStyles.Appbartext,
          )),
    );
  }
}
