import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/chat_section.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views/widgets/smart_coach_chat_app_bar.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_text_form_field.dart';
import 'package:fitness_app/utils/image_picker_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmartCoachChatBodyView extends StatelessWidget {
  const SmartCoachChatBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<SmartCoachChatCubit>(context);
    return BlurredLayerView(
      child: Column(
        children: [
          const RSizedBox(height: 30),
          const SmartCoachChatAppBar(),
          const RSizedBox(height: 20),
          Expanded(
            child: BlocBuilder<SmartCoachChatCubit, SmartCoachChatState>(
              builder: (context, state) {
                final isLoading = state.sendMessageStatus.isLoading;

                return Column(
                  children: [
                    Expanded(child: ChatSection(messages: state.messages)),
                    RPadding(
                      padding: const EdgeInsets.all(18),
                      child: CustomTextFormField(
                        controller: cubit.messageController,
                        label: AppText.askAnyThing.tr(),
                        labelStyle: theme.textTheme.bodyLarge,
                        prefixIcon: GestureDetector(
                          onTap: () => ImagePickerSheet.showImagePickerOptions(
                            context,
                            cubit,
                          ),
                          child: const Icon(Icons.add, color: AppColors.gray),
                        ),
                        suffixIcon: GestureDetector(
                          onTap: isLoading
                              ? null
                              : () {
                                  cubit.doIntent(
                                    SendMessageIntent(
                                      message: cubit.messageController.text,
                                    ),
                                  );
                                },
                          child: isLoading
                              ? const RSizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.gray,
                                  ),
                                )
                              : const Icon(Icons.send, color: AppColors.gray),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
