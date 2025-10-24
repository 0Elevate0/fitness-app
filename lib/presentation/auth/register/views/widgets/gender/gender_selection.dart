import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/auth/register/views/widgets/gender/gender_item.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_cubit.dart';
import 'package:fitness_app/presentation/auth/register/views_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenderSelection extends StatelessWidget {
  const GenderSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) => Column(
        children: [
          GenderItem(
            selectedGender: state.selectedGender,
            genderTitle: AppText.male,
            genderIcon: AppIcons.male,
          ),
          const RSizedBox(height: 24),
          GenderItem(
            selectedGender: state.selectedGender,
            genderTitle: AppText.female,
            genderIcon: AppIcons.female,
          ),
        ],
      ),
    );
  }
}
