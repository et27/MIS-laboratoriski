import 'package:flutter/foundation.dart';

/// Глобален менаџер за омилени рецепти
class FavoritesManager extends ChangeNotifier {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final Set<String> _favoriteIds = {};

  bool isFavorite(String mealId) {
    return _favoriteIds.contains(mealId);
  }

  void addFavorite(String mealId) {
    if (_favoriteIds.add(mealId)) {
      notifyListeners();
    }
  }

  void removeFavorite(String mealId) {
    if (_favoriteIds.remove(mealId)) {
      notifyListeners();
    }
  }

  void toggleFavorite(String mealId) {
    if (_favoriteIds.contains(mealId)) {
      removeFavorite(mealId);
    } else {
      addFavorite(mealId);
    }
  }

  List<String> get favoriteIds => _favoriteIds.toList();

  int get count => _favoriteIds.length;

  void clear() {
    if (_favoriteIds.isNotEmpty) {
      _favoriteIds.clear();
      notifyListeners();
    }
  }
}