import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:fitness_app/domain/entities/account/help/help_section_entity.dart';
import 'package:fitness_app/presentation/help/views_model/help_cubit.dart';
import 'package:fitness_app/presentation/help/views_model/help_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/loading_view.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpViewBody extends StatelessWidget {
  const HelpViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    final bool isArabic = globalCubit.state.selectedLanguage == Language.arabic;
    return BlocConsumer<HelpCubit, HelpState>(
      listenWhen: (previous, current) => current.helpStatus.isFailure,
      listener: (context, state) {
        if (state.helpStatus.isFailure) {
          Loaders.showErrorMessage(
            message:
                "${AppText.helpErrorMessage.tr()} ${state.helpStatus.error?.message}",
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state.helpStatus.isSuccess) {
          return BlurredLayerView(
            child: _buildHelpContent(context, state.helpStatus.data!, isArabic),
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }

  Widget _buildHelpContent(
    BuildContext context,
    HelpEntity helpEntity,
    bool isArabic,
  ) {
    final List<HelpSectionEntity> sections = helpEntity.helpScreenContent ?? [];

    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final section in sections) ...[
              if (section.section == "page_title")
                _buildTextSection(section, isArabic),
              if (section.section == "page_subtitle")
                RPadding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: _buildTextSection(section, isArabic),
                ),
              if (section.section == "contact_us")
                _buildContactSection(section, isArabic),
              if (section.section == "faq") _buildFaqSection(section, isArabic),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextSection(HelpSectionEntity section, bool isArabic) {
    final content = isArabic ? section.content?.ar : section.content?.en;
    final style = section.style;

    return Container(
      width: double.infinity,
      alignment: FitnessMethodHelper.parseAlignment(style?.textAlign, isArabic),
      child: section.section == "page_title"
          ? CustomAppBar(title: content, padding: EdgeInsets.zero)
          : Text(
              content ?? "",
              textAlign: FitnessMethodHelper.parseTextAlign(
                style?.textAlign,
                isArabic,
              ),
              style: TextStyle(
                fontSize: (style?.fontSize ?? 16).sp,
                fontWeight: FitnessMethodHelper.parseFontWeight(
                  style?.fontWeight,
                ),
                color:
                    FitnessMethodHelper.parseColor(style?.color) ??
                    Colors.black,
              ),
            ),
    );
  }

  Widget _buildContactSection(HelpSectionEntity section, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (section.title != null)
          Container(
            padding: REdgeInsets.symmetric(vertical: 8),
            alignment: FitnessMethodHelper.parseAlignment(
              section.style?.nestedStyles?['title']?.textAlign,
              isArabic,
            ),
            child: Text(
              isArabic ? section.title?.ar ?? '' : section.title?.en ?? '',
              style: TextStyle(
                fontSize:
                    section.style?.nestedStyles?['title']?.fontSize?.sp ??
                    18.sp,
                fontWeight: FitnessMethodHelper.parseFontWeight(
                  section.style?.nestedStyles?['title']?.fontWeight,
                ),
                color:
                    FitnessMethodHelper.parseColor(
                      section.style?.nestedStyles?['title']?.color,
                    ) ??
                    Colors.black,
              ),
            ),
          ),
        const RSizedBox(height: 8),
        if (section.contactContent != null)
          ...section.contactContent!.map(
            (contact) => Card(
              elevation: 2,
              margin: REdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: RPadding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic
                          ? contact.method?.ar ?? ''
                          : contact.method?.en ?? '',
                      style: TextStyle(
                        fontSize:
                            contact
                                .style
                                ?.nestedStyles?['method']
                                ?.fontSize
                                ?.sp ??
                            16.sp,
                        fontWeight: FitnessMethodHelper.parseFontWeight(
                          contact.style?.nestedStyles?['method']?.fontWeight,
                        ),
                        color:
                            FitnessMethodHelper.parseColor(
                              contact.style?.nestedStyles?['method']?.color,
                            ) ??
                            Colors.deepOrange,
                      ),
                    ),
                    const RSizedBox(height: 4),
                    Text(
                      isArabic
                          ? contact.details?.ar ?? ''
                          : contact.details?.en ?? '',
                      style: TextStyle(
                        fontSize:
                            contact
                                .style
                                ?.nestedStyles?['details']
                                ?.fontSize
                                ?.sp ??
                            14.sp,
                        color:
                            FitnessMethodHelper.parseColor(
                              contact.style?.nestedStyles?['details']?.color,
                            ) ??
                            Colors.grey[700],
                      ),
                    ),
                    const RSizedBox(height: 6),
                    Text(
                      contact.value ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFaqSection(HelpSectionEntity section, bool isArabic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (section.title != null)
          Container(
            margin: REdgeInsets.only(top: 16, bottom: 8),

            alignment: FitnessMethodHelper.parseAlignment(
              section.style?.nestedStyles?['title']?.textAlign,
              isArabic,
            ),
            child: Text(
              isArabic ? section.title?.ar ?? '' : section.title?.en ?? '',
              style: TextStyle(
                fontSize:
                    section.style?.nestedStyles?['title']?.fontSize?.sp ??
                    18.sp,
                fontWeight: FitnessMethodHelper.parseFontWeight(
                  section.style?.nestedStyles?['title']?.fontWeight,
                ),
                color:
                    FitnessMethodHelper.parseColor(
                      section.style?.nestedStyles?['title']?.color,
                    ) ??
                    Colors.black,
              ),
            ),
          ),
        if (section.faqContent != null)
          ...section.faqContent!.map(
            (faq) => ExpansionTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              collapsedIconColor: Colors.deepOrange,
              tilePadding: REdgeInsets.symmetric(horizontal: 8),
              childrenPadding: REdgeInsets.symmetric(horizontal: 12),
              title: Text(
                isArabic ? faq.question?.ar ?? '' : faq.question?.en ?? '',
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: AppColors.white,
                ),
              ),
              children: [
                Text(
                  isArabic ? faq.answer?.ar ?? '' : faq.answer?.en ?? '',
                  textAlign: isArabic ? TextAlign.right : TextAlign.left,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.gray[50],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
