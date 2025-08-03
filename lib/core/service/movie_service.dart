import 'dart:convert';
import 'dart:developer';
import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:Shartflix/core/model/movie_list.dart';
import 'package:Shartflix/core/model/movie_model.dart';
import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/core/network/manager/network_manager.dart';
import 'package:Shartflix/core/network/response/api_response.dart';
import 'package:Shartflix/core/utility/helpers/parser.dart';

/// This service provides methods for fetching movie lists, favorite movies,
class MovieService {
  MovieService(this._networkManager);
  final NetworkManager _networkManager;

  Future<ApiResponse<List<MovieModel>>> favorites() async {
    final response = await _networkManager.get(
      'movie/favorites',
      parser: (data) => parseList(data['data'], MovieModel.fromJson),
    );

    switch (response) {
      case Success(data: final data):
        return Success(data);
      case Failure(error: final apiError):
        return Failure(apiError);
    }
  }

  /// Fetches a list of movies with pagination.
  Future<ApiResponse<MovieList>> movieList(int page) async {
    final response = await _networkManager.get(
      'movie/list?page=$page',
      parser: (data) => parseSingle(data['data'], MovieList.fromJson),
    );

    switch (response) {
      case Success(data: final data):
        return Success(data);
      case Failure(error: final apiError):
        return Failure(apiError);
    }
  }

  /// Sets a movie as favorite by its ID.
  Future<ApiResponse<MovieModel>> setFavorite(String id) async {
    final response = await _networkManager.postP(
      'movie/favorite/$id',
      parser: (data) => parseSingle(data['data'], MovieModel.fromJson),
    );
    switch (response) {
      case Success(data: final data):
        return Success(data);
      case Failure(error: final apiError):
        return Failure(apiError);
    }
  }
}
