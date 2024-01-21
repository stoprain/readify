import 'package:flutter/material.dart';
import 'package:readify/type/article.dart';
import 'package:readify/type/session.dart';
import 'package:readify/util/globals.dart';

import '../type/category.dart';
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
    var json = jsonDecode(respsone.body);
    var session = Session.fromJson(json['content']);
    Preference.setString(Preference.SID, session.session_id);
  }

  static Future<List<Category>> getCategories() async {
    var api = Preference.getString(Preference.API) ?? '';
    var sid = Preference.getString(Preference.SID) ?? '';
    var respsone = await http.post(Uri.parse(api),
        body: jsonEncode(<String, String>{
          "op": "getCategories",
          "sid": sid,
        }));

    var list = validRes(respsone.body) as List<dynamic>;
    List<Category> categoryList =
        list.map((i) => Category.fromJson(i)).toList();
    return categoryList;
  }

  static Future<Article> getArticle(int articleId) async {
    var api = Preference.getString(Preference.API) ?? '';
    var sid = Preference.getString(Preference.SID) ?? '';
    var respsone = await http.post(Uri.parse(api),
        body: jsonEncode(<String, dynamic>{
          "sid": sid,
          "op": "getArticle",
          "article_id": articleId
        }));
    var json = validRes(respsone.body) as List<dynamic>;
    return Article.fromJson(json[0]);
  }

  static updateArticle(int articleId) async {
    var api = Preference.getString(Preference.API) ?? '';
    var sid = Preference.getString(Preference.SID) ?? '';
    var respsone = await http.post(Uri.parse(api),
        body: jsonEncode(<String, dynamic>{
          "op": "updateArticle",
          "sid": sid,
          "mode": 0,
          "field": 2,
          "article_ids": articleId,
        }));
    print(respsone.body);
  }

  static dynamic validRes(String body) {
    var json = jsonDecode(body);
    if (json['content'] is List) {
      return json['content'];
    }
    GloabalSnackBar.show(body);

    return [];
  }
}
