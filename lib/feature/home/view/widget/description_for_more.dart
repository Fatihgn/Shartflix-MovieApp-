part of '../home_view.dart';

/// A widget that displays a description with a "more" or "less" toggle.
class DescriptionForMore extends StatelessWidget {
  const DescriptionForMore({
    required this.description,
    required this.isExpandedNotifier,
    super.key,
  });

  final String description;
  final ValueNotifier<bool> isExpandedNotifier;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ValueListenableBuilder<bool>(
          valueListenable: isExpandedNotifier,
          builder: (context, isExpanded, child) {
            // Check for overflow only when the text is NOT expanded.
            final textSpan = TextSpan(
              text: description,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white70,
                fontSize: ProjectFonts.medium.value.sp,
                shadows: const [
                  Shadow(blurRadius: 5),
                ],
              ),
            );

            // TextPainter is used to determine if the text exceeds 2 lines.
            final textPainter = TextPainter(
              text: textSpan,
              maxLines: 2,
              textDirection: ui.TextDirection.ltr,
            )..layout(maxWidth: constraints.maxWidth);

            final isOverflowing = textPainter.didExceedMaxLines;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  maxLines: isExpanded ? null : 2,
                  overflow: isExpanded
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white70,
                    fontSize: ProjectFonts.medium.value.sp,
                    shadows: const [
                      Shadow(blurRadius: 5),
                    ],
                  ),
                ),
                // Show "more" only if the text is overflowing AND NOT expanded.
                if (isOverflowing && !isExpanded)
                  GestureDetector(
                    onTap: () {
                      isExpandedNotifier.value = true;
                    },
                    child: Text(
                      LocaleKeys.home_more,
                      style: TextStyle(
                        color: context.textColor,
                        fontSize: ProjectFonts.medium.value.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ).tr(),
                  ),
                // Show "less" only when the text IS expanded.
                if (isExpanded)
                  GestureDetector(
                    onTap: () {
                      isExpandedNotifier.value = false;
                    },
                    child: Text(
                      LocaleKeys.home_less,
                      style: TextStyle(
                        color: context.textColor,
                        fontSize: ProjectFonts.medium.value.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ).tr(),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
