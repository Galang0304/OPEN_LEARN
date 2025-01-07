class Story {
  final String title;
  final String description;
  final String content;
  final String author;
  final String category;
  final List<String> tags;
  final String imageUrl;
  final int readTime;
  final bool isFavorite;
  final int rating;
  final List<String> audioUrls;
  final List<String> relatedStories;

  Story({
    required this.title,
    required this.description,
    required this.content,
    required this.author,
    required this.category,
    required this.tags,
    this.imageUrl = '',
    required this.readTime,
    this.isFavorite = false,
    this.rating = 0,
    this.audioUrls = const [],
    this.relatedStories = const [],
  });
} 