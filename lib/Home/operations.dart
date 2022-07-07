import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Connection/auth.dart';
import '../Resources/common.dart';

Future<String?> getFullName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("full_name");
}

Future<Map<String, dynamic>> getDashboardData(BuildContext context) async {
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio.get(
        '${Auth.website}/api/method/hkm.prasadam_coupon_management.api.get_dashboard_data');
    return response.data;
  } on DioError catch (e) {
    if (e.response != null) {
      snackBarError(context, e.response!.data['message']);
    } else {
      snackBarError(context, e.message);
    }
  }
  return {};
}
