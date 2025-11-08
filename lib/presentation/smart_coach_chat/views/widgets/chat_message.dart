import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatMessage({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser)
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
          child: Padding(
            padding: isUser
                ? REdgeInsetsDirectional.only(start: 20)
                : REdgeInsetsDirectional.only(end: 20),
            child: Container(
              margin: REdgeInsets.symmetric(vertical: 8),
              padding: REdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.onPrimary.withValues(alpha: 0.6)
                    : AppColors.gray[100]?.withValues(alpha: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: isUser
                      ? Radius.circular(20.r)
                      : Radius.circular(0.r),
                  topRight: isUser
                      ? Radius.circular(0.r)
                      : Radius.circular(20.r),
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Text(
                message,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
        if (isUser)
          Padding(
            padding: REdgeInsetsDirectional.only(start: 16),
            child: Container(
              height: 45.r,
              width: 45.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25).r,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    FitnessMethodHelper.userData?.photo ?? "",
                  ),
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
      ],
    );
  }
}
