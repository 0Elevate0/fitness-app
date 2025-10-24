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

class WeightChoice extends StatelessWidget {
  const WeightChoice({super.key});

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
            AppText.kg.tr(),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const RSizedBox(height: 12),
        BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) => NumberPicker(
            value: int.parse(state.selectedWeight),
            minValue: 20,
            maxValue: 300,
            step: 1,
            itemHeight: 62.r,
            itemWidth: 69.r,
            itemCount: 5,
            axis: Axis.horizontal,
            onChanged: (value) => registerCubit.doIntent(
              intent: ChangeSelectedWeightIntent(newSelectedWeight: value),
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
