import 'package:equatable/equatable.dart';

final class ContentEntity extends Equatable {
  final String? en;
  final String? ar;

  const ContentEntity({this.en, this.ar});

  @override
  List<Object?> get props => [en, ar];
}
