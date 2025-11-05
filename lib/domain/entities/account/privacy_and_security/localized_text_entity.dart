import 'package:equatable/equatable.dart';

final class LocalizedTextEntity extends Equatable {
  final String? en;
  final String? ar;

  const LocalizedTextEntity({this.en, this.ar});

  @override
  List<Object?> get props => [en, ar];
}
