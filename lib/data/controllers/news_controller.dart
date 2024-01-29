import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:racing/data/new_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _newsKey = '_newsKey';

class NewsController extends ChangeNotifier {
  NewsController(this._bd) {
    init();
  }
  final SharedPreferences _bd;

  final List<NewModel> _news = [];

  List<NewModel> get allNews => _news;
  List<NewModel> get favoriteNews =>
      _news.where((element) => element.isFavorite).toList();

  void init() {
    final cachedNews = _bd.getString(_newsKey) ?? '';
    if (cachedNews.isEmpty) {
      _news.addAll(news);
      notifyListeners();
      return;
    }

    final decodedNews = jsonDecode(cachedNews) as List<dynamic>;
    final listNews = decodedNews.map((e) => NewModel.fromJson(e)).toList();
    _news.addAll(listNews);
    notifyListeners();
  }

  void likeNewModel(NewModel newModel) {
    final index = _news.indexOf(newModel);

    final newNewModel = newModel.copyWith(isFavorite: !newModel.isFavorite);

    _news.removeAt(index);
    _news.insert(index, newNewModel);
    _cacheNews();
    notifyListeners();
  }

  Future<void> _cacheNews() async {
    final encodedNews = jsonEncode(_news.map((e) => e.toJson()).toList());
    await _bd.setString(_newsKey, encodedNews);
  }
}
