import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

snackBarError(BuildContext context, String message) {
  SnackBar snackBar = SnackBar(
    content: Text(
      message,
      style:
          TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
    ),
    backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

bool isNumeric(String string) {
  if (string.isEmpty) {
    return false;
  }
  final number = num.tryParse(string);
  if (number == null) {
    return false;
  }
  return true;
}

errorHandling(BuildContext context, Response<dynamic>? response) {
  if (response != null) {
    print(response.data);
    print(response.statusCode);
    if (response.statusCode == 417) {
      snackBarError(context, getException(response.data['exception']));
    }
    if (response.statusCode == 500) {
      snackBarError(context, "Server Error! Please contact Administrator.");
    }

    if (response.statusCode == 401) {
      snackBarError(context, "Authentication Error! Session may be expired.");
    }
    // else if(response.statusCode == )
  }
}

String getException(String exception) {
  String result =
      exception.substring(exception.indexOf(':') + 1, exception.length);
  String replaced = result
      .replaceAll(RegExp('<b>'), '')
      .replaceAll(RegExp('</b>'), '')
      .replaceAll(RegExp('<br>'), '');
  return replaced;
}

String getDateinFormat(String date, String format) {
  DateTime dateformatted = DateTime.parse(date);
  final DateFormat formatter = DateFormat(format);
  final String formatted = formatter.format(dateformatted);
  return formatted;
}
