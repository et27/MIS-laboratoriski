
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/meal.dart';
import '../services/favorites_manager.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const MealCard({
    super.key,
    required this.meal,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final favManager = FavoritesManager();
    final isFavorite = favManager.isFavorite(meal.id);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min, // важен дел за да не се проширува колоната
          children: [
            // Stack само за сликата и срцето
            Stack(
              children: [
                // Ограничена висина за сликата
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200, // можеш да ја прилагодиш висината
                  ),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: CachedNetworkImage(
                      imageUrl: meal.thumbnail,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(color: Colors.grey[300]),
                      errorWidget: (_, __, ___) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                // Срцето за омилени
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
