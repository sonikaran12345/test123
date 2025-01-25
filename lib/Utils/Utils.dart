import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{
  static Future<void> showLoadingDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: CupertinoActivityIndicator(color: Colors.white,radius: 20,),
          ),
        );
      },
    );
  }

  static Future<void> saveimageloading(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return  Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 300.h,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child:  Column(
              children: [
                70.verticalSpace,
                const Center(
                  child: CupertinoActivityIndicator(color: Colors.black,radius: 10,),
                ),
                50.verticalSpace,
                const Text("Your Image Save TO Gallery!",style: TextStyle(color: Colors.black),),
                50.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static void statictoast(String toasttext) {
    Fluttertoast.showToast(msg:toasttext );
  }

  static Future<void> SavecloseDialog(BuildContext context, VoidCallback onConfirm) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Confirm Close',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to close this process? This action cannot be undone.',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm(); // Execute the confirmation callback
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> LoadingcloseDialog(BuildContext context, VoidCallback onConfirm) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            'Confirm Close',
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            'Are you sure you want to close this process? This action cannot be undone.',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onConfirm(); // Execute the confirmation callback
              },
            ),
          ],
        );
      },
    );
  }

}