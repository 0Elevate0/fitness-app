import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_intent.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/presentation/profile/views/widgets/profile_selection_item.dart';
import 'package:fitness_app/utils/common_widgets/bracket_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectLanguageItem extends StatelessWidget {
  const SelectLanguageItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    return BlocBuilder<GlobalCubit, GlobalState>(
      builder: (context, state) => ProfileSelectionItem(
        onTap: () async => await globalCubit.doIntent(
          intent: ChangeLanguageIntent(
            newSelectedLanguage: state.selectedLanguage == Language.english
                ? Language.arabic
                : Language.english,
          ),
        ),
        prefixIcon: AppIcons.language,
        isTextTitle: false,
        titleWidget: BracketText(
          textOutside: AppText.selectLanguage,
          textInside: state.selectedLanguage == Language.english
              ? AppText.english.tr()
              : AppText.arabic.tr(),
        ),
        isSuffixIcon: false,
        suffixWidget: RSizedBox(
          height: 20,
          child: BlocBuilder<GlobalCubit, GlobalState>(
            builder: (context, state) => Switch(
              padding: EdgeInsets.zero,
              value: state.selectedLanguage == Language.english ? true : false,
              thumbColor: WidgetStatePropertyAll(theme.colorScheme.onSecondary),
              trackColor: WidgetStatePropertyAll(theme.colorScheme.primary),
              trackOutlineColor: WidgetStatePropertyAll(
                theme.colorScheme.primary,
              ),
              onChanged: (value) async {
                await globalCubit.doIntent(
                  intent: ChangeLanguageIntent(
                    newSelectedLanguage:
                        state.selectedLanguage == Language.english
                        ? Language.arabic
                        : Language.english,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
