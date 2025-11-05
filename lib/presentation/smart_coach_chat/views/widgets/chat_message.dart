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
      mainAxisAlignment: isUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (!isUser)
          RPadding(
            padding: const EdgeInsets.only(bottom: 40, right: 12),
            child: Container(
              height: 45.h,
              width: 45.w,
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
          child: RPadding(
            padding: isUser
                ? const EdgeInsets.only(left: 50)
                : const EdgeInsets.only(right: 50),
            child: Container(
              margin: REdgeInsets.symmetric(vertical: 16),
              padding: REdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isUser
                    ? theme.colorScheme.onPrimary.withValues(alpha: 0.6)
                    : AppColors.gray[100]?.withValues(alpha: 0.8),
                borderRadius: BorderRadius.only(
                  topLeft: isUser
                      ? Radius.circular(25.r)
                      : Radius.circular(0.r),
                  topRight: isUser
                      ? Radius.circular(0.r)
                      : Radius.circular(25.r),
                  bottomLeft: Radius.circular(25.r),
                  bottomRight: Radius.circular(25.r),
                ),
              ),
              child: Text(
                message,
                style: theme.textTheme.headlineSmall,
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ),
          ),
        ),
        if (isUser)
          RPadding(
            padding: const EdgeInsets.only(bottom: 40, left: 12),
            child: Container(
              height: 45.h,
              width: 45.w,
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
