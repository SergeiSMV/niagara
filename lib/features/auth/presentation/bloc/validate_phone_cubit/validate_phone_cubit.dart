import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';

@injectable
class ValidatePhoneCubit extends Cubit<bool> {
  ValidatePhoneCubit() : super(false);

  void validatePhone(String? phoneNumber) {
    final phone = phoneNumber?.replaceAll(RegExp(r'\D'), '');
    final hasValid = phone != null && phone.length == AppConst.kPhoneDigits;
    emit(hasValid);
  }
}
