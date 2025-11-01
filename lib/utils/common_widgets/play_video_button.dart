import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayVideoButton extends StatelessWidget {
  const PlayVideoButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        tooltip: AppText.preparationVideo.tr(),
        icon: Icon(
          Icons.play_arrow_outlined,
          size: 26.sp,
          color: theme.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
