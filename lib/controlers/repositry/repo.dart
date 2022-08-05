import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:new_pagination/controlers/app_contolers.dart';
import 'package:new_pagination/models/model.dart';

class ApiRepo {
  static Future<AppModel?> getApi(int values) async {
    try {
      String url = 'https://dummyjson.com/users?page=$values&limit=10';
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var model = AppModel.fromJson(data);
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
