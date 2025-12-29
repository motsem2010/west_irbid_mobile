import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:west_irbid_mobile/models/user_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/services_utils/supa_api.dart';

class AuthController {
  static var _supabaseInstance = Supabase.instance.client;
  User? get user => _supabaseInstance.auth.currentUser;

  static Future<User?> signIn(String email, String password) async {
    try {
      final response = await SupaApi.supaInstCLient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // Login successful, return the user
      final user = response.user;
      return user;
    } catch (error) {
      print('Error during login: $error');
      return null;
    }
  }

  Future<bool> signUp(UserModel user, String password) async {
    // <UserModel? addedUser;
    bool isAdded = false;
    try {
      if (ConstantsData.deviceInfo == null)
        try {
          ConstantsData.deviceInfo = await DeviceInfoPlugin().windowsInfo;
        } catch (e) {
          debugPrint(e.toString());
        }
      final response = await _supabaseInstance.auth.signUp(
        password: password,
        email: user.userEmail,
      );
      if (response.session != null) {
        isAdded = true;
        // await _supabaseInstance.from('user_pc_auth').insert(user.toJson());
        // Get.offAll(() => const Wrapper());
      }
    } on AuthException catch (error) {
      print('Error during signup auth: $error');
    } catch (error) {
      print('Error during signup: $error');
    }
    return isAdded;
  }

  Future logOut(String name, String email, String password) async {
    try {
      final response = await _supabaseInstance.auth.signUp(
        password: password,
        email: email,
      );
      if (response.session != null) {
        await _supabaseInstance.from('Users').insert({
          'Name': name,
          'Email': email,
          'Uid': response.session?.user.id,
          'favoritesList': [],
          'cartList': [],
        });
        // Get.offAll(() => const Wrapper());
      }
    } on AuthException catch (error) {
      print('Error during signup auth: $error');
    } catch (error) {
      print('Error during signup: $error');
    }
  }

  Future forgotPassword(String email) async {
    await _supabaseInstance.auth.resetPasswordForEmail(email);
    Get.snackbar(
      "Password reset",
      "Password reset request has been sent to your email successfully.",
    );
  }
}
