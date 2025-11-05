import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_policy_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_section_entity.dart';
import 'package:fitness_app/domain/entities/account/privacy_and_security/privacy_sub_section_entity.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_cubit.dart';
import 'package:fitness_app/presentation/privacy_policy/views_model/privacy_policy_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/loading_view.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyViewBody extends StatelessWidget {
  const PrivacyPolicyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    final bool isArabic = globalCubit.state.selectedLanguage == Language.arabic;
    return BlocConsumer<PrivacyPolicyCubit, PrivacyPolicyState>(
      listenWhen: (previous, current) => current.privacyPolicyStatus.isFailure,
      listener: (context, state) {
        if (state.privacyPolicyStatus.isFailure) {
          Loaders.showErrorMessage(
            message:
                "${AppText.privacyPolicyErrorMessage.tr()} ${state.privacyPolicyStatus.error?.message}",
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state.privacyPolicyStatus.isSuccess) {
          return BlurredLayerView(
            child: _buildPrivacyPolicyContent(
              context,
              state.privacyPolicyStatus.data!,
              isArabic,
            ),
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }

  Widget _buildPrivacyPolicyContent(
    BuildContext context,
    PrivacyPolicyEntity policyEntity,
    bool isArabic,
  ) {
    final sections = policyEntity.sections;

    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final section in sections) ...[
              _buildSection(context, section, isArabic),
              const RSizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    PrivacySectionEntity section,
    bool isArabic,
  ) {
    final sectionName = section.section ?? '';
    switch (sectionName) {
      case 'title':
        return _buildTitleSection(section, isArabic);
      case 'last_updated':
      case 'introduction':
      case 'page_subtitle':
        return _buildSubtitleSection(section, isArabic);
      case 'policy_content':
      case 'information_collection':
      case 'how_we_use_info':
      case 'how_we_share_info':
      case 'data_security':
      case 'data_rights':
      case 'childrens_privacy':
      case 'changes_to_policy':
      case 'contact_us':
        return _buildComplexSection(section, isArabic);
      default:
        return _buildGenericSection(section, isArabic);
    }
  }

  Widget _buildTitleSection(PrivacySectionEntity section, bool isArabic) {
    final text = isArabic ? section.content?.ar : section.content?.en;
    final style = section.style;

    return section.section == "title"
        ? CustomAppBar(
            title: text ?? '',
            padding: EdgeInsets.zero,
            automaticallyImplyLeading: true,
            titleStyle: TextStyle(
              fontSize: (style?.fontSize ?? 20).sp,
              fontWeight: FitnessMethodHelper.parseFontWeight(
                style?.fontWeight,
              ),
              color:
                  FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
            ),
          )
        : Text(
            text ?? "",
            style: TextStyle(
              fontSize: (style?.fontSize ?? 20).sp,
              fontWeight: FitnessMethodHelper.parseFontWeight(
                style?.fontWeight,
              ),
              color:
                  FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
            ),
          );
  }

  Widget _buildSubtitleSection(PrivacySectionEntity section, bool isArabic) {
    final text = isArabic ? section.content?.ar : section.content?.en;
    final style = section.style;

    return Container(
      alignment: FitnessMethodHelper.parseAlignment(style?.textAlign, isArabic),
      child: Text(
        text ?? '',
        textAlign: FitnessMethodHelper.parseTextAlign(
          style?.textAlign,
          isArabic,
        ),
        style: TextStyle(
          fontSize: (style?.fontSize ?? 16).sp,
          fontWeight: FitnessMethodHelper.parseFontWeight(style?.fontWeight),
          color: FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
        ),
      ),
    );
  }

  Widget _buildSubSection(PrivacySubSectionEntity subSection, bool isArabic) {
    final title = isArabic ? subSection.title?.ar : subSection.title?.en;
    final content = isArabic ? subSection.content?.ar : subSection.content?.en;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title?.isNotEmpty ?? false,
          child: Text(
            title ?? "",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightOrange.withValues(alpha: 0.8),
            ),
          ),
        ),
        Visibility(
          visible: content?.isNotEmpty ?? false,
          child: Padding(
            padding: REdgeInsets.only(top: 4),
            child: Text(
              content ?? "",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.gray,
                fontWeight: FontWeight.w500,
              ),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenericSection(PrivacySectionEntity section, bool isArabic) {
    final content = isArabic ? section.content?.ar : section.content?.en;
    final style = section.style;

    return Container(
      alignment: FitnessMethodHelper.parseAlignment(style?.textAlign, isArabic),
      child: Text(
        content ?? '',
        textAlign: FitnessMethodHelper.parseTextAlign(
          style?.textAlign,
          isArabic,
        ),
        style: TextStyle(
          fontSize: (style?.fontSize ?? 14).sp,
          color: FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
        ),
      ),
    );
  }

  Widget _buildComplexSection(PrivacySectionEntity section, bool isArabic) {
    final title = isArabic ? section.title?.ar : section.title?.en;
    final dynamic content = isArabic
        ? section.content?.ar
        : section.content?.en;
    final style = section.style;
    final subSections = section.subSections ?? [];

    List<String> contentList = [];
    if (content is List<dynamic>) {
      contentList = content.map((e) => e.toString()).toList();
    } else if (content is String && content.isNotEmpty) {
      contentList = [content];
    }

    return ExpansionTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      tilePadding: REdgeInsets.symmetric(horizontal: 8),
      childrenPadding: REdgeInsets.symmetric(horizontal: 12, vertical: 4),
      collapsedIconColor: Colors.deepOrange,
      title: Text(
        title ?? '',
        textAlign: FitnessMethodHelper.parseTextAlign(
          style?.textAlign,
          isArabic,
        ),
        style: TextStyle(
          fontSize: (style?.fontSize ?? 18).sp,
          fontWeight: FitnessMethodHelper.parseFontWeight(style?.fontWeight),
          color: FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
        ),
      ),

      children: [
        // Render content paragraphs
        for (final line in contentList)
          RPadding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              line,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontSize: (style?.contentFontSize ?? 14).sp,
                fontWeight: FitnessMethodHelper.parseFontWeight(
                  style?.contentFontWeight,
                ),
                color:
                    FitnessMethodHelper.parseColor(style?.contentColor) ??
                    Colors.black,
              ),
            ),
          ),

        // Render sub-sections (recursively)
        for (final sub in subSections)
          RPadding(
            padding: const EdgeInsets.only(top: 8),
            child: _buildSubSection(sub, isArabic),
          ),
      ],
    );
  }
}
