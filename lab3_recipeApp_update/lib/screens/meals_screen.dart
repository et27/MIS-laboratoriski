import 'package:flutter/material.dart';
import 'package:recipe_app/screens/favourites_screen.dart';
import '../services/meal_api.dart';
import '../models/meal.dart';
import '../widgets/meal_card.dart';
import '../widgets/search_bar.dart';
import '../services/favorites_manager.dart';
import 'meal_detail_screen.dart';

class MealsScreen extends StatefulWidget {
  final String category;
  const MealsScreen({super.key, required this.category});

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  final favManager = FavoritesManager();
  List<Meal> _all = [];
  List<Meal> _filtered = [];
  bool _loading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final meals = await MealApi.fetchMealsByCategory(widget.category);
      setState(() {
        _all = meals;
        _filtered = meals;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Error loading meals')));
    }
  }

  Future<void> _onSearch(String q) async {
    setState(() {
      _query = q;
    });

    if (q.trim().isEmpty) {
      setState(() => _filtered = _all);
      return;
    }

    try {
      final results = await MealApi.searchMeals(q);
      setState(() => _filtered = results);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Search failed')));
    }
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      favManager.toggleFavorite(meal.id);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FavoritesScreen(
                      favorites: _all.where((m) => favManager.isFavorite(m.id)).toList(),
                    ),
                  ));
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          CustomSearchBar(onChanged: _onSearch, hint: 'Search meals'),
          if (_filtered.isEmpty && _query.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text('No meals match "$_query"'),
            ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.82,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filtered.length,
              itemBuilder: (ctx, idx) {
                final m = _filtered[idx];
                return MealCard(
                  meal: m,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MealDetailScreen(id: m.id),
                      ),
                    );
                  },
                  onFavoriteTap: () => _toggleFavorite(m),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}