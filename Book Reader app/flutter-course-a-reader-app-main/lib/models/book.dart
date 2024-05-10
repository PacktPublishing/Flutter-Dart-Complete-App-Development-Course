import 'dart:convert';

class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  bool isFavorite;
  final String description;
  final Map<String, String> industryIdentifiers;
  final int pageCount;
  final String language;
  final Map<String, String> imageLinks;
  final String previewLink;
  final String infoLink;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.industryIdentifiers,
    required this.pageCount,
    this.isFavorite = false,
    required this.language,
    required this.imageLinks,
    required this.previewLink,
    required this.infoLink,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'] ?? {};
    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? '',
      authors: (volumeInfo['authors'] as List<dynamic>? ?? [])
          .map((author) => author.toString())
          .toList(),
      publisher: volumeInfo['publisher'] ?? '',
      publishedDate: volumeInfo['publishedDate'] ?? '',
      description: volumeInfo['description'] ?? '',
      industryIdentifiers: {
        for (var item
            in volumeInfo['industryIdentifiers'] as List<dynamic>? ?? [])
          item['type'] as String? ?? '': item['identifier'] as String? ?? ''
      },
      pageCount: volumeInfo['pageCount'] ?? 0,
      language: volumeInfo['language'] ?? '',
      imageLinks: (volumeInfo['imageLinks'] as Map<String, dynamic>? ?? {})
          .map((key, value) => MapEntry(key, value.toString())),
      previewLink: volumeInfo['previewLink'] ?? '',
      infoLink: volumeInfo['infoLink'] ?? '',
    );
  }

  // for saving to db
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': json.encode(authors), // Serialize list to a JSON string
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'favorite': isFavorite ? 1 : 0,
      'industryIdentifiers':
          json.encode(industryIdentifiers), // Serialize map to a JSON string
      'pageCount': pageCount,
      'language': language,
      'imageLinks': json.encode(imageLinks), // Serialize map to a JSON string
      'previewLink': previewLink,
      'infoLink': infoLink,
    };
  }

  // for loading from db
  factory Book.fromJsonDatabase(Map<String, dynamic> jsonObject) {
    return Book(
      id: jsonObject['id'] as String,
      title: jsonObject['title'] as String,
      authors: jsonObject['authors'] is String
          ? (json.decode(jsonObject['authors']) as List)
              .map((e) => e as String)
              .toList()
          : [],
      publisher: jsonObject['publisher'] as String,
      publishedDate: jsonObject['publishedDate'] as String,
      description: jsonObject['description'] as String,
      industryIdentifiers: jsonObject['industryIdentifiers'] is String
          ? Map.from(json.decode(jsonObject['industryIdentifiers']))
          : {},
      pageCount: jsonObject['pageCount'] as int,
      language: jsonObject['language'] as String,
      imageLinks: jsonObject['imageLinks'] is String
          ? Map.from(json.decode(jsonObject['imageLinks']))
          : {},
      isFavorite: (jsonObject['favorite'] as int) == 1,
      previewLink: jsonObject['previewLink'] as String,
      infoLink: jsonObject['infoLink'] as String,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Book: ${this.title} isFavorite: ${isFavorite}";
  }
}
