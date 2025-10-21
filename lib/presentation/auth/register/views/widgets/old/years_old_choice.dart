import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numberpicker/numberpicker.dart';

class YearsOldChoice extends StatelessWidget {
  const YearsOldChoice({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            AppText.year.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const RSizedBox(height: 12),
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) => NumberPicker(
            value: int.parse(state.selectedYearsOld),
            minValue: 1,
            maxValue: 100,
            step: 1,
            itemHeight: 62.r,
            itemWidth: 65.r,
            itemCount: 5,
            axis: Axis.horizontal,
            onChanged: (value) => registerCubit.doIntent(
              intent: ChangeSelectedYearsIntent(newSelectedYears: value),
            ),
            selectedTextStyle: theme.textTheme.displayLarge,
            textStyle: theme.textTheme.displaySmall,
          ),
        ),
        const RSizedBox(height: 8),
        SvgPicture.asset(AppIcons.indicator, fit: BoxFit.contain),
      ],
    );
  }
}
