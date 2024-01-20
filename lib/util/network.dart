import '../type/categories.dart';
import 'preference.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  static login() async {
    var api = Preference.getString(Preference.API) ?? '';
    var user = Preference.getString(Preference.USER) ?? '';
    var pass = Preference.getString(Preference.PASS) ?? '';
    var respsone = await http.post(Uri.parse(api),
        body: jsonEncode(<String, String>{
          "op": "login",
          "user": user,
          "password": pass,
        }));
    return Categories.fromJson(jsonDecode(respsone.body)).content;
  }

  static Future<List<Category>> getCategories() async {
    var api = Preference.getString(Preference.API) ?? '';
    var sid = Preference.getString(Preference.SID) ?? '';
    var respsone = await http.post(Uri.parse(api),
        body: jsonEncode(<String, String>{
          "op": "getCategories",
          "sid": sid,
        }));

    var list = validRes(respsone.body);
    List<Category> categoryList =
        list.map((i) => Category.fromJson(i)).toList();
    return categoryList;
  }

  static List<dynamic> validRes(String body) {
    var json = jsonDecode(body);
    if (json['content'] is List) {
      return json['content'];
    }
    print('content null > $body');

    return [];
  }
}
