import 'package:equatable/equatable.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';

final class HelpState extends Equatable {
  final StateStatus<HelpEntity> helpStatus;

  const HelpState({this.helpStatus = const StateStatus.initial()});

  HelpState copyWith({StateStatus<HelpEntity>? helpStatus}) {
    return HelpState(helpStatus: helpStatus ?? this.helpStatus);
  }

  @override
  List<Object?> get props => [helpStatus];
}
