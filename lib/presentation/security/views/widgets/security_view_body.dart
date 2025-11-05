import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/core/global_cubit/global_cubit.dart';
import 'package:fitness_app/core/global_cubit/global_state.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/permission_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/role_definition_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_config_entity.dart';
import 'package:fitness_app/domain/entities/account/security_roles_config/security_roles_section_entity.dart';
import 'package:fitness_app/presentation/security/views_model/security_cubit.dart';
import 'package:fitness_app/presentation/security/views_model/security_state.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/loading_view.dart';
import 'package:fitness_app/utils/fitness_method_helper.dart';
import 'package:fitness_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityViewBody extends StatelessWidget {
  const SecurityViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final globalCubit = BlocProvider.of<GlobalCubit>(context);
    final bool isArabic = globalCubit.state.selectedLanguage == Language.arabic;

    return BlocConsumer<SecurityCubit, SecurityState>(
      listenWhen: (previous, current) => current.securityStatus.isFailure,
      listener: (context, state) {
        if (state.securityStatus.isFailure) {
          Loaders.showErrorMessage(
            message:
                "${AppText.securityErrorMessage.tr()} ${state.securityStatus.error?.message}",
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state.securityStatus.isSuccess) {
          return BlurredLayerView(
            child: _buildSecurityRolesContent(
              context,
              state.securityStatus.data!,
              isArabic,
            ),
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }

  Widget _buildSecurityRolesContent(
    BuildContext context,
    SecurityRolesConfigEntity configEntity,
    bool isArabic,
  ) {
    final sections = configEntity.sections ?? [];

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
    SecurityRolesSectionEntity section,
    bool isArabic,
  ) {
    final sectionName = section.section ?? '';

    switch (sectionName) {
      case 'page_title':
        return _buildPageTitleSection(section, isArabic);
      case 'page_description':
        return _buildPageDescriptionSection(section, isArabic);
      case 'role_list_title':
        return _buildRoleListTitle(section, isArabic);
      case 'role_definition':
        return _buildRoleDefinitionSection(section, isArabic);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPageTitleSection(
    SecurityRolesSectionEntity section,
    bool isArabic,
  ) {
    final text = isArabic ? section.content?.ar : section.content?.en;
    final style = section.style;

    return CustomAppBar(
      title: text ?? '',
      padding: EdgeInsets.zero,
      automaticallyImplyLeading: true,
      titleStyle: TextStyle(
        fontSize: (style?.fontSize ?? 24).sp,
        fontWeight: FitnessMethodHelper.parseFontWeight(style?.fontWeight),
        color: FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
      ),
    );
  }

  Widget _buildPageDescriptionSection(
    SecurityRolesSectionEntity section,
    bool isArabic,
  ) {
    final text = isArabic ? section.content?.ar : section.content?.en;
    final style = section.style;

    return Text(
      text ?? '',
      textAlign: FitnessMethodHelper.parseTextAlign(style?.textAlign, isArabic),
      style: TextStyle(
        fontSize: (style?.fontSize ?? 16).sp,
        fontWeight: FitnessMethodHelper.parseFontWeight(style?.fontWeight),
        color: FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
      ),
    );
  }

  Widget _buildRoleListTitle(
    SecurityRolesSectionEntity section,
    bool isArabic,
  ) {
    final title = isArabic ? section.title?.ar : section.title?.en;
    final style = section.style;

    return Container(
      padding: REdgeInsets.symmetric(vertical: 8),
      child: Text(
        title ?? '',
        textAlign: FitnessMethodHelper.parseTextAlign(
          style?.textAlign,
          isArabic,
        ),
        style: TextStyle(
          fontSize: (style?.fontSize ?? 20).sp,
          fontWeight: FitnessMethodHelper.parseFontWeight(style?.fontWeight),
          color: FitnessMethodHelper.parseColor(style?.color) ?? Colors.black,
        ),
      ),
    );
  }

  Widget _buildRoleDefinitionSection(
    SecurityRolesSectionEntity section,
    bool isArabic,
  ) {
    final RoleDefinitionEntity? role = section.roleDefinition;
    if (role == null) return const SizedBox.shrink();

    final name = isArabic ? role.name?.ar : role.name?.en;
    final description = isArabic ? role.description?.ar : role.description?.en;
    final permissions = role.permissions ?? [];

    final highlightColor = FitnessMethodHelper.parseColor(
      role.style?['highlightColor'],
    );

    return ExpansionTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      collapsedIconColor: highlightColor ?? AppColors.orange,
      tilePadding: REdgeInsets.symmetric(horizontal: 8),
      childrenPadding: REdgeInsets.symmetric(horizontal: 12, vertical: 4),
      title: Text(
        name ?? '',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FitnessMethodHelper.parseFontWeight(
            role.style?['fontWeight'],
          ),
          color: highlightColor ?? Colors.black,
        ),
        textAlign: isArabic ? TextAlign.right : TextAlign.left,
      ),
      subtitle: RPadding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          description ?? '',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.gray[60],
            fontWeight: FontWeight.w500,
          ),
          textAlign: isArabic ? TextAlign.right : TextAlign.left,
        ),
      ),
      children: [
        for (final permission in permissions)
          _buildPermissionItem(permission, isArabic),
      ],
    );
  }

  Widget _buildPermissionItem(PermissionEntity permission, bool isArabic) {
    final name = isArabic ? permission.name?.ar : permission.name?.en;
    final description = isArabic
        ? permission.description?.ar
        : permission.description?.en;

    return Padding(
      padding: REdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "• ${name ?? ''}",
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.lightOrange,
            ),
            textAlign: isArabic ? TextAlign.right : TextAlign.left,
          ),
          RPadding(
            padding: const EdgeInsets.only(top: 2, left: 12, right: 12),
            child: Text(
              description ?? '',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.gray,
                fontWeight: FontWeight.w400,
              ),
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
