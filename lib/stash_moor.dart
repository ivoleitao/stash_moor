/// Provides a Moor implementation of the Stash caching API for Dart
library stash_moor;

import 'package:stash/stash_api.dart';
import 'package:stash_moor/src/moor/cache_database.dart';
import 'package:stash_moor/src/moor/moor_store.dart';

export 'src/moor/cache_database.dart';
export 'src/moor/moor_store.dart';

/// Creates a new [Cache] backed by a [MoorStore]
///
/// * [db]: The [CacheDatabase] instance
/// * [cacheName]: The name of the cache
/// * [expiryPolicy]: The expiry policy to use, defaults to [EternalExpiryPolicy] if not provided
/// * [sampler]: The sampler to use upon eviction of a cache element, defaults to [FullSampler] if not provided
/// * [evictionPolicy]: The eviction policy to use, defaults to [LfuEvictionPolicy] if not provided
/// * [maxEntries]: The max number of entries this cache can hold if provided. To trigger the eviction policy this value should be provided
/// * [cacheLoader]: The [CacheLoader] that should be used to fetch a new value upon expiration
/// * [codec]: The [CacheCodec] used to convert to/from a Map<String, dynamic>` representation to a binary representation
/// * [fromEncodable]: A custom function the converts to the object from a `Map<String, dynamic>` representation
///
/// Returns a new [Cache] backed by a [MoorStore]
Cache newMoorCache(CacheDatabase db,
    {String cacheName,
    KeySampler sampler,
    EvictionPolicy evictionPolicy,
    int maxEntries,
    ExpiryPolicy expiryPolicy,
    CacheLoader cacheLoader,
    CacheCodec codec,
    dynamic Function(dynamic) fromEncodable}) {
  return Cache.newCache(
      MoorStore(db, codec: codec, fromEncodable: fromEncodable),
      name: cacheName,
      expiryPolicy: expiryPolicy,
      sampler: sampler,
      evictionPolicy: evictionPolicy,
      maxEntries: maxEntries,
      cacheLoader: cacheLoader);
}
