import 'package:bhargav_kumar_murala/Provider/Services/api_service.dart';
import 'package:bhargav_kumar_murala/Model/movie_model.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Search>? _search;
  List<Search>? get search => _search;
  void fetchMovie(String name) async {
    _isLoading = true;
    _search = await ApiService.getInstance.searchMovie(name);
    _isLoading = false;

    notifyListeners();
  }
}
