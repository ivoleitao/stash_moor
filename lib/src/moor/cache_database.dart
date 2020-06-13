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

/// The database class
class CacheDatabase extends _$CacheDatabase {
  /// The version if the schema
  static const int SchemaVersion = 1;

  /// Builds a [CacheDatabase]
  ///
  /// * [executor]: The [QueryExecutor] to user
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
