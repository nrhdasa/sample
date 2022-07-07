import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sample/Resources/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static String website = "https://hkmjerp.in";
  final dio = Dio();

  login(username, password, context) async {
    // dio.interceptors.add(CookieManager(await getCookieJar()));
    try {
      final response = await dio.post(
          '$website/api/method/hkm.auth.login.login',
          data: {'usr': username, 'pwd': password});
      await setGlobalAuthState(response.data['message']);
      Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
    } on DioError catch (e) {
      if (e.response != null) {
        errorHandling(context, e.response);
      } else {
        snackBarError(context, e.message);
      }
    }
  }

  static logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // String appDocPath = appDocDir.path;
    // var cookieJar =
    //     PersistCookieJar(storage: FileStorage("$appDocPath/.cookies/"));
    // cookieJar.deleteAll();
  }

  static Future<String> isLoggedIn() async {
    // var cookieJar = await getCookieJar();
    // var cookies = await cookieJar.loadForRequest(Uri.parse(website));
    // var cookie = CookieManager.getCookies(cookies);
    // ;
    // return cookie;
    return "";
  }

  // static Future<CookieJar> getCookieJar() async {
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   String appDocPath = appDocDir.path;
  //   var cookieJar =
  //       PersistCookieJar(storage: FileStorage("$appDocPath/.cookies/"));
  //   return cookieJar;
  // }

  setGlobalAuthState(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // response.data["username"] =
    //     response.headers.map["set-cookie"]![3].split(';')[0].split('=')[1];

    // //Set Email ID
    // await prefs.setString("username", response.data["username"]);
    // //Set Full Name
    // await prefs.setString("full_name", response.data['full_name']);
    await prefs.setString("username", data["email"]);
    await prefs.setString("full_name", data["full_name"]);
    await prefs.setString("token", data["token"]);
  }

  static Future<Dio> addHeadersToDioCalls(Dio dio) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dio.options.headers['Authorization'] = prefs.getString("token");
    dio.options.headers['content-Type'] = 'application/json';
    return dio;
  }
}
