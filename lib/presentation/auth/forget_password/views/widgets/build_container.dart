import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/domain/entities/requests/forget_password_request/forget_password_request_entity.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_cubit.dart';
import 'package:fitness_app/presentation/auth/forget_password/views_model/forget_password_intent.dart';
import 'package:fitness_app/utils/common_widgets/blurred_container.dart';
import 'package:fitness_app/utils/common_widgets/custom_elevated_button.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:fitness_app/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BuildContainer extends StatelessWidget {
  const BuildContainer({super.key});

  @override
  Widget build(BuildContext context) {
     final cubit = BlocProvider.of<ForgetPasswordCubit>(context);
    return  BlurredContainer(
      child: RPadding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: cubit.formKey,
          autovalidateMode: cubit.state.autoValidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextFormField(
                validator: (value) =>
                    Validations.emailValidation(email: value),
                controller: cubit.emailController,
                label: AppText.email.tr(),
                prefixIcon: SvgPicture.asset(AppIcons.email),
              ),
              const RSizedBox(height: 18),

              CustomElevatedButton(
                onPressed: () {
                  cubit.doIntent(
                    OnSendOtpClick(
                      request: ForgetPasswordRequestEntity(
                        email: cubit.emailController.text.trim(),
                      ),
                    ),
                  );
                },
                buttonTitle:AppText.sendOtp.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
