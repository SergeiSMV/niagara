import 'package:niagara_app/core/core.dart';

class FaqBonuses extends Equatable {
  const FaqBonuses({
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;

  @override
  List<Object?> get props => [question, answer];
}
