import 'package:fitness_app/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotLoading extends StatelessWidget {
  const ChatBotLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsetsDirectional.only(end: 16),
          child: Container(
            height: 45.r,
            width: 45.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
              image: const DecorationImage(
                image: AssetImage(AppImages.chatLogo),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 12.r,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: CircularProgressIndicator(color: theme.colorScheme.primary),
        ),
      ],
    );
  }
}
