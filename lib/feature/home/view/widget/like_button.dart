// like_button.dart
part of '../home_view.dart';

/// A widget that displays a like button for a movie.
class LikeButton extends StatelessWidget {
  const LikeButton({required this.movie, super.key});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            /// Check if the state is HomeSuccess to access the movie list.
            final currentMovie = (state as HomeSuccess).model.movies.firstWhere(
              (m) => m.id == movie.id,
              orElse: () => movie,
            );
            final isLiked = currentMovie.isFavorite ?? false;

            return GestureDetector(
              onTap: () {
                /// Dispatch the SetFavoriteEvent to toggle the favorite status of the movie.
                context.read<HomeBloc>().add(SetFavoriteEvent(movie.id!));

                context.read<ProfileBloc>().add(
                  ChangeFavorite(movie, !isLiked),
                );
              },
              child: Container(
                width: 50.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: context.whiteContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.fromBorderSide(
                    BorderSide(color: context.borderColor),
                  ),
                ),
                child: Icon(
                  Icons.favorite,
                  color: isLiked ? context.primaryColor : context.textColor,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
