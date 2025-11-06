import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/constants/const_keys.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_avatar.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_items_list.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GlobalCubit, GlobalState>(
          listenWhen: (previous, current) =>
              previous.selectedLanguage != current.selectedLanguage,
          listener: (context, state) {
            if (state.selectedLanguage == Language.english) {
              context.setLocale(const Locale(ConstKeys.english));
            } else if (state.selectedLanguage == Language.arabic) {
              context.setLocale(const Locale(ConstKeys.arabic));
            }
          },
        ),
      ],
      child: BlocBuilder<GlobalCubit, GlobalState>(
        buildWhen: (previous, current) =>
            previous.selectedLanguage != current.selectedLanguage,
        builder: (context, state) => BlurredLayerView(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: REdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const RSizedBox(height: 12),
                  CustomAppBar(
                    title: AppText.profile.tr(),
                    automaticallyImplyLeading: false,
                  ),
                  const RSizedBox(height: 40),
                  const ProfileAvatar(),
                  const RSizedBox(height: 40),
                  const ProfileItemsList(),
                  const RSizedBox(height: 115),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
