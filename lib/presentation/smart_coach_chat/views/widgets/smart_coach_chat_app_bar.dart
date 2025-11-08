import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmartCoachChatAppBar extends StatelessWidget {
  const SmartCoachChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<SmartCoachChatCubit>(context);

    return CustomAppBar(
      isTitleNotString: true,
      titleWidget: Row(
        children: [
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  AppText.smartCoach.tr(),
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => cubit.scaffoldKey.currentState!.openEndDrawer(),
            child: SvgPicture.asset(AppIcons.menu, fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}
