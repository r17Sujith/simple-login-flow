import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wingman/api/api_end_points.dart';
import 'package:wingman/api/dio_http_client.dart';
import 'package:wingman/cutom_views/dialogs.dart';
import 'package:wingman/model/login_response.dart';
import 'package:wingman/model/verify_otp_response.dart';
import 'package:wingman/utils/shared_preference.dart';
import 'package:wingman/utils/utility_methods.dart';
import 'package:wingman/utils/validation_util.dart';

class LoginService {
  Future<String> login(String number, BuildContext context) async {
    LoadingDialog.show(context);
    LoginResponse loginResponse;
    DioHttpClient httpClient = DioHttpClient(false);
    String? validationMsg = ValidationUtil.validateMobile(number);
    if (validationMsg == null) {
      Map<String, String> body = {};
      body.putIfAbsent("mobile", () => number);
      final response = await httpClient.postRequest(ApiEndPoints.sendOtp, body);
      LoadingDialog.hide(context);
      loginResponse = LoginResponse.fromJson(jsonDecode(response.data));
      if (loginResponse.status!) {
        return loginResponse.requestId!;
      } else {
        if (kDebugMode) {
          print("Something went wrong ${loginResponse.response}");
        }
        throw Exception('Some arbitrary error');
      }
    } else {
      LoadingDialog.hide(context);
      UtilityMethods.createFlutterToast(validationMsg);
      throw Exception('Some arbitrary error');
    }
  }

  Future<bool> verifyOtp(String number, String otp, BuildContext context) async {
    LoadingDialog.show(context);
    VerifyOtpResponse otpResponse;
    DioHttpClient httpClient = DioHttpClient(false);
    Map<String, String> body = {};
    body.putIfAbsent("request_id", () => number);
    body.putIfAbsent("code", () => otp);
    final response = await httpClient.postRequest(ApiEndPoints.verifyOtp, body);
    LoadingDialog.hide(context);
    otpResponse = VerifyOtpResponse.fromJson(jsonDecode(response.data));
    if (otpResponse.status!) {
      sharedPrefs.token = otpResponse.jwt;
      return otpResponse.profileExists!;
    } else {
      if (kDebugMode) {
        print("Something went wrong");
      }
      throw Exception('Some arbitrary error');
    }
  }

  Future<bool> submitProfile(String name, String email, BuildContext context) async {
    LoadingDialog.show(context);
    String? validationMsg = ValidationUtil.validateNameAndEmail(name, email);
    if (validationMsg == null) {
      DioHttpClient httpClient = DioHttpClient(false);
      Map<String, String> body = {};
      body.putIfAbsent("name", () => name);
      body.putIfAbsent("email", () => email);
      final response = await httpClient.postRequest(ApiEndPoints.profileSubmit, body);
      LoadingDialog.hide(context);
      if (response.statusCode == 200) {
        return true;
      } else {
        if (kDebugMode) {
          print("Something went wrong");
        }
        throw Exception('Some arbitrary error');
      }
    } else {
      LoadingDialog.hide(context);
      UtilityMethods.createFlutterToast(validationMsg);
      throw Exception('Some arbitrary error');
    }
  }
}