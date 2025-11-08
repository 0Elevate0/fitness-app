import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/constants/app_colors.dart';
import 'package:fitness_app/core/constants/app_icons.dart';
import 'package:fitness_app/core/constants/app_text.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_cubit.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_intent.dart';
import 'package:fitness_app/presentation/smart_coach_chat/views_model/smart_coach_chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatDrawer extends StatelessWidget {
  const ChatDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = BlocProvider.of<SmartCoachChatCubit>(context);

    return SafeArea(
      child: Drawer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              bottomLeft: Radius.circular(25.r),
            ),
            color: AppColors.gray[100]?.withValues(alpha: 0.9),
          ),
          width: 280.w,
          padding: REdgeInsets.all(20),
          child: BlocBuilder<SmartCoachChatCubit, SmartCoachChatState>(
            builder: (context, state) {
              final chats = state.allChats;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppText.previousConversations.tr(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  if (chats.isEmpty)
                    Text(
                      AppText.noPreviousChatsFound.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray[20],
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.separated(
                        itemCount: chats.length,
                        separatorBuilder: (_, __) => Divider(
                          thickness: 2,
                          color: AppColors.gray[800],
                          height: 2,
                        ),
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          return RPadding(
                            padding: const EdgeInsets.only(bottom: 15, top: 15),
                            child: GestureDetector(
                              onTap: () {
                                cubit.doIntent(
                                  LoadChatIntent(
                                    chatId: chat[AppText.id],
                                    title: chat[AppText.title],
                                  ),
                                );
                                Navigator.pop(context);
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(AppIcons.backArw),
                                  Flexible(
                                    child: RPadding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child: Text(
                                        textAlign: TextAlign.end,
                                        chat[AppText.title] ?? AppText.title,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.gray[20],
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  GestureDetector(
                    onTap: () async {
                      cubit.doIntent(const LoadChatIntent(title: "New Chat"));
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.add,
                      color: theme.colorScheme.onSecondary,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
