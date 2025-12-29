import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:west_irbid_mobile/modules/homeDashboard/home_dashboard_view.dart';
import 'package:west_irbid_mobile/services_utils/supa_auth_api.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class LoginController extends GetxController {
  String? languageText;
  TextEditingController emailController = TextEditingController(
    text: (kDebugMode) ? 'farsakhrasha@gmail.com' : '',
  );
  TextEditingController passwordController = TextEditingController(
    text: (kDebugMode) ? 'r1984' : '',
  );

  final box = GetStorage();

  // Observable for password visibility
  RxBool isPasswordVisible = false.obs;

  // Observable for loading state
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    // Load saved credentials if available
    String email = box.read('email') ?? '';
    String password = box.read('password') ?? '';
    if (email.isNotEmpty && password.isNotEmpty) {
      emailController.text = email;
      passwordController.text = password;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Login method
  Future<void> login() async {
    // Validate inputs
    if (emailController.text.trim().isEmpty) {
      showToast(
        'يرجى إدخال البريد الإلكتروني / اسم المستخدم',
        backgroundColor: Colors.red,
      );
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      showToast('يرجى إدخال كلمة المرور', backgroundColor: Colors.red);
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      // Attempt to sign in
      final user = await AuthController.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        // Save credentials
        await box.write('email', emailController.text.trim());
        await box.write('password', passwordController.text.trim());

        // Show success message
        showToast('تم تسجيل الدخول بنجاح', backgroundColor: Colors.green);

        // Navigate to home dashboard
        Get.offAll(() => const HomeDashboardView());

        debugPrint('Login successful: ${user.email}');
      } else {
        showToast(
          'فشل تسجيل الدخول. يرجى التحقق من البيانات',
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint('Login error: $e');
      showToast('حدث خطأ أثناء تسجيل الدخول', backgroundColor: Colors.red);
    } finally {
      // Stop loading
      isLoading.value = false;
    }
  }

  // Forgot password method
  Future<void> forgotPassword() async {
    if (emailController.text.trim().isEmpty) {
      showToast('يرجى إدخال البريد الإلكتروني', backgroundColor: Colors.red);
      return;
    }

    try {
      isLoading.value = true;
      await AuthController().forgotPassword(emailController.text.trim());
      showToast(
        'تم إرسال رابط إعادة تعيين كلمة المرور',
        backgroundColor: Colors.green,
      );
    } catch (e) {
      debugPrint('Forgot password error: $e');
      showToast(
        'حدث خطأ أثناء إرسال رابط إعادة التعيين',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
