import 'package:Shartflix/core/cache/cache_service.dart';
import 'package:Shartflix/core/init/router/route_name.dart';
import 'package:Shartflix/core/model/movie_model.dart';
import 'package:Shartflix/core/model/user_model.dart';
import 'package:Shartflix/feature/profile/view/profile_view.dart';
import 'package:Shartflix/feature/profile/view_model/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

mixin ProfileViewMixin on State<ProfileView> {
  late Future<UserModel> userDetailsFuture;

  CacheService get _cacheService => context.read<CacheService>();

  Future<UserModel> _getUserDetails() async {
    final data = await _cacheService.readUserData();
    return data;
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const Favorites());
    userDetailsFuture = _getUserDetails();
  }
}
