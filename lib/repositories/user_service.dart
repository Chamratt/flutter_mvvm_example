import 'dart:io';

import 'package:flutter_mvvm_example/models/user.dart';
import 'package:flutter_mvvm_example/repositories/api_status.dart';
import 'package:flutter_mvvm_example/utils/constant.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<Object> getUsers() async {
    try {
      var url = Uri.parse(USER_LIST);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        return Success(response: welcomeFromJson(response.body));
      }
      return Failure(code: USER_INVALID, response: "invalid user");
    } on HttpException {
      return Failure(code: NO_INTERNET, response: "no internet connection");
    } on FormatException {
      return Failure(code: INVALID_FORMAT, response: "invalid format");
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, response: "unknown error");
    }
  }
}
