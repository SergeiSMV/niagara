import 'package:niagara_app/core/core.dart';

class Group extends Equatable {
  const Group({
    required this.name,
    required this.id,
    required this.image,
  });

  final String name;
  final String id;
  final String image;

  @override
  List<Object?> get props => [name, id, image];
}
