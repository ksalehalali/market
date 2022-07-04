
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Assistants/globals.dart';
import '../views/screens/main_screen.dart';

class AccountController extends GetxController {

  var isLoggedIn = false.obs;
  var username = "".obs;
  var token = "".obs;
  var userEmail = "".obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("uhmmm AccountController");
    fetchUserLoginPreference();
  }


  void signOut() {
    final storage = GetStorage();
    username.value = "";
    token.value = "";
    isLoggedIn.value = false;
    storage.erase();
  }

  Future<void> fetchUserLoginPreference() async {
    final storage = GetStorage();
    print("Fetching storage data...");


    token.value = storage.read('token');
    username.value = storage.read('username');
    userEmail.value = storage.read('userEmail');

    print("ssssssssss ${username.value}");
    print("tokenssss ${token.value}");

    if(token.value != null) {
      print("logggged");
      isLoggedIn.value = true;
    }

  }


}