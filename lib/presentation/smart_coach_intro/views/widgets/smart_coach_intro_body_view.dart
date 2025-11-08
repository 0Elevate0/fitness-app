import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/router/route_names.dart';
import 'package:fitness_app/presentation/smart_coach_intro/views/widgets/smart_coach_intro_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartCoachIntroBodyView extends StatelessWidget {
  const SmartCoachIntroBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlurredLayerView(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const RSizedBox(height: 12),
              const SmartCoachIntroAppBar(),
              const RSizedBox(height: 20),

              Container(
                height: 425.h,
                width: 350.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppImages.robot),
                  ),
                ),
              ),
              BlurredContainer(
                borderRadius: BorderRadius.circular(50.r),
                padding: REdgeInsets.symmetric(horizontal: 16, vertical: 28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      AppText.howCanIAssistYouToday.tr(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineLarge,
                      overflow: TextOverflow.clip,
                    ),
                    const RSizedBox(height: 10),
                    CustomElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.smartCoachChat);
                      },
                      buttonTitle: AppText.getStarted.tr(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
