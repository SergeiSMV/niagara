import 'package:niagara_app/core/core.dart';

class Policy extends Equatable {
  const Policy({
    required this.html,
  });

  final String html;

  @override
  List<Object?> get props => [html];
}
