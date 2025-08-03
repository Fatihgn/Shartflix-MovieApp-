part of '../profile_view.dart';

/// A widget that builds a movie card for displaying movie details.
class BuildMovieCard extends StatelessWidget {
  const BuildMovieCard({required this.movie, super.key});
  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final String? safePosterUrl;
    if (movie.posterUrl!.contains('https')) {
      safePosterUrl = movie.posterUrl;
    } else {
      safePosterUrl = movie.posterUrl!.replaceAll('http', 'https');
    }

    //log(safePosterUrl);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              safePosterUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
                );
              },
            ),
          ),
        ),
        Gap(8.h),
        Text(
          movie.title!,
          style: TextStyle(
            color: context.textColor,
            fontWeight: FontWeight.w500,
            fontSize: ProjectFonts.small.value.sp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          movie.genre!,
          style: TextStyle(
            color: context.hintTextColor,
            fontSize: ProjectFonts.small.value.sp,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
