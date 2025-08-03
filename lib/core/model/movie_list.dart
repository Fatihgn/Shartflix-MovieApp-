import 'package:Shartflix/core/model/movie_model.dart';

/// Represents a list of movies with pagination information.
class MovieList {
  MovieList({
    this.movies = const [],
    this.pagination,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) {
    return MovieList(
      movies:
          (json['movies'] as List<dynamic>?)
              ?.map((v) => MovieModel.fromJson(v as Map<String, dynamic>))
              .toList() ??
          const [],
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
    );
  }

  final List<MovieModel> movies;
  final Pagination? pagination;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['movies'] = movies.map((v) => v.toJson()).toList();
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

/// Represents pagination information for a list of movies.
class Pagination {
  Pagination({
    this.totalCount = 0,
    this.perPage = 0,
    this.maxPage = 0,
    this.currentPage = 0,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalCount: json['totalCount'] as int? ?? 0,
      perPage: json['perPage'] as int? ?? 0,
      maxPage: json['maxPage'] as int? ?? 0,
      currentPage: json['currentPage'] as int? ?? 0,
    );
  }

  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['totalCount'] = totalCount;
    data['perPage'] = perPage;
    data['maxPage'] = maxPage;
    data['currentPage'] = currentPage;
    return data;
  }
}
