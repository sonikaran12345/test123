import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logomaker/constant.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPermissionHandler {
  static Future<bool> checkPermission(BuildContext context,String permissionName) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      if (sdkInt < 33 && permissionName == 'gallery') {
        final statues = await [Permission.storage].request();
        PermissionStatus? statusPhotos = statues[Permission.storage];
        if (statusPhotos == PermissionStatus.granted) {
          return true;
        } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
          Fluttertoast.showToast(msg: 'permanentlyDenied',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
          //showPermissionDialog(context, permissionName);
          return false;
        } else if (statusPhotos == PermissionStatus.limited) {
          Fluttertoast.showToast(msg: 'limited',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
          //showLimitedPermissionDialog(context, permissionName);
          return false;
        } else {
          return false;
        }
      }
      if (sdkInt < 33 && permissionName == 'audio' ) {
        final statues = await [Permission.storage].request();
        PermissionStatus? statusPhotos = statues[Permission.storage];
        if (statusPhotos == PermissionStatus.granted) {
          return true;
        } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
          Fluttertoast.showToast(msg: 'permanentlyDenied',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
          //showPermissionDialog(context, permissionName);
          return false;
        } else if (statusPhotos == PermissionStatus.limited) {
          Fluttertoast.showToast(msg: 'limited',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
          //showLimitedPermissionDialog(context, permissionName);
          return false;
        } else {
          return false;
        }
      }
    }
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues;
    switch (permissionName) {
      case 'camera':
        {
          statues = await [Permission.camera].request();
          PermissionStatus? statusCamera = statues[Permission.camera];
          if (statusCamera == PermissionStatus.granted) {
            return true;
          } else if (statusCamera == PermissionStatus.permanentlyDenied) {
            Fluttertoast.showToast(msg: 'permanentlyDenied',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showPermissionDialog(context, permissionName);
            return false;
          } else {
            return false;
          }
        }
      case 'gallery':
        {
          statues = await [Permission.photos].request();
          PermissionStatus? statusPhotos = statues[Permission.photos];
          if (statusPhotos == PermissionStatus.granted) {
            return true;
          } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
            Fluttertoast.showToast(msg: 'permanentlyDenied',backgroundColor: appColor,textColor: textColor);
            //showPermissionDialog(context, permissionName);
            return false;
          } else if (statusPhotos == PermissionStatus.limited) {
            // Fluttertoast.showToast(msg: 'limited',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showLimitedPermissionDialog(context, permissionName);
            return true;
          } else {
            return false;
          }
        }
        case 'audio':
        {
          statues = await [Permission.audio].request();
          PermissionStatus? statusPhotos = statues[Permission.audio];
          if (statusPhotos == PermissionStatus.granted) {
            return true;
          } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
            Fluttertoast.showToast(msg: 'permanentlyDenied',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showPermissionDialog(context, permissionName);
            return false;
          } else if (statusPhotos == PermissionStatus.limited) {
            Fluttertoast.showToast(msg: 'limited',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showLimitedPermissionDialog(context, permissionName);
            return false;
          } else {
            return false;
          }
        }
        case 'microphone':
        {
          statues = await [Permission.microphone].request();
          PermissionStatus? statusPhotos = statues[Permission.microphone];
          if (statusPhotos == PermissionStatus.granted) {
            return true;
          } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
            Fluttertoast.showToast(msg: 'permanentlyDenied',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showPermissionDialog(context, permissionName);
            return false;
          } else if (statusPhotos == PermissionStatus.limited) {
            Fluttertoast.showToast(msg: 'limited',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showLimitedPermissionDialog(context, permissionName);
            return false;
          } else {
            return false;
          }
        }
        case 'video':
        {
          statues = await [Permission.videos].request();
          PermissionStatus? statusPhotos = statues[Permission.videos];
          if (statusPhotos == PermissionStatus.granted) {
            return true;
          } else if (statusPhotos == PermissionStatus.permanentlyDenied) {
            Fluttertoast.showToast(msg: 'permanentlyDenied',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showPermissionDialog(context, permissionName);
            return false;
          } else if (statusPhotos == PermissionStatus.limited) {
            Fluttertoast.showToast(msg: 'limited',backgroundColor: const Color(0xff00cbe7),textColor: const Color(0xffffffff));
            //showLimitedPermissionDialog(context, permissionName);
            return false;
          } else {
            return false;
          }
        }
    }
    return false;
  }


  static void showpermissiondialog(BuildContext context, String item) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            content: Text('Allow access to $item in the Setting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text(
                  'Setting',
                  style: TextStyle(
                    color: nextPress,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            content: Text('Allow access to $item in the Setting.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  openAppSettings();
                },
                child: const Text(
                  'Setting',
                  style: TextStyle(
                    color: nextPress,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }
}