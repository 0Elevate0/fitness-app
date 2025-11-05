import 'package:equatable/equatable.dart';
import 'package:fitness_app/domain/entities/account/help/content_entity.dart';

final class FaqContentEntity extends Equatable {
  final String? id;
  final ContentEntity? question;
  final ContentEntity? answer;

  const FaqContentEntity({this.id, this.question, this.answer});

  @override
  List<Object?> get props => [id, question, answer];
}
