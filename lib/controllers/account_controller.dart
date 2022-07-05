
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:market/views/screens/auth/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Assistants/globals.dart';
import '../Data/current_data.dart';
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

  Future<void> changePassword(String currentPass, newPass, reNewPass) async {
    var headers = {
      'Authorization': 'Bearer ${user.accessToken}',
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('$baseURL/api/EditePassword'));
    request.body = json.encode({
      "OldPassword": currentPass,
      "Password": newPass,
      "rePassword": reNewPass
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      signOut();
      Get.snackbar('Password Changed', 'change password done',snackPosition: SnackPosition.BOTTOM,colorText: Colors.white,backgroundColor: myHexColor);
      Get.offAll(Register());
    }
    else {
      print(response.reasonPhrase);
    }


  }


}