import 'package:equatable/equatable.dart';

final class LocalizedTextAlignEntity extends Equatable {
  final String? en;
  final String? ar;

  const LocalizedTextAlignEntity({this.en, this.ar});

  @override
  List<Object?> get props => [en, ar];
}
