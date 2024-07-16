import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/database/app_database.dart';
import 'package:niagara_app/features/order_history/data/local/tables/user_orders_table.dart';

part 'orders_dao.g.dart';

/// DAO для работы с таблицей заказов. Позволяет выполнять CRUD операции.
@DriftAccessor(tables: [UserOrdersTable])
class AllOrders extends DatabaseAccessor<AppDatabase> with _$AllOrdersMixin {
  AllOrders(super.attachedDatabase);

  Future<List<UserOrdersTableData>> getOrders() async =>
      select(userOrdersTable).get();

  Future<void> insertOrders(
    List<UserOrdersTableCompanion> companions,
  ) async =>
      batch((batch) => batch.insertAll(userOrdersTable, companions));

  Future<int> insertOrder(UserOrdersTableCompanion companion) =>
      into(userOrdersTable).insert(companion);

  Future<bool> updateOrder(UserOrdersTableCompanion companion) =>
      update(userOrdersTable).replace(companion);

  Future<int> deleteOrder(UserOrdersTableCompanion companion) =>
      delete(userOrdersTable).delete(companion);
}
