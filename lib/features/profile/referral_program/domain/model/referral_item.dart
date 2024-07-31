import 'package:niagara_app/core/core.dart';

class ReferralItem extends Equatable {
  const ReferralItem({required this.text});

  final String text;

  @override
  List<Object?> get props => [text];
}
