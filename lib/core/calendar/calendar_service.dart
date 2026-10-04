import 'package:device_calendar/device_calendar.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

import '../database/app_database.dart';
import '../providers/core_providers.dart';

/// Wraps `device_calendar` to schedule habits as real blocks on the
/// person's own device calendar, and to check whether a scheduled block
/// passed without the habit being logged — a "never got the chance"
/// outcome, tracked separately from an active choice to skip (see
/// HabitLogs.outcome). This reads/writes only the person's own calendar;
/// nothing here syncs to any server.
class CalendarService {
  final AppDatabase db;
  final DeviceCalendarPlugin _plugin = DeviceCalendarPlugin();
  CalendarService(this.db);

  Future<bool> hasPermissions() async {
    try {
      final result = await _plugin.hasPermissions();
      return result.data == true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestPermissions() async {
    try {
      var result = await _plugin.hasPermissions();
      if (result.data == true) return true;
      result = await _plugin.requestPermissions();
      return result.data ?? false;
    } catch (_) {
      return false;
    }
  }

  /// The first writable calendar on-device, or null if none / no
  /// permission. Kept simple (no calendar picker UI) since this is a
  /// single-user app — the person can adjust which calendar it is in
  /// their OS calendar app settings if they care.
  Future<Calendar?> _writableCalendar() async {
    try {
      final result = await _plugin.retrieveCalendars();
      final calendars = result.data ?? [];
      return calendars.cast<Calendar?>().firstWhere((c) => c?.isReadOnly == false, orElse: () => null);
    } catch (_) {
      return null;
    }
  }

  /// Creates (or replaces) today's calendar block for [habitId] at
  /// [scheduledTime] ("HH:mm") for [durationMin] minutes, and records the
  /// link in HabitCalendarEvents so it can be checked later. Returns false
  /// if calendar access isn't available — callers should treat that as
  /// "tracking still works, just without the calendar block."
  Future<bool> scheduleForToday(String habitId, String label, String scheduledTime, {int durationMin = 30}) async {
    if (!await requestPermissions()) return false;
    final calendar = await _writableCalendar();
    if (calendar?.id == null) return false;

    final parts = scheduledTime.split(':');
    if (parts.length != 2) return false;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return false;

    final now = DateTime.now();
    final start = DateTime(now.year, now.month, now.day, hour, minute);
    final end = start.add(Duration(minutes: durationMin));
    final dateKey = DateFormat('yyyy-MM-dd').format(now);

    // Don't double-schedule if today's block already exists at this time;
    // if the time changed, replace the old block.
    final existing = await (db.select(db.habitCalendarEvents)..where((t) => t.habitId.equals(habitId) & t.date.equals(dateKey))).getSingleOrNull();
    if (existing != null) {
      if (existing.scheduledStart == start && existing.scheduledEnd == end) return true;
      await cancelForToday(habitId);
    }

    try {
      final event = Event(calendar!.id, title: label, start: tz.TZDateTime.from(start, tz.local), end: tz.TZDateTime.from(end, tz.local));
      final createResult = await _plugin.createOrUpdateEvent(event);
      final eventId = createResult?.data;
      if (eventId == null) return false;

      await db.into(db.habitCalendarEvents).insert(HabitCalendarEventsCompanion(
            habitId: Value(habitId),
            date: Value(dateKey),
            eventId: Value(eventId),
            calendarId: Value(calendar.id!),
            scheduledStart: Value(start),
            scheduledEnd: Value(end),
          ));
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Creates today's block for every active habit that has a scheduled
  /// time. Called on launch and on day rollover so "scheduled" really means
  /// every day, not just the day the time was picked. Never prompts for
  /// permission — if access hasn't been granted yet this is a no-op.
  Future<void> scheduleTodayForAllHabits() async {
    if (!await hasPermissions()) return;
    final habits = await (db.select(db.habits)..where((t) => t.archived.equals(false) & t.scheduledTime.isNotNull())).get();
    for (final h in habits) {
      await scheduleForToday(h.id, h.label, h.scheduledTime!);
    }
  }

  Future<void> cancelForToday(String habitId) async {
    final dateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final existing = await (db.select(db.habitCalendarEvents)..where((t) => t.habitId.equals(habitId) & t.date.equals(dateKey))).getSingleOrNull();
    if (existing == null) return;
    try {
      await _plugin.deleteEvent(existing.calendarId, existing.eventId);
    } catch (_) {
      // Already gone from the calendar — still clean up our own record.
    }
    await (db.delete(db.habitCalendarEvents)..where((t) => t.habitId.equals(habitId) & t.date.equals(dateKey))).go();
  }

  /// Marks any scheduled block that has fully passed without the habit
  /// being logged as 'missed_opportunity' rather than leaving it blank —
  /// call this once at app launch alongside the streak reconciliation.
  /// Never overwrites an outcome that's already set (e.g. by an explicit
  /// skip action elsewhere).
  Future<void> reconcileMissedOpportunities(DateTime now) async {
    final pastEvents = await (db.select(db.habitCalendarEvents)..where((t) => t.scheduledEnd.isSmallerThanValue(now))).get();
    for (final event in pastEvents) {
      final log = await (db.select(db.habitLogs)..where((t) => t.habitId.equals(event.habitId) & t.date.equals(event.date))).getSingleOrNull();
      if (log?.done == true) continue; // logged — nothing to mark
      if (log?.outcome != null) continue; // already resolved one way or another

      await db.into(db.habitLogs).insertOnConflictUpdate(
            HabitLogsCompanion(
              habitId: Value(event.habitId),
              date: Value(event.date),
              done: const Value(false),
              outcome: const Value('missed_opportunity'),
            ),
          );
    }
  }
}

final calendarServiceProvider = Provider<CalendarService>((ref) {
  final db = ref.watch(databaseProvider);
  return CalendarService(db);
});
