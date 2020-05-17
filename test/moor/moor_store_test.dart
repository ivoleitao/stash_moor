import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:stash/stash_harness.dart';
import 'package:stash_moor/stash_moor.dart';
import 'package:test/test.dart';

QueryExecutor memoryExecutor({bool logStatements = false}) {
  return VmDatabase.memory(logStatements: logStatements);
}

void main() async {
  Future<MoorStore> newStore(
      {dynamic Function(Map<String, dynamic>) fromEncodable}) {
    return Future.value(MoorStore(
        CacheDatabase(memoryExecutor(logStatements: false)),
        fromEncodable: fromEncodable));
  }

  Future<MoorStore> newObjectStore(
      {dynamic Function(Map<String, dynamic>) fromEncodable}) {
    return newStore(fromEncodable: fromEncodable);
  }

  Future<MoorStore> newSampleObjectStore() {
    return newObjectStore(
        fromEncodable: (Map<String, dynamic> json) =>
            SampleClass.fromJson(json));
  }

  Future<void> deleteStore(MoorStore store) {
    return store.deleteAll();
  }

  test('Boolean', () async {
    await testStoreWith<MoorStore>(newStore, BoolGenerator(), deleteStore);
    await testCacheWith<MoorStore>(
        newStore, newDefaultCache, BoolGenerator(), deleteStore);
  });

  test('Int', () async {
    await testStoreWith<MoorStore>(newStore, IntGenerator(), deleteStore);
    await testCacheWith<MoorStore>(
        newStore, newDefaultCache, IntGenerator(), deleteStore);
  });

  test('Double', () async {
    await testStoreWith<MoorStore>(newStore, DoubleGenerator(), deleteStore);
    await testCacheWith<MoorStore>(
        newStore, newDefaultCache, DoubleGenerator(), deleteStore);
  });

  test('String', () async {
    await testStoreWith<MoorStore>(newStore, StringGenerator(), deleteStore);
    await testCacheWith<MoorStore>(
        newStore, newDefaultCache, StringGenerator(), deleteStore);
  });

  test('List<bool>', () async {
    await testStoreWith<MoorStore>(
        newStore, IteratorGenerator(BoolGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        IteratorGenerator(BoolGenerator()), deleteStore);
  });

  test('List<int>', () async {
    await testStoreWith<MoorStore>(
        newStore, IteratorGenerator(IntGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        IteratorGenerator(IntGenerator()), deleteStore);
  });

  test('List<double>', () async {
    await testStoreWith<MoorStore>(
        newStore, IteratorGenerator(DoubleGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        IteratorGenerator(DoubleGenerator()), deleteStore);
  });

  test('List<String>', () async {
    await testStoreWith<MoorStore>(
        newStore, IteratorGenerator(StringGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        IteratorGenerator(StringGenerator()), deleteStore);
  });

  test('Map<bool,bool>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(BoolGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), BoolGenerator()), deleteStore);
  });

  test('Map<bool,int>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(BoolGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), IntGenerator()), deleteStore);
  });

  test('Map<bool,double>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(BoolGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), DoubleGenerator()), deleteStore);
  });

  test('Map<bool,String>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(BoolGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(BoolGenerator(), StringGenerator()), deleteStore);
  });

  test('Map<int,bool>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(IntGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), BoolGenerator()), deleteStore);
  });

  test('Map<int,int>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(IntGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), IntGenerator()), deleteStore);
  });

  test('Map<int,double>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(IntGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), DoubleGenerator()), deleteStore);
  });

  test('Map<int,String>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(IntGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(IntGenerator(), StringGenerator()), deleteStore);
  });

  test('Map<double,bool>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(DoubleGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), BoolGenerator()), deleteStore);
  });

  test('Map<double,int>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(DoubleGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), IntGenerator()), deleteStore);
  });

  test('Map<double,double>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(DoubleGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), DoubleGenerator()), deleteStore);
  });

  test('Map<double,String>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(DoubleGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(DoubleGenerator(), StringGenerator()), deleteStore);
  });

  test('Map<String,bool>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(StringGenerator(), BoolGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), BoolGenerator()), deleteStore);
  });

  test('Map<String,int>', () async {
    await testStoreWith<MoorStore>(
        newStore, MapGenerator(StringGenerator(), IntGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), IntGenerator()), deleteStore);
  });

  test('Map<double,double>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(StringGenerator(), DoubleGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), DoubleGenerator()), deleteStore);
  });

  test('Map<String,String>', () async {
    await testStoreWith<MoorStore>(newStore,
        MapGenerator(StringGenerator(), StringGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newStore, newDefaultCache,
        MapGenerator(StringGenerator(), StringGenerator()), deleteStore);
  });

  test('Class<bool>', () async {
    await testStoreWith<MoorStore>(newSampleObjectStore,
        SampleClassGenerator(BoolGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(BoolGenerator()), deleteStore);
  });

  test('Class<int>', () async {
    await testStoreWith<MoorStore>(newSampleObjectStore,
        SampleClassGenerator(IntGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(IntGenerator()), deleteStore);
  });

  test('Class<double>', () async {
    await testStoreWith<MoorStore>(newSampleObjectStore,
        SampleClassGenerator(DoubleGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(DoubleGenerator()), deleteStore);
  });

  test('Class<String>', () async {
    await testStoreWith<MoorStore>(newSampleObjectStore,
        SampleClassGenerator(StringGenerator()), deleteStore);
    await testCacheWith<MoorStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(StringGenerator()), deleteStore);
  });

  test('Class<List<bool>>', () async {
    await testStoreWith<MoorStore>(newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(BoolGenerator())), deleteStore);
    await testCacheWith<MoorStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(IteratorGenerator(BoolGenerator())), deleteStore);
  });

  test('Class<List<int>>', () async {
    await testStoreWith<MoorStore>(newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(IntGenerator())), deleteStore);
    await testCacheWith<MoorStore>(newSampleObjectStore, newDefaultCache,
        SampleClassGenerator(IteratorGenerator(IntGenerator())), deleteStore);
  });

  test('Class<List<double>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(DoubleGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(IteratorGenerator(DoubleGenerator())),
        deleteStore);
  });

  test('Class<List<String>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(IteratorGenerator(StringGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(IteratorGenerator(StringGenerator())),
        deleteStore);
  });

  test('Class<Map<bool,bool>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), BoolGenerator())),
        deleteStore);
  });

  test('Class<Map<bool,int>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), IntGenerator())),
        deleteStore);
  });

  test('Class<Map<bool,double>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), DoubleGenerator())),
        deleteStore);
  });

  test('Class<Map<bool,String>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(BoolGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(BoolGenerator(), StringGenerator())),
        deleteStore);
  });

  test('Class<Map<int,bool>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), BoolGenerator())),
        deleteStore);
  });

  test('Class<Map<int,int>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), IntGenerator())),
        deleteStore);
  });

  test('Class<Map<int,double>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), DoubleGenerator())),
        deleteStore);
  });

  test('Class<Map<int,String>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(IntGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(IntGenerator(), StringGenerator())),
        deleteStore);
  });

  test('Class<Map<double,bool>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), BoolGenerator())),
        deleteStore);
  });

  test('Class<Map<double,int>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(DoubleGenerator(), IntGenerator())),
        deleteStore);
  });

  test('Class<Map<double,double>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), DoubleGenerator())),
        deleteStore);
  });

  test('Class<Map<double,String>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(DoubleGenerator(), StringGenerator())),
        deleteStore);
  });

  test('Class<Map<String,bool>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(StringGenerator(), BoolGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(StringGenerator(), BoolGenerator())),
        deleteStore);
  });

  test('Class<Map<String,int>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(MapGenerator(StringGenerator(), IntGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(MapGenerator(StringGenerator(), IntGenerator())),
        deleteStore);
  });

  test('Class<Map<String,double>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), DoubleGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), DoubleGenerator())),
        deleteStore);
  });

  test('Class<Map<String,String>>', () async {
    await testStoreWith<MoorStore>(
        newSampleObjectStore,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), StringGenerator())),
        deleteStore);
    await testCacheWith<MoorStore>(
        newSampleObjectStore,
        newDefaultCache,
        SampleClassGenerator(
            MapGenerator(StringGenerator(), StringGenerator())),
        deleteStore);
  });
}
