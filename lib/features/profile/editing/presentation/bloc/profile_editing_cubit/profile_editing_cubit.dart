import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:niagara_app/features/profile/user/data/repositories/profile_repository.dart';
import 'package:niagara_app/features/profile/user/domain/models/user.dart';

/// [Cubit] для редактирования данных профиля. Не сохраняет изменений в
/// [ProfileRepository], а только лишь хранит их внутри своего состояния.
///
/// Возвращает текущее состояния [User].
@injectable
class ProfileEditingCubit extends Cubit<User> {
  ProfileEditingCubit({
    @factoryParam required User user,
  })  : _user = user,
        super(user);

  final User _user;

  bool get hasChanges => _user != state;

  /// Обновляет данные пользователя.
  Future<void> updateUserData({
    String? name,
    String? surname,
    String? patronymic,
    DateTime? birthday,
    String? email,
  }) async {
    emit(
      state.copyWith(
        name: name,
        surname: surname,
        patronymic: patronymic,
        birthday: birthday,
        email: email,
      ),
    );
  }
}
