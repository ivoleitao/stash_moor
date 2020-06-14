# stash_moor
A [stash](https://github.com/ivoleitao/stash) storage extension for [moor](https://pub.dev/packages/moor)

[![Pub Package](https://img.shields.io/pub/v/stash_moor.svg?style=flat-square)](https://pub.dartlang.org/packages/stash_moor)
[![Build Status](https://github.com/ivoleitao/shadertoy_api/workflows/build/badge.svg)](https://github.com/ivoleitao/stash_moor/actions)
[![Coverage Status](https://codecov.io/gh/ivoleitao/stash_moor/graph/badge.svg)](https://codecov.io/gh/ivoleitao/stash_moor)
[![Package Documentation](https://img.shields.io/badge/doc-stash_moor-blue.svg)](https://www.dartdocs.org/documentation/stash_moor/latest)
[![GitHub License](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Introduction

This storage extension for [stash](https://pub.dartlang.org/packages/stash) provides a storage layer through the [moor](https://pub.dev/packages/moor) persistent library and relies on a highly performing binary serialization of the cache items through the use of [msgpack](https://msgpack.org) serialization format. This storage backend is particularly optimized to support `Stash` features, like expiration and eviction, highly dependent on the update of control fields on the cache entries upon user operations. On this storage backend the update of those fields does not cause the update of the whole cache entry as some of the other storage implementations like [stash_hive](https://pub.dartlang.org/packages/stash_hive) or [stash_sembast](https://pub.dartlang.org/packages/stash_sembast) since they are stored in specific columns on the relational database model.


## Getting Started

Add this to your `pubspec.yaml` (or create it):

```dart
dependencies:
    stash_moor: ^1.0.0-dev.1
```

Run the following command to install dependencies:

```dart
pub install
```

Optionally use the following command to run the tests:

```dart
pub run test
```

Finally, to start developing import the library:

```dart
import 'package:stash_moor/stash_moor.dart';
```

## Usage

The sample bellow stores a Task object on a moor cache that uses a in-memory implementation of the database. A truly persistent alternative is also possible as presented through the use of an alternate moor QueryExecutor. Both alternatives take advantage of the [moor_ffi](https://pub.dev/packages/moor_ffi) package which provides dart bindings for sqlite. Moor itself provides support relational database support on multiple environments ranging from mobile to desktop.

```dart
import 'dart:io';

import 'package:moor_ffi/moor_ffi.dart';
import 'package:stash_moor/stash_moor.dart';

class Task {
  final int id;
  final String title;
  final bool completed;

  Task({this.id, this.title, this.completed = false});

  /// Creates a [Task] from json map
  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      title: json['title'] as String,
      completed: json['completed'] as bool);

  /// Creates a json map from a [Task]
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'id': id, 'title': title, 'completed': completed};

  @override
  String toString() {
    return 'Task ${id}: "${title}" is ${completed ? "completed" : "not completed"}';
  }
}

CacheDatabase memoryDatabase() {
  // Create a in-memory database
  return CacheDatabase(VmDatabase.memory());
}

CacheDatabase diskDatabase(File file) {
  // Creates a disk based database
  return CacheDatabase(VmDatabase(file));
}

void main() async {
  // Creates cache with a moor based storage backend with the capacity of 10 entries
  final cache = newMoorCache(memoryDatabase(),
      maxEntries: 10, fromEncodable: (json) => Task.fromJson(json));

  // Adds a task with key 'task1' to the cache
  await cache.put(
      'task1', Task(id: 1, title: 'Run stash_moor example', completed: true));
  // Retrieves the value from the cache
  final value = await cache.get('task1');

  print(value);
}
```

## Contributing

This library is developed by best effort, in the motto of "Scratch your own itch!", meaning APIs that are meaningful for the author use cases.

If you would like to contribute with other parts of the API, feel free to make a [Github pull request](https://github.com/ivoleitao/stash_moor/pulls) as I'm always looking for contributions for:
* Tests
* Documentation
* New APIs

## Features and Bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://github.com/ivoleitao/stash_moor/issues/new

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details