import 'package:niagara_app/core/core.dart';

class Promotion extends Equatable {
  const Promotion({
    required this.title,
    required this.description,
    required this.image,
    this.endDate,
  });

  final String title;
  final String description;
  final String image;
  final String? endDate;

  @override
  List<Object?> get props => [title, description, image, endDate];
}
