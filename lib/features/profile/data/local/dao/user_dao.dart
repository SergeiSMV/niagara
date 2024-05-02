import 'package:drift/drift.dart';
import 'package:niagara_app/core/utils/database/app_database.dart';
import 'package:niagara_app/features/profile/data/local/tables/users_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UsersTable])
class AllUsers extends DatabaseAccessor<AppDatabase> with _$AllUsersMixin {
  AllUsers(super.attachedDatabase);

  Future<UsersTableData> getUser() async => select(usersTable).getSingle();

  Future<int> insertUser(UsersTableCompanion companion) =>
      into(usersTable).insert(companion);

  Future<bool> updateUser(UsersTableCompanion companion) =>
      update(usersTable).replace(companion);

  Future<int> deleteUser(UsersTableCompanion companion) =>
      delete(usersTable).delete(companion);
}
