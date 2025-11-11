import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/help/contact_content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/faq_content_entity.dart';
import 'package:fitness_app/domain/entities/account/help/style_entity.dart';
import 'package:fitness_app/domain/entities/account/help/title_entity.dart';

final class HelpSectionEntity extends Equatable {
  final String? section;
  final ContentEntity? content;
  final TitleEntity? title;
  final StyleEntity? style;
  final List<ContactContentEntity>? contactContent;
  final List<FaqContentEntity>? faqContent;

  const HelpSectionEntity({
    this.section,
    this.content,
    this.title,
    this.style,
    this.contactContent,
    this.faqContent,
  });

  @override
  List<Object?> get props => [
    section,
    content,
    title,
    style,
    contactContent,
    faqContent,
  ];
}
