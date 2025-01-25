
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logomaker/Screen/Imagepickerscreen.dart';
import 'package:logomaker/constant.dart';
import 'package:logomaker/service/permission.dart';
import 'dart:ui' as ui;
import 'dart:typed_data'; // Make sure this is imported only once
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';

class Homescreencontroller extends GetxController{

  RxList<String> Productphotoslist = [
    'https://cdn.pixelcut.app/assets/discover/templates/hHlmhMTmsQXzN74cC8eJ/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/Zhr5oP1UUZ6hOIKsS6tr/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/Bqn2jDZ4GdyO4z6OvxrX/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/8wfbDgj1N2YWS1ke0fPB/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/SQGbbazOaLZM7SYBPH8Z/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/tKy8Yiys8ILO38iqVCYH/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/S7omC73ztKo10R3YdLQD/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/WJQC2YM8m39LCXiDoAiy/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/UKgrmdseI6gBucMGaHcD/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/TAXj01k7giqSml4vjkOq/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/i7zUWHBQlrg2cVoCtRus/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/caLSh1Fs0oZTwJRH0Qvh/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/8ZoN688XqYezl6deemRa/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/Z5wWC9fJgoZrnpYLvDOi/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/Xf1Wb0F4kGTIRvbZpzKq/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/GSFMxEfkvMGazwMoT3Rn/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/La5oV4P5Kdv8o2PtINHW/preview.jpg',
    'https://cdn.pixelcut.app/assets/discover/templates/xkLhGCTGvTzCXAdYcz47/preview.jpg',
  ].obs;


  RxList<String> summerTemplateList = [
    // API Links
    // Image Links
    'https://cdn.pixelcut.app/assets/templates/caa8d8b9-8e14-4959-aa92-e59f66a6879e/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/c44481fe-010b-42fb-b83b-a51abf64a473/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/4be3b387-6b55-46e7-abff-62281167eba7/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/1b177be7-422b-411c-bc1a-a636a15f77b4/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/2babdd4a-f446-46d0-8fb8-b57721804d65/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/0e7f7a4b-1741-4e06-831e-77aa93db38a0/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/02afb36b-5b38-4282-b7ea-09d04b5c4073/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/5b06175b-814e-4b97-9e42-0e246a23dd31/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/a66e9d49-63b6-42a5-9843-1ad455ca3cf5/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/89e8ae98-8897-4e04-b340-365914076508/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/110a4f98-399e-4121-afa7-030c17ab94e3/preview.jpg',
  ].obs;

  RxList<String> PodiumtemplateList = [
    'https://cdn.pixelcut.app/assets/templates/220cad2a-7575-4e70-8a4f-1bd720676909/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/6d515181-60bb-4b7b-9d6a-1c8ac9b45c8b/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/b46ed35d-a2d9-4f62-9f48-fd489fbf6235/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/cd57a7d6-6f79-4892-acf7-42fc8b13645c/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/81c34254-2b7f-4e22-875b-f71c466488d5/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/44a124f8-24ce-423a-8e16-25c739297b43/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/d91e49f4-d79c-42bf-afbb-0df6e6254b9c/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/53bb5fb4-9be2-4bb2-be6e-957379732e66/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/5cc8723a-f0f1-46b4-bc82-bed3b52297cb/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/a77cd21d-5e62-46cc-be7e-76dba27cf054/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/a2519210-76e1-4a18-bdf9-800e816718f9/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/45174429-d629-408c-8059-b783bb714cf1/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/f7ed3588-03ff-4520-98e0-76d9b2ff7fed/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/48b5830c-c98c-4af0-98ba-02f82ab0a4cf/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/1ffeb422-a7b9-4de8-abfa-e5bdf672a013/preview.jpg',
    'https://cdn.pixelcut.app/assets/templates/6b940b55-8162-4734-a3b9-682a89610874/preview.jpg',
  ].obs;

  RxList<String> colorfulBackdropList = [
    'https://cdn3.pixelcut.app/assets/templates/8B14LmR1sboMLssjvGbi/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/LnNyhS6ezeAGUcoH5Un2/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/US6qOSWA7LHwLnWK1ttm/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/G4sxApdQz4OdmSjxFYQy/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/YTs0i8a5FIOCvBxRuaYC/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/DRnVIF2Prcfcz3N6KX2c/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/903Q7hRn6R9chnCKoNeW/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/6BuT5wjdJi3RREZKp9kp/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/ywqTrUKhi8C6sEdvUBtl/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/DDGr7HvRalUuS6rfBp73/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/HlP8bT2TlXv7Ky4vBQxR/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/Zwtc15CRxISYRn0zX4OJ/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/4KcxxUjQxF1oSXnMvFmm/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/8nNiBi26q7iGy3Mj3epY/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/V2qCRYceEDIrnM2YVjTL/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/uIUmuk6cR5czQ0vY7pXN/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/YNzXtyDhLzFTlSJs94Hs/preview.jpg',
  ].obs;

  RxList<String> jewellerytemplate = [
    'https://cdn3.pixelcut.app/assets/templates/71OFtn8CPTty2m5ys7Gl/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/xelsEI3N2W6tQDthOMoW/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/GojLEvWopXbSCTCkh5K4/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/6QovGJLjN39H7YGzNU8v/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/8BJthFJRQiLkRlBuQuXg/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/t5chO8CeDn3Eq1jZo382/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/kzKrE2t1mus8mc0G6ub3/preview.jpg',
    'https://cdn3.pixelcut.app/assets/templates/0glNPBvqa6fivPazTfEx/preview.jpg',
  ].obs;



  final ImagePicker picker = ImagePicker();
  XFile? selectedFile;
  RxDouble aspectRatio = 1.00.obs ;
  Future<void> pickImageFunction(BuildContext context) async {
    // Check if the user has granted permission to access the gallery
    bool hasPermission = await MyPermissionHandler.checkPermission(context, 'gallery');

    if (!hasPermission) {
      // Show a dialog if permission is denied
      MyPermissionHandler.showpermissiondialog(context, 'gallery');
    } else {
      // Allow the user to pick an image from the gallery
      selectedFile = await picker.pickImage(source: ImageSource.gallery);

      if (selectedFile != null) {
         aspectRatio!.value = await getImageAspectRatio(selectedFile!.path);
        // Navigate to the ImagePickerScreen if a file is selected
        Get.to(() => const Imagepickerscreen());
      }
    }
  }

  Future<double> getImageAspectRatio(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frameInfo = await codec.getNextFrame();
    final image = frameInfo.image;
    return image.width / image.height; // Aspect ratio = width / height
  }

  RxString removedbgpath = ''.obs;


  Future<bool> Removedbackground() async {
    try {
      // HttpOverrides.global = MyHttpOverrides(); // Only for development
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://api2.pixelcut.app/image/matte/v1'),
      );
      request.fields.addAll({
        'format': 'png',
        'model': 'v1',
      });
      request.files.add(await http.MultipartFile.fromPath('image', selectedFile!.path));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
          Uint8List imageBytes = await response.stream.toBytes();
          final directory = await getTemporaryDirectory();

          final filepath = '${directory.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
          final file = File(filepath);
          await file.writeAsBytes(imageBytes);

          print(filepath);
          removedbgpath.value = filepath;
        // Save or use the `imageBytes`
        return true;
      } else {
        print('Failed to remove background: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error while removing background: $e');
      appToast("Error removing background");
      return true;
    }
  }


}