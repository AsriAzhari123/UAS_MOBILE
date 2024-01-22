class Manga {
  final Map<String, dynamic>? title;
  final Map<String, dynamic>? description;
  final String? status;
  final int? year;
  final String? rating;

  Manga(this.title, this.description, this.status, this.year, this.rating);

  factory Manga.fromJson(Map<String, dynamic> parsedJson) {
    final title = parsedJson['title'] as Map<String, dynamic>?;
    final description = parsedJson['description'] as Map<String, dynamic>?;
    final status = parsedJson['status'] as String?;
    final year = parsedJson['year'] as int?;
    final rating = parsedJson['contentRating'] as String?;
    return Manga(title, description, status, year, rating);
  }
}
