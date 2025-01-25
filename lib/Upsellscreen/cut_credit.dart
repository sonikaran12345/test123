// import 'package:deviceinfo/Setting/sharedPreferencesService.dart';
// import 'package:deviceinfo/services/Sharepreferance.dart';
// import 'creditManager.dart';
//
//
// class CutCredit{
//   static Future<void> cutCredit(int cutcredit) async {
//     var credit = await SharedPreferencesService.getCreditValue('Credit');
//     credit -= cutcredit;
//     SharedPreferencesService.setCreditValue(credit,'Credit');
//     CreditsManager.saveUserCredits(credit);
//   }
//
//   static Future<void> addCredit(int cutcredit) async {
//     var credit = await SharedPreferencesService.getCreditValue('Credit');
//     credit += cutcredit;
//     SharedPreferencesService.setCreditValue(credit,'Credit');
//     CreditsManager.saveUserCredits(credit);
//   }
// }