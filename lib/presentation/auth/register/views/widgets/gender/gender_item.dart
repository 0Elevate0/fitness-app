import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_intent.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class GenderItem extends StatelessWidget {
  const GenderItem({
    super.key,
    required this.selectedGender,
    required this.genderTitle,
    required this.genderIcon,
  });
  final String genderTitle;
  final String genderIcon;
  final Gender? selectedGender;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    return GestureDetector(
      onTap: () => registerCubit.doIntent(
        intent: ChangeSelectedGenderIntent(newSelectedGender: genderTitle),
      ),
      child: AnimatedContainer(
        padding: REdgeInsets.symmetric(horizontal: 30, vertical: 10),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selectedGender?.name == genderTitle.toLowerCase().trim()
              ? theme.colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            width: 1.r,
            color: selectedGender?.name == genderTitle.toLowerCase().trim()
                ? theme.colorScheme.primary
                : theme.colorScheme.onSecondary,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(genderIcon, fit: BoxFit.contain),
            const RSizedBox(height: 8),
            RSizedBox(
              width: 40,
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                child: Text(
                  genderTitle.tr(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
