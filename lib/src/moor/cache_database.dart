import 'package:moor/moor.dart';
import 'package:stash_moor/src/moor/dao/cache_dao.dart';
import 'package:stash_moor/src/moor/table/cache_table.dart';
import 'package:stash_moor/src/moor/table/iso8601_converter.dart';

part 'cache_database.g.dart';

@UseMoor(tables: [
  CacheTable,
], daos: [
  CacheDao
])
class CacheDatabase extends _$CacheDatabase {
  static const int SchemaVersion = 1;

  CacheDatabase(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => SchemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      if (details.wasCreated) {}
      await customStatement('PRAGMA foreign_keys = ON;');
    });
  }
}
