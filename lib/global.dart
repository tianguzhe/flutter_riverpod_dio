import 'package:flutter/material.dart';
import 'package:mmkv/mmkv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/http/http_manager.dart';

class Global {
  static late SharedPreferences _prefs;

  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // init SharedPreferences
    _prefs = await SharedPreferences.getInstance();

    // init mmkv
    final rootDir = await MMKV.initialize();
    debugPrint('MMKV for flutter with rootDir = $rootDir');

    // init dio
    HttpManager().init("https://httpbin.org", interceptors: [
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);
  }

  static SharedPreferences get prefs => _prefs;
}
