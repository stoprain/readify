import 'package:flutter/material.dart';
import 'package:readify/type/article.dart';
import 'package:readify/type/session.dart';
import 'package:readify/util/globals.dart';

import '../type/category.dart';
import 'preference.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

enum Op { login, getCategories, getArticle, updateArticle }

class Network {
  static login() async {
    final res = buildRequest(Op.login);
    if (res == null) return;
    var respsone = await http.post(Uri.parse(res.$1), body: res.$2);
    //TODO error handle
    var json = jsonDecode(respsone.body);
    var session = Session.fromJson(json['content']);
    Preference.setString(Preference.SID, session.session_id);
  }

  static Future<List<Category>> getCategories() async {
    final res = buildRequest(Op.getCategories);
    if (res == null) return [];
    var respsone = await http.post(Uri.parse(res.$1), body: res.$2);
    var list = validRes(respsone.body) as List<dynamic>;
    List<Category> categoryList =
        list.map((i) => Category.fromJson(i)).toList();
    return categoryList;
  }

  static Future<Article?> getArticle(int articleId) async {
    final res = buildRequest(Op.getArticle, {"article_id": articleId});
    if (res == null) return null;
    var respsone = await http.post(Uri.parse(res.$1), body: res.$2);
    var json = validRes(respsone.body) as List<dynamic>;
    return Article.fromJson(json[0]);
  }

  static updateArticle(int articleId) async {
    final res = buildRequest(Op.updateArticle, {
      "mode": 0,
      "field": 2,
      "article_ids": articleId,
    });
    if (res == null) return null;
    var respsone = await http.post(Uri.parse(res.$1), body: res.$2);
    print(respsone.body);
  }

  static String getIco(int feedId) {
    var api = Preference.getString(Preference.API) ?? '';
    var result = api.replaceAll('api/', 'public.php?op=feed_icon&id=$feedId');
    return result;
  }

  static dynamic validRes(String body) {
    var json = jsonDecode(body);
    if (json['content'] is List) {
      return json['content'];
    }
    GloabalSnackBar.show(body);

    return [];
  }

  static (String, String)? buildRequest(Op op,
      [Map<String, dynamic> params = const {}]) {
    final api = Preference.getString(Preference.API) ?? '';
    if (api.isEmpty) {
      GloabalSnackBar.show('missing api');
      return null;
    }
    if (op == Op.login) {
      final user = Preference.getString(Preference.USER) ?? '';
      final pass = Preference.getString(Preference.PASS) ?? '';
      if (user.isEmpty || pass.isEmpty) {
        GloabalSnackBar.show('missing user or pass');
        return null;
      }
      return (
        api,
        jsonEncode(<String, String>{
          "op": op.name,
          "user": user,
          "password": pass,
        })
      );
    }

    final sid = Preference.getString(Preference.SID) ?? '';
    if (sid.isEmpty) {
      GloabalSnackBar.show('missing sid');
      return null;
    }

    return (
      api,
      jsonEncode(<String, dynamic>{
        "op": op.name,
        "sid": sid,
      }..addAll(params))
    );
  }
}
