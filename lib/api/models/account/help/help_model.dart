import 'package:fitness_app/api/models/account/help/help_section_model.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';

class HelpModel {
  final List<HelpSectionModel>? helpScreenContent;

  HelpModel({this.helpScreenContent});

  factory HelpModel.fromJson(Map<String, dynamic> json) {
    return HelpModel(
      helpScreenContent: (json['help_screen_content'] as List?)
          ?.map((e) => HelpSectionModel.fromJson(e))
          .toList(),
    );
  }

  HelpEntity toEntity() {
    return HelpEntity(
      helpScreenContent: helpScreenContent?.map((e) => e.toEntity()).toList(),
    );
  }
}
