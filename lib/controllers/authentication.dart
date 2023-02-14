import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:social_media_app/constants/constants.dart';
import 'package:social_media_app/route/app_route.dart';
import 'package:social_media_app/views/colors/color.dart';
import 'package:social_media_app/views/home.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = ''.obs;
  final box = GetStorage();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  Future register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      if (formstate.currentState!.validate()) {
        isLoading.value = true;
        var data = {
          'name': name,
          'username': username,
          'email': email,
          'password': password,
        };

        var response = await http.post(
          Uri.parse('${url}register'),
          headers: {
            'Accept': 'application/json',
          },
          body: data,
        );

        if (response.statusCode == 201) {
          isLoading.value = false;
          token.value = json.decode(response.body)['token'];
          box.write('token', token.value);
          Get.snackbar(
            'Success',
            'Register Successfully!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColor.green,
            colorText: AppColor.white,
          );
          return json.decode(response.body);
        } else {
          isLoading.value = false;
          Get.snackbar(
            'Error',
            json.decode(response.body)['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColor.red,
            colorText: AppColor.white,
          );
          print(json.decode(response.body));
        }
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.red,
        colorText: AppColor.white,
      );
    }
  }

  Future login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      var data = {
        'email': email,
        'password': password,
      };
      var response = await http.post(
        Uri.parse('${url}login'),
        headers: {
          'Accept': 'application/json',
        },
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        token.value = json.decode(response.body)['token'];
        box.write('token', token.value);
        Get.snackbar(
          'Success',
          'Login Successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.green,
          colorText: AppColor.white,
        );
        Get.offNamed(AppRoute.home);
        return json.decode(response.body);
      } else {
        isLoading.value = false;
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.red,
          colorText: AppColor.white,
        );
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.red,
        colorText: AppColor.white,
      );
    }
  }
}
