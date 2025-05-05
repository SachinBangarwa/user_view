import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:user_view/core/shared_preference_helper.dart';
import 'package:user_view/model/user_detail_model.dart';
import '../core/app_util.dart';
import '../service/user_api_service.dart';
import 'package:user_view/core/app_strings.dart';

class UserProvider extends ChangeNotifier {
  UserProvider(this.userApiService);

  UserApiService userApiService;

  List<UserDetailModel> userList = [];
  List<Map<String, dynamic>> saveUserList = [];

  bool isLoading = false;

  Map<String, bool> selectedUsers = {};

  void toggleUserSelection(String email) {
    selectedUsers[email] = !(selectedUsers[email] ?? false);
    notifyListeners();
  }

  Future saveUser() async {
    try {
      await SharedPreferenceHelper.saveUser(saveUserList);
      notifyListeners();
    } catch (e) {
      AppUtil.showToast(AppStrings.saveUserError);
    }
  }

  Future getUser() async {
    try {
      String? strData = await SharedPreferenceHelper.getUser();
      if (strData != null) {
        saveUserList = List<Map<String, dynamic>>.from(jsonDecode(strData));
        for (var user in saveUserList) {
          selectedUsers[user['email']] = true;
        }
      }
      notifyListeners();
    } catch (e) {
      AppUtil.showToast(AppStrings.getUserError);
    }
  }

  Future fetchUsers() async {
    try {
      isLoading = true;
      notifyListeners();
      userList = await userApiService.fetchUsers();
    } catch (e) {
      AppUtil.showToast(AppStrings.fetchUserError);
    }
    isLoading = false;
    notifyListeners();
  }
}
