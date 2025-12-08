import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../services/favorites_manager.dart';
import '../widgets/meal_card.dart';

import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final favManager = FavoritesManager();
  late List<Meal> _favorites;

  @override
  void initState() {
    super.initState();
    // креираме локална копија за state
    _favorites = List.from(widget.favorites);
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      favManager.toggleFavorite(meal.id);
      _favorites.removeWhere((m) => m.id == meal.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorite Meals")),
      body: _favorites.isEmpty
          ? const Center(child: Text("No favorite meals yet"))
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _favorites.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.82,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) {
          final m = _favorites[i];
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
    );
  }
}