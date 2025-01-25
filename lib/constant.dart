import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const appName = 'Logo Maker';
const keyName = '';
const appFontFamily = 'LilitaOne';
const rateID = '';
const privacyPolicyUrl = 'https://jakprem9.blogspot.com/2025/01/privacy-policy.html';
const termsOfUseUrl = 'https://jakprem9.blogspot.com/2025/01/terms-and-conditions.html';

const appColor = Color(0xff4F98FE);
const textColor = Colors.white;
const appbackgroundColor = Color(0xff000000);
const pressColor = Color(0xff8359DE);
const unPressColor = Color(0xffF78246);
const dialogBgColor = Color(0xFF181818);
const dialogButtonTextColor = Color(0xFF000000);
const nextPress = Color(0xFF000000);

const iosIndicator = Center(child: CupertinoActivityIndicator(radius: 15,color: appColor,));

appToast(String msg) => Fluttertoast.showToast(msg: msg,backgroundColor: unPressColor,textColor: Colors.black);


