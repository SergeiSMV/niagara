import 'package:niagara_app/core/core.dart';

class Promotion extends Equatable {
  const Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.isPersonal,
  });

  final String id;
  final String title;
  final String description;
  final String image;
  final DateTime startDate;
  final DateTime endDate;
  final bool isPersonal;

  @override
  List<Object?> get props => [
        title,
        description,
        image,
        startDate,
        endDate,
        isPersonal,
      ];
}
