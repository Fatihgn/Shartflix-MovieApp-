/// Represents a movie model with various attributes.
class MovieModel {
  MovieModel({
    this.id,
    this.title,
    this.description,
    this.posterUrl,
    this.isFavorite,
    this.genre,
  });

  MovieModel.fromJson(Map<String, dynamic> json)
    : id = json['id']?.toString(),
      title = json['Title']?.toString(),
      description = json['Plot']?.toString(),
      posterUrl = json['Poster']?.toString(),
      isFavorite = json['isFavorite'] as bool?,
      genre = json['Genre']?.toString();

  final String? id;
  final String? title;
  final String? description;
  final String? posterUrl;
  final bool? isFavorite;
  final String? genre;

  MovieModel copyWith({
    String? id,
    String? title,
    String? description,
    String? posterUrl,
    bool? isFavorite,
    String? genre,
  }) {
    return MovieModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      posterUrl: posterUrl ?? this.posterUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['Title'] = title;
    data['Plot'] = description;
    data['Poster'] = posterUrl;
    data['isFavorite'] = isFavorite;
    data['Genre'] = genre;
    return data;
  }
}
