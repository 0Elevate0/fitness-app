import 'package:equatable/equatable.dart';

final class TitleEntity extends Equatable {
  final String? en;
  final String? ar;

  const TitleEntity({this.en, this.ar});

  @override
  List<Object?> get props => [en, ar];
}
