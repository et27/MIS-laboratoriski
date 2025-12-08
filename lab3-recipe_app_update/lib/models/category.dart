class Category {
  final String id;
  final String name;
  final String thumbnail;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory']?.toString() ?? '',
      name: json['strCategory']?.toString() ?? '',
      thumbnail: json['strCategoryThumb']?.toString() ?? '',
      description: json['strCategoryDescription']?.toString() ?? '',
    );
  }
}
