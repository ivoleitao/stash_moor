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
