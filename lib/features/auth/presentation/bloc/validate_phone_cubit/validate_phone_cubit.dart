import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/core/utils/constants/app_constants.dart';


/// [ValidatePhoneCubit] - кубит для валидации номера телефона.
/// Принимает номер телефона и проверяет его валидность.
@injectable
class ValidatePhoneCubit extends Cubit<bool> {
  /// Создает объект кубита для валидации номера телефона.
  ValidatePhoneCubit() : super(false);

  /// Проверяет валидность номера телефона.
  void validatePhone(String? phoneNumber) {
    final phone = phoneNumber?.replaceAll(RegExp(r'\D'), '');
    final hasValid = phone != null && phone.length == AppConst.kPhoneDigits;
    emit(hasValid);
  }
}
