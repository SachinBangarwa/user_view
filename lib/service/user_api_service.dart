import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_view/core/app_strings.dart';
import 'package:user_view/model/user_detail_model.dart';

class UserApiService {
  Future<List<UserDetailModel>> fetchUsers() async {
    String url = AppStrings.userUrl;
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        AppStrings.apiKey: AppStrings.apiKeyValue,
        AppStrings.contentType: AppStrings.contentTypeValue,
      },
    );

    if (response.statusCode == 200) {
      String jsonData = response.body;
      Map<String, dynamic> json = jsonDecode(jsonData);
      List<UserDetailModel> userList = [];
      for (int i = 0; i < json['data'].length; i++) {
        UserDetailModel user = UserDetailModel.fromJson(json['data'][i]);
        userList.add(user);
      }

      return userList;
    } else {
      throw AppStrings.errorMessage;
    }
  }
}
