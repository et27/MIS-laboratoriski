import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/meal_api.dart';
import '../models/meal_detail.dart';

class MealDetailScreen extends StatefulWidget {
  final String id;
  const MealDetailScreen({super.key, required this.id});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  MealDetail? _meal;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final detail = await MealApi.fetchMealDetail(widget.id);
      setState(() {
        _meal = detail;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error loading meal')));
    }
  }

  Future<void> _openYoutube(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cannot open YouTube link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_meal == null) return const Scaffold(body: Center(child: Text('Meal not found')));

    return Scaffold(
      appBar: AppBar(title: Text(_meal!.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              _meal!.thumbnail,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 220,
              errorBuilder: (_, __, ___) => Container(color: Colors.grey[300], height: 220),
            ),
          ),
          const SizedBox(height: 14),
          Text(_meal!.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(children: [
            if (_meal!.category.isNotEmpty) Chip(label: Text(_meal!.category)),
            const SizedBox(width: 8),
            if (_meal!.area.isNotEmpty) Chip(label: Text(_meal!.area)),
          ]),
          const SizedBox(height: 14),
          const Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...List.generate(_meal!.ingredients.length, (i) {
            final ing = _meal!.ingredients[i];
            final meas = (i < _meal!.measures.length) ? _meal!.measures[i] : '';
            return Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Text('• $ing — $meas'));
          }),
          const SizedBox(height: 14),
          const Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_meal!.instructions),
          const SizedBox(height: 18),
          if (_meal!.youtube.isNotEmpty)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _openYoutube(_meal!.youtube),
                icon: const Icon(Icons.play_circle_fill),
                label: const Text('Watch on YouTube'),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              ),
            )
        ]),
      ),
    );
  }
}
