import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      bottom: false,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  alignment: AlignmentDirectional.centerStart,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${AppText.hi.tr()} ${FitnessMethodHelper.userData?.firstName} ${FitnessMethodHelper.userData?.lastName},",
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                FittedBox(
                  alignment: AlignmentDirectional.centerStart,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    AppText.startYourDay.tr(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const RSizedBox(width: 16),
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                  blurRadius: 12.r,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: theme.colorScheme.onPrimary.withValues(
                alpha: 0.1,
              ),
              backgroundImage: CachedNetworkImageProvider(
                FitnessMethodHelper.userData?.photo ?? "",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
