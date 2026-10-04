import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../database/app_database.dart';

/// Everything lives only in the on-device SQLite file, so a lost or reset
/// phone means lost history. This exports every table as one readable JSON
/// file and hands it to the system share sheet (save to Drive, email it to
/// yourself, etc.). Meal photos aren't included — only their paths.
class BackupService {
  final AppDatabase db;
  BackupService(this.db);

  Future<Map<String, dynamic>> buildSnapshot() async {
    final tables = <String, dynamic>{};
    for (final table in db.allTables) {
      final rows = await db.select(table as TableInfo<Table, DataClass>).get();
      tables[table.actualTableName] = [for (final r in rows) r.toJson()];
    }
    return {
      'app': 'the_system',
      'schemaVersion': db.schemaVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'tables': tables,
    };
  }

  /// Writes the snapshot to a temp file and opens the share sheet.
  Future<ShareResult> exportAndShare() async {
    final snapshot = await buildSnapshot();
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().toIso8601String().substring(0, 10);
    final file = File(p.join(dir.path, 'the_system_backup_$stamp.json'));
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(snapshot));
    return SharePlus.instance.share(ShareParams(
      files: [XFile(file.path, mimeType: 'application/json')],
      subject: 'The System backup ($stamp)',
    ));
  }
}
