import 'package:niagara_app/core/core.dart';

class ActivationOption extends Equatable {
  const ActivationOption({
    required this.count,
    required this.sum,
    required this.sumForMounth,
    required this.title,
    required this.description,
    required this.descriptionFull,
    this.label,
  });

  final String count;
  final String sum;
  final String sumForMounth;
  final String title;
  final String description;
  final String descriptionFull;
  final String? label;

  @override
  List<Object?> get props => [
        count,
        sum,
        sumForMounth,
        title,
        description,
        descriptionFull,
        label,
      ];
}
