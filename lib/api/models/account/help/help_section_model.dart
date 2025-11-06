import 'package:fitness_app/api/models/account/help/contact_content_model.dart';
import 'package:fitness_app/api/models/account/help/content_model.dart';
import 'package:fitness_app/api/models/account/help/faq_content_model.dart';
import 'package:fitness_app/api/models/account/help/style_model.dart';
import 'package:fitness_app/api/models/account/help/title_model.dart';
import 'package:fitness_app/domain/entities/account/help/help_section_entity.dart';

class HelpSectionModel {
  final String? section;
  final ContentModel? content;
  final TitleModel? title;
  final StyleModel? style;
  final List<ContactContentModel>? contactContent;
  final List<FaqContentModel>? faqContent;

  HelpSectionModel({
    this.section,
    this.content,
    this.title,
    this.style,
    this.contactContent,
    this.faqContent,
  });

  factory HelpSectionModel.fromJson(Map<String, dynamic> json) {
    List<ContactContentModel>? contactList;
    List<FaqContentModel>? faqList;

    if (json['section'] == 'contact_us' && json['content'] != null) {
      contactList = (json['content'] as List)
          .map((e) => ContactContentModel.fromJson(e))
          .toList();
    } else if (json['section'] == 'faq' && json['content'] != null) {
      faqList = (json['content'] as List)
          .map((e) => FaqContentModel.fromJson(e))
          .toList();
    }

    return HelpSectionModel(
      section: json['section'] as String?,
      content: json['content'] is Map
          ? ContentModel.fromJson(json['content'])
          : null,
      title: json['title'] != null ? TitleModel.fromJson(json['title']) : null,
      style: json['style'] != null ? StyleModel.fromJson(json['style']) : null,
      contactContent: contactList,
      faqContent: faqList,
    );
  }

  HelpSectionEntity toEntity() {
    return HelpSectionEntity(
      section: section,
      content: content?.toEntity(),
      title: title?.toEntity(),
      style: style?.toEntity(),
      contactContent: contactContent?.map((e) => e.toEntity()).toList(),
      faqContent: faqContent?.map((e) => e.toEntity()).toList(),
    );
  }
}
