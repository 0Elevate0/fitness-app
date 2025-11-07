import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/endpoints.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_cubit.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_intent.dart';
import 'package:fitness_app/presentation/edit_profile/views_model/edit_profile_state.dart';
import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final editProfileCubit = BlocProvider.of<EditProfileCubit>(context);
    return BlocBuilder<EditProfileCubit, EditProfileState>(
      builder: (context, state) => Column(
        children: [
          GestureDetector(
            onTap: state.updatePhotoStatus.isLoading
                ? () {}
                : () async => await editProfileCubit.doIntent(
                    intent: const EditProfilePicIntent(),
                  ),
            child: Stack(
              children: [
                Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.onPrimary.withValues(alpha: 0.5),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.onPrimary.withValues(
                          alpha: 0.8,
                        ),
                        blurRadius: 14.r,
                        blurStyle: BlurStyle.outer,
                      ),
                    ],
                  ),
                  child: BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) =>
                        state.updatePhotoStatus.isLoading
                        ? ShimmerEffect(
                            width: 100.r,
                            height: 100.r,
                            radius: 100.r,
                          )
                        : CircleAvatar(
                            radius: 50.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                state.newSelectedImg == null &&
                                    (state.userData?.photo?.contains(
                                          Endpoints.baseUrl,
                                        ) ==
                                        true)
                                ? CachedNetworkImageProvider(
                                    state.userData?.photo ?? "",
                                  )
                                : FileImage(
                                    File(
                                      state.newSelectedImg != null
                                          ? state.newSelectedImg!
                                          : state.userData?.photo ?? "",
                                    ),
                                  ),
                            onBackgroundImageError: (_, _) => ShimmerEffect(
                              width: 100.r,
                              height: 100.r,
                              radius: 100.r,
                            ),
                          ),
                  ),
                ),
                PositionedDirectional(
                  end: 0,
                  child: SvgPicture.asset(AppIcons.edit, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
          const RSizedBox(height: 8),
          Text(
            "${state.userData?.firstName} ${state.userData?.lastName}",
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
