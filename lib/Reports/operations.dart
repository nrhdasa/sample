import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';

import '../Connection/auth.dart';
import '../Resources/common.dart';

Future<List<dynamic>> getGeneratedCoupons(
    BuildContext context, DateTime date) async {
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio.get(
        '${Auth.website}/api/method/hkm.prasadam_coupon_management.api.get_coupons_of_user',
        queryParameters: {"date": date});
    return response.data['message'];
    //await Navigator.pushNamed(context, "success");
  } on DioError catch (e) {
    if (e.response != null) {
      errorHandling(context, e.response);
    } else {
      snackBarError(context, e.message);
    }
  }
  return [];
}

Future<List<dynamic>> getUserCoupons(
    BuildContext context, DateTime date, String slot) async {
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio.get(
        '${Auth.website}/api/method/hkm.prasadam_coupon_management.api.get_coupon_stats',
        queryParameters: {"date": date, 'slot': slot});
    print(response.data);
    return response.data['message'];
  } on DioError catch (e) {
    if (e.response != null) {
      errorHandling(context, e.response);
    } else {
      snackBarError(context, e.message);
    }
  }
  return [];
}
