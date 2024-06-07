import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:niagara_app/core/common/data/local/entities/product_entity.dart';

class FavoritesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get article => text()();
  TextColumn get imageUrl => text()();
  TextColumn get description => text()();
  TextColumn get descriptionFull => text()();
  TextColumn get groupId => text()();
  TextColumn get groupName => text()();
  TextColumn get type => text()();
  IntColumn get price => integer()();
  IntColumn get priceOld => integer()();
  IntColumn get priceVip => integer()();
  BoolColumn get main => boolean()();
  BoolColumn get productTara => boolean()();
  TextColumn get additionalImages =>
      text().map(const AdditionalImagesConverter())();
  TextColumn get properties => text().map(const PropertiesConverter())();
  TextColumn get label => text()();
  TextColumn get labelColor => text()();
  TextColumn get discountOfCount => text()();
  IntColumn get bonus => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class AdditionalImagesConverter extends TypeConverter<List<String>, String> {
  const AdditionalImagesConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];

    return fromDb.split(',').map((e) => e).toList();
  }

  @override
  String toSql(List<String> value) => value.join(',');
}

class PropertiesConverter
    extends TypeConverter<List<ProductPropertyEntity>, String> {
  const PropertiesConverter();

  @override
  List<ProductPropertyEntity> fromSql(String fromDb) {
    if (fromDb.isEmpty) return [];

    return (jsonDecode(fromDb) as List)
        .map((e) => ProductPropertyEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  String toSql(List<ProductPropertyEntity> value) =>
      jsonEncode(value.map((e) => e.toJson()).toList());
}
