import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/home/home_page.dart';

class AuthController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  void login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // ✅ Close keyboard to avoid UI issues
      FocusScope.of(Get.context!).unfocus();

      // ✅ Ensure navigation occurs in the next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => HomePage());
      });
    } else {
      Get.snackbar("Login Failed", "Please enter email and password",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void register() {
    if (passwordController.text != retypePasswordController.text) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    print(
        "User Registered: ${firstNameController.text} ${lastNameController.text}, Email: ${emailController.text}");
    Get.back();
  }

  void logout() {
    Get.offAllNamed('/login');
  }
}
