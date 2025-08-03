part of '../login_view.dart';

class FastLoginButton extends StatelessWidget {
  const FastLoginButton({required this.icon, super.key});

  final Image icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.borderColor,
        ),
        color: context.whiteContainer,
        borderRadius: BorderRadius.all(
          Radius.circular(ProjectRadius.medium.value),
        ),
      ),
      child: Padding(
        padding: const ProjectPadding.allNormal(),
        child: icon,
      ),
    );
  }
}
