class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final String youtube;
  final List<String> ingredients;
  final List<String> measures;

  MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.youtube,
    required this.ingredients,
    required this.measures,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    final List<String> ingredients = [];
    final List<String> measures = [];

    for (var i = 1; i <= 20; i++) {
      final ing = json['strIngredient$i'];
      final meas = json['strMeasure$i'];
      if (ing != null) {
        final ingStr = ing.toString().trim();
        if (ingStr.isNotEmpty) {
          ingredients.add(ingStr);
          measures.add(meas?.toString().trim() ?? '');
        }
      }
    }

    return MealDetail(
      id: json['idMeal']?.toString() ?? '',
      name: json['strMeal']?.toString() ?? '',
      category: json['strCategory']?.toString() ?? '',
      area: json['strArea']?.toString() ?? '',
      instructions: json['strInstructions']?.toString() ?? '',
      thumbnail: json['strMealThumb']?.toString() ?? '',
      youtube: json['strYoutube']?.toString() ?? '',
      ingredients: ingredients,
      measures: measures,
    );
  }
}
