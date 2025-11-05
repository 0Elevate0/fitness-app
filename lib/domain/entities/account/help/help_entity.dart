import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/help/help_section_entity.dart';

final class HelpEntity extends Equatable {
  final List<HelpSectionEntity>? helpScreenContent;

  const HelpEntity({this.helpScreenContent});

  @override
  List<Object?> get props => [helpScreenContent];
}
