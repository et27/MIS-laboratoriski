import 'package:flutter/material.dart';
import '../services/meal_api.dart';
import '../models/category.dart';
import '../widgets/category_card.dart';
import '../widgets/search_bar.dart';
import 'meals_screen.dart';
import 'random_meal_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _all = [];
  List<Category> _filtered = [];
  bool _loading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final cats = await MealApi.fetchCategories();
      setState(() {
        _all = cats;
        _filtered = cats;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading categories')));
    }
  }

  void _onSearch(String q) {
    setState(() {
      _query = q;
      _filtered = _all.where((c) => c.name.toLowerCase().contains(q.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RandomMealScreen()),
              );
            },
            icon: const Icon(Icons.shuffle, color: Colors.black),
            label: const Text(
              "Random Meal",
              style: TextStyle(color: Colors.black),
            ),

          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          CustomSearchBar(onChanged: _onSearch, hint: 'Search categories'),
          if (_filtered.isEmpty && _query.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('No categories match "$_query"'),
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.78,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filtered.length,
              itemBuilder: (ctx, idx) {
                final c = _filtered[idx];
                return CategoryCard(
                  category: c,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MealsScreen(category: c.name)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
