import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
// ignore: unused_import
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart'; // ensures native libs are bundled

/// Opens (or creates) the on-device SQLite file used by [AppDatabase].
/// Data persists across app restarts and device reboots — it lives in the
/// app's private documents directory and is not wiped unless the app is
/// uninstalled or the user clears app data manually.
QueryExecutor openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'the_system.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
