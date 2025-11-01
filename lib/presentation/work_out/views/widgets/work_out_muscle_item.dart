import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/domain/entities/muscle/muscle_entity.dart';
import 'package:fitness_app/utils/common_widgets/custom_image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOutMuscleItem extends StatelessWidget {
  const WorkOutMuscleItem({super.key, required this.muscleData, this.onTap});

  final MuscleEntity muscleData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Navigator.pushNamed(
              context,
              RouteNames.exercise,
              arguments: muscleData,
            );

          },
      child: Center(
        child: CustomImageContainer(
          widget: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryFixed.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: muscleData.image != null
                    ? CachedNetworkImageProvider(muscleData.image ?? "")
                    : const AssetImage(AppImages.notFound),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: muscleData.name ?? '',
        ),
      ),
    );
  }
}
