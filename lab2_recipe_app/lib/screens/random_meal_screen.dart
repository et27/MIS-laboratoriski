import 'package:flutter/material.dart';
import '../services/meal_api.dart';
import '../models/meal_detail.dart';
import 'meal_detail_screen.dart';

class RandomMealScreen extends StatefulWidget {
  const RandomMealScreen({super.key});

  @override
  State<RandomMealScreen> createState() => _RandomMealScreenState();
}

class _RandomMealScreenState extends State<RandomMealScreen> {
  MealDetail? _meal;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final m = await MealApi.fetchRandomMeal();
      setState(() {
        _meal = m;
        _loading = false;
      });
      if (m != null) {
        // show detail directly
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MealDetailScreen(id: m.id)));
      }
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error loading random meal')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Meal')),
      body: Center(
        child: _loading ? const CircularProgressIndicator() : const Text('Redirecting...'),
      ),
    );
  }
}
