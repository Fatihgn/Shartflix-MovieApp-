import 'dart:convert';
import 'dart:developer';

import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/core/network/exceptions/api_exceptions.dart';
import 'package:Shartflix/core/network/manager/network_manager.dart';
import 'package:Shartflix/core/network/response/api_response.dart';
import 'package:Shartflix/core/utility/helpers/parser.dart';
import 'package:dio/dio.dart';

/// This service provides methods for logging in, registering, and changing user photos.
class AuthService {
  AuthService(this._networkManager, this._cacheService);
  final NetworkManager _networkManager;
  final CacheService _cacheService;

  /// Logs in a user with the provided email and password.
  Future<ApiResponse<UserModel>> login(String email, String password) async {
    log('Attempting to log in with email: $email');
    final response = await _networkManager.postP(
      'user/login',
      parser: (data) => parseSingle(data['data'], UserModel.fromJson),
      body: json.encode({'email': email, 'password': password}),
    );
    log('Login response: $response');
    switch (response) {
      case Success(data: final data):
        await _cacheService.saveUserData(
          user: data,
        );

        return Success(data);
      case Failure(error: final apiError):
        return Failure(apiError);
    }
  }

  /// Registers a new user with the provided email, name, and password.
  Future<ApiResponse<UserModel>> register(
    String email,
    String name,
    String password,
  ) async {
    final response = await _networkManager.postP(
      'user/register',
      parser: (data) => parseSingle(data['data'], UserModel.fromJson),
      body: json.encode({'email': email, 'name': name, 'password': password}),
    );
    log('Login response: $response');
    switch (response) {
      case Success(data: final data):
        await _cacheService.saveUserData(
          user: data,
        );
        return Success(data);
      case Failure(error: final apiError):
        return Failure(apiError);
    }
  }

  /// Changes the user's photo by uploading a file.
  Future<ApiResponse<UserModel>> changePhoto(
    String file,
  ) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file),
    });
    final response = await _networkManager.postP(
      'user/upload_photo',
      parser: (data) => parseSingle(data['data'], UserModel.fromJson),
      body: formData,
    );
    switch (response) {
      case Success(data: final data):
        await _cacheService.saveUserDataWithoutToken(
          user: data,
        );
        return Success(data);
      case Failure(error: final apiError):
        return Failure(apiError);
    }
  }
}
