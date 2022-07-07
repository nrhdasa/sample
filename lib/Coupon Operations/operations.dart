import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Connection/auth.dart';
import '../Resources/common.dart';

Future<Map<String, dynamic>> createRequest(
    BuildContext context, Map<String, dynamic> formData) async {
  var data = {
    "type": "Request",
    "date": formData['date'],
    "slot": formData['slot'],
    "number": int.parse(formData['number']),
    "coupon_type": formData['coupon_type'],
    "docstatus": 1
  };
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio
        .post('${Auth.website}/api/resource/Prasadam CPN Request', data: data);
    print(response.data);
    await Navigator.pushNamed(context, "success");
  } on DioError catch (e) {
    if (e.response != null) {
      errorHandling(context, e.response);
    } else {
      snackBarError(context, e.message);
    }
  }
  return {};
}

Future<Map<String, dynamic>> createRelease(
    BuildContext context, Map<String, dynamic> formData) async {
  var data = {
    "type": "Release",
    "date": formData['date'],
    "slot": formData['slot'],
    "number": int.parse(formData['number']),
    "coupon_type": formData['coupon_type'],
    "docstatus": 1
  };
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio
        .post('${Auth.website}/api/resource/Prasadam CPN Request', data: data);
    print(response.data);
    await Navigator.pushNamed(context, "success");
  } on DioError catch (e) {
    if (e.response != null) {
      errorHandling(context, e.response);
    } else {
      snackBarError(context, e.message);
    }
  }
  return {};
}

Future<List<dynamic>> getPrasadamCPNUsers(BuildContext context) async {
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio.get(
        '${Auth.website}/api/method/hkm.prasadam_coupon_management.api.fetch_request_users');
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

Future<Map<String, dynamic>> createTransfer(
    BuildContext context, Map<String, dynamic> formData) async {
  var data = {
    "type": "Transfer",
    "transfer_to": formData['transfer_to'],
    "date": formData['date'],
    "slot": formData['slot'],
    "number": int.parse(formData['number']),
    "coupon_type": formData['coupon_type'],
    "docstatus": 1
  };
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio
        .post('${Auth.website}/api/resource/Prasadam CPN Request', data: data);
    print(response.data);
    await Navigator.pushNamed(context, "success");
  } on DioError catch (e) {
    if (e.response != null) {
      errorHandling(context, e.response);
    } else {
      snackBarError(context, e.message);
    }
  }
  return {};
}

Future<Map<String, dynamic>> generateQR(
    BuildContext context, Map<String, dynamic> formData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var data = {
    "date": formData['date'],
    "slot": formData['slot'],
    "docstatus": 1,
    "number": int.parse(formData['number']),
    "coupon_type": formData['coupon_type'],
    "authority": Uri.decodeFull(prefs.getString("username") ?? "NULL")
  };
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio
        .post('${Auth.website}/api/resource/Prasadam Coupon', data: data);
    print(response.data);
    print(response.data['name']);
    await Navigator.pushNamed(context, "coupon/qr",
        arguments: {'name': response.data['data']['name']});
  } on DioError catch (e) {
    if (e.response != null) {
      errorHandling(context, e.response);
    } else {
      snackBarError(context, e.message);
    }
  }
  return {};
}

Future<Map<String, dynamic>> getCouponQR(
    BuildContext context, String couponName) async {
  try {
    final Dio dio = Dio();
    dio.interceptors.add(CookieManager(await Auth.getCookieJar()));
    final response = await dio
        .get('${Auth.website}/api/resource/Prasadam Coupon/$couponName');
    print(response.data);
    return response.data['data'];
    //await Navigator.pushNamed(context, "success");
  } on DioError catch (e) {
    if (e.response != null) {
      errorHandling(context, e.response);
    } else {
      snackBarError(context, e.message);
    }
  }
  return {};
}
