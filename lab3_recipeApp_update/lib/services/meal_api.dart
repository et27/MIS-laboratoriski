import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';
import '../models/meal_detail.dart';

class MealApi {
  static const _base = 'https://www.themealdb.com/api/json/v1/1/';

  static Future<List<Category>> fetchCategories() async {
    final res = await http.get(Uri.parse('${_base}categories.php'));
    if (res.statusCode != 200) throw Exception('Failed to load categories');
    final data = json.decode(res.body);
    if (data['categories'] == null) return [];
    return (data['categories'] as List).map((e) => Category.fromJson(e)).toList();
  }

  static Future<List<Meal>> fetchMealsByCategory(String category) async {
    final res = await http.get(Uri.parse('${_base}filter.php?c=${Uri.encodeComponent(category)}'));
    if (res.statusCode != 200) throw Exception('Failed to load meals');
    final data = json.decode(res.body);
    if (data['meals'] == null) return [];
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final res = await http.get(Uri.parse('${_base}search.php?s=${Uri.encodeComponent(query)}'));
    if (res.statusCode != 200) throw Exception('Search failed');
    final data = json.decode(res.body);
    if (data['meals'] == null) return [];
    return (data['meals'] as List).map((e) => Meal.fromJson(e)).toList();
  }

  static Future<MealDetail?> fetchMealDetail(String id) async {
    final res = await http.get(Uri.parse('${_base}lookup.php?i=${Uri.encodeComponent(id)}'));
    if (res.statusCode != 200) throw Exception('Lookup failed');
    final data = json.decode(res.body);
    if (data['meals'] == null) return null;
    return MealDetail.fromJson(data['meals'][0]);
  }

  static Future<MealDetail?> fetchRandomMeal() async {
    final res = await http.get(Uri.parse('${_base}random.php'));
    if (res.statusCode != 200) throw Exception('Random failed');
    final data = json.decode(res.body);
    if (data['meals'] == null) return null;
    return MealDetail.fromJson(data['meals'][0]);
  }
}
