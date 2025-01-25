import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  static final SharedPreferencesService _instance = SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  static Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();

  static Future<List<String>> getPendingVideoUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('pk') ?? [];
  }

  static Future<void> savePendingVideoUrl(String videoUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> videoList = prefs.getStringList('pk') ?? [];
    videoList.add(videoUrl);
    await prefs.setStringList('pk', videoList);
  }

  static Future<void> removePendingVideoUrl(String videoUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> videoList = prefs.getStringList('pk') ?? [];
    videoList.remove(videoUrl);
    await prefs.setStringList('pk', videoList);
  }

  static Future<void> clearPendingVideos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('pk');
  }

  static Future<String> getTipsScreen(String name) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(name) ?? '';
  }

  static Future<void> setTipsScreen(String name) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(name, name);
  }

  static Future<String> getUser() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('username') ?? '';
  }

  static Future<void> setUser(String name) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('username', name);
  }


  static Future<String> getTips() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('tips') ?? '';
  }

  static Future<void> setTips(String name) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('tips', name);
  }


  static Future<int> getIntValue() async {
    final SharedPreferences prefs = await _prefs;
    final int storedValue = prefs.getInt('intValue') ?? 0;
    final int timestamp = prefs.getInt('intValueTimestamp') ?? 0;

    if (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timestamp)).inHours > 24) {
      await prefs.remove('intValue');
      await prefs.remove('intValueTimestamp');
      return 0;
    }

    return storedValue;
  }

  static Future<void> setIntValue(int value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt('intValue', value);
    await prefs.setInt('intValueTimestamp', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<int> getCreditValue(String coinvalueName) async {
    final SharedPreferences prefs = await _prefs;
    final int storedValue = prefs.getInt(coinvalueName) ?? 0;
    return storedValue;
  }

  static Future<void> setCreditValue(int coinvalue,String coinvalueName) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setInt(coinvalueName, coinvalue);
  }

  static Future<String> gettaskID() async {
    final SharedPreferences prefs = await _prefs;
    final String storedValue = prefs.getString('taskID') ?? '';
    return storedValue;
  }

  static Future<void> setaskID(String taskID) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('taskID', taskID);
  }

  static Future<void> removeTaskID() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('taskID');
  }



  static Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    final String storedValue = prefs.getString('token') ?? '11';
    return storedValue;
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('token', token);
  }
  

}
