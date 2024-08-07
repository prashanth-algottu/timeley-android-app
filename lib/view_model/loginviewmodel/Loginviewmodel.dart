import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../repository/auth_repository.dart';
import '../../utils/apputil.dart';
import '../../utils/routes/routes_name.dart';

class Loginviewmodel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> registration(
    dynamic data,
    BuildContext context,
  ) async {
    print("1. registration starting");
    setLoading(true);
    _myRepo.registration(data).then((value) {
      print("2. registration starting");
      setLoading(false);
      print("3. registration starting");
      Map<String, dynamic> mapData = jsonDecode(data);
      print("asdfgdwqwsdf" + mapData.length.toString());
      print("dsf");
    });
  }

  Future<void> getFirst(
    BuildContext context,
  ) async {
    print("1. registration starting");
    setLoading(true);
    _myRepo.getFirstUser().then((value) {
      print("2. registration starting : $value");
      setLoading(false);
      print("3. registration starting");
      print("dsf");
    });
  }

  Future<void> loginApi(dynamic data, BuildContext context,
      Function(String token) onLoginPressed) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Map<String, dynamic> mapData = jsonDecode(data);
      var usernamr = mapData['username'];
      Navigator.pushNamed(
        context,
        RoutesName.otp,
        arguments: {'username': usernamr, 'call_back': onLoginPressed},
      );

      print("====================>>>>>  " + value.toString());
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      print("====================>>>>>errorrrr  " + error.toString());
    });
  }

  Future<void> ldapLogin(dynamic data, BuildContext context,
      Function(String token) onLoginPressed) async {
    setLoading(true);
    _myRepo.ldapApi(data).then((value) {
      setLoading(false);
      Map<String, dynamic> mapData = jsonDecode(data);
      print("object");
      var token = value['data']['token'];
      onLoginPressed(token);
      print("====================>>>>>  " + value.toString());
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
      print("====================>>>>>errorrrr  " + error.toString());
    });
  }

  Future<String?> validateOtp(dynamic data, BuildContext context) async {
    try {
      setLoading(true);
      var value = await _myRepo.otpValidation(data);
      var token = value['data']['token'];
      print("====================>>>>>  ");
      if (token != null) {
        setLoading(false);
        return token;
      } else {
        setLoading(false);
        Utils.flushBarErrorMessage("Error in getting otp.", context);
      }
    } catch (e) {
      setLoading(false);
      Utils.flushBarErrorMessage(e.toString(), context);
      return "";
    }
  }

  Future<String?> googlesigin(dynamic data, BuildContext context) async {
    setLoading(true);
    var value = await _myRepo.googleSignin(data);
    dynamic url = value['data'];
    print("object");
    if (url != null) {
      setLoading(false);
      return url;
    } else {
      setLoading(false);
      Utils.flushBarErrorMessage(
          "Error in geting google sign in url ", context);
    }
  }

  Future<String> validateCode(
      dynamic data, Function(String token) onLoginPressed) async {
    setLoading(true);
    var value = await _myRepo.validateCode(data);
    String token = value['data']['token'];
    if (token != null) {
      setLoading(false);
      return token;
    } else {
      setLoading(false);
      Utils.toastMessage("Error in geting token");
      return "";
    }
    print("object");
  }
}
