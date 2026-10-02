// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DailyStateTable extends DailyState
    with TableInfo<$DailyStateTable, DailyStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _energyLevelMeta =
      const VerificationMeta('energyLevel');
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
      'energy_level', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sleepHoursMeta =
      const VerificationMeta('sleepHours');
  @override
  late final GeneratedColumn<double> sleepHours = GeneratedColumn<double>(
      'sleep_hours', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
      'steps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _gatePassedMeta =
      const VerificationMeta('gatePassed');
  @override
  late final GeneratedColumn<bool> gatePassed = GeneratedColumn<bool>(
      'gate_passed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("gate_passed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _gatePassedAtMeta =
      const VerificationMeta('gatePassedAt');
  @override
  late final GeneratedColumn<DateTime> gatePassedAt = GeneratedColumn<DateTime>(
      'gate_passed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        date,
        energyLevel,
        sleepHours,
        weightKg,
        steps,
        gatePassed,
        gatePassedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_state';
  @override
  VerificationContext validateIntegrity(Insertable<DailyStateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('energy_level')) {
      context.handle(
          _energyLevelMeta,
          energyLevel.isAcceptableOrUnknown(
              data['energy_level']!, _energyLevelMeta));
    }
    if (data.containsKey('sleep_hours')) {
      context.handle(
          _sleepHoursMeta,
          sleepHours.isAcceptableOrUnknown(
              data['sleep_hours']!, _sleepHoursMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    }
    if (data.containsKey('gate_passed')) {
      context.handle(
          _gatePassedMeta,
          gatePassed.isAcceptableOrUnknown(
              data['gate_passed']!, _gatePassedMeta));
    }
    if (data.containsKey('gate_passed_at')) {
      context.handle(
          _gatePassedAtMeta,
          gatePassedAt.isAcceptableOrUnknown(
              data['gate_passed_at']!, _gatePassedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  DailyStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyStateData(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      energyLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energy_level']),
      sleepHours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sleep_hours']),
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      steps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps']),
      gatePassed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gate_passed'])!,
      gatePassedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}gate_passed_at']),
    );
  }

  @override
  $DailyStateTable createAlias(String alias) {
    return $DailyStateTable(attachedDatabase, alias);
  }
}

class DailyStateData extends DataClass implements Insertable<DailyStateData> {
  final String date;
  final int? energyLevel;
  final double? sleepHours;
  final double? weightKg;
  final int? steps;
  final bool gatePassed;
  final DateTime? gatePassedAt;
  const DailyStateData(
      {required this.date,
      this.energyLevel,
      this.sleepHours,
      this.weightKg,
      this.steps,
      required this.gatePassed,
      this.gatePassedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<int>(energyLevel);
    }
    if (!nullToAbsent || sleepHours != null) {
      map['sleep_hours'] = Variable<double>(sleepHours);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<int>(steps);
    }
    map['gate_passed'] = Variable<bool>(gatePassed);
    if (!nullToAbsent || gatePassedAt != null) {
      map['gate_passed_at'] = Variable<DateTime>(gatePassedAt);
    }
    return map;
  }

  DailyStateCompanion toCompanion(bool nullToAbsent) {
    return DailyStateCompanion(
      date: Value(date),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      sleepHours: sleepHours == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepHours),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      steps:
          steps == null && nullToAbsent ? const Value.absent() : Value(steps),
      gatePassed: Value(gatePassed),
      gatePassedAt: gatePassedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(gatePassedAt),
    );
  }

  factory DailyStateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyStateData(
      date: serializer.fromJson<String>(json['date']),
      energyLevel: serializer.fromJson<int?>(json['energyLevel']),
      sleepHours: serializer.fromJson<double?>(json['sleepHours']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      steps: serializer.fromJson<int?>(json['steps']),
      gatePassed: serializer.fromJson<bool>(json['gatePassed']),
      gatePassedAt: serializer.fromJson<DateTime?>(json['gatePassedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'energyLevel': serializer.toJson<int?>(energyLevel),
      'sleepHours': serializer.toJson<double?>(sleepHours),
      'weightKg': serializer.toJson<double?>(weightKg),
      'steps': serializer.toJson<int?>(steps),
      'gatePassed': serializer.toJson<bool>(gatePassed),
      'gatePassedAt': serializer.toJson<DateTime?>(gatePassedAt),
    };
  }

  DailyStateData copyWith(
          {String? date,
          Value<int?> energyLevel = const Value.absent(),
          Value<double?> sleepHours = const Value.absent(),
          Value<double?> weightKg = const Value.absent(),
          Value<int?> steps = const Value.absent(),
          bool? gatePassed,
          Value<DateTime?> gatePassedAt = const Value.absent()}) =>
      DailyStateData(
        date: date ?? this.date,
        energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
        sleepHours: sleepHours.present ? sleepHours.value : this.sleepHours,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        steps: steps.present ? steps.value : this.steps,
        gatePassed: gatePassed ?? this.gatePassed,
        gatePassedAt:
            gatePassedAt.present ? gatePassedAt.value : this.gatePassedAt,
      );
  DailyStateData copyWithCompanion(DailyStateCompanion data) {
    return DailyStateData(
      date: data.date.present ? data.date.value : this.date,
      energyLevel:
          data.energyLevel.present ? data.energyLevel.value : this.energyLevel,
      sleepHours:
          data.sleepHours.present ? data.sleepHours.value : this.sleepHours,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      steps: data.steps.present ? data.steps.value : this.steps,
      gatePassed:
          data.gatePassed.present ? data.gatePassed.value : this.gatePassed,
      gatePassedAt: data.gatePassedAt.present
          ? data.gatePassedAt.value
          : this.gatePassedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyStateData(')
          ..write('date: $date, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('weightKg: $weightKg, ')
          ..write('steps: $steps, ')
          ..write('gatePassed: $gatePassed, ')
          ..write('gatePassedAt: $gatePassedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      date, energyLevel, sleepHours, weightKg, steps, gatePassed, gatePassedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyStateData &&
          other.date == this.date &&
          other.energyLevel == this.energyLevel &&
          other.sleepHours == this.sleepHours &&
          other.weightKg == this.weightKg &&
          other.steps == this.steps &&
          other.gatePassed == this.gatePassed &&
          other.gatePassedAt == this.gatePassedAt);
}

class DailyStateCompanion extends UpdateCompanion<DailyStateData> {
  final Value<String> date;
  final Value<int?> energyLevel;
  final Value<double?> sleepHours;
  final Value<double?> weightKg;
  final Value<int?> steps;
  final Value<bool> gatePassed;
  final Value<DateTime?> gatePassedAt;
  final Value<int> rowid;
  const DailyStateCompanion({
    this.date = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.steps = const Value.absent(),
    this.gatePassed = const Value.absent(),
    this.gatePassedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyStateCompanion.insert({
    required String date,
    this.energyLevel = const Value.absent(),
    this.sleepHours = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.steps = const Value.absent(),
    this.gatePassed = const Value.absent(),
    this.gatePassedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DailyStateData> custom({
    Expression<String>? date,
    Expression<int>? energyLevel,
    Expression<double>? sleepHours,
    Expression<double>? weightKg,
    Expression<int>? steps,
    Expression<bool>? gatePassed,
    Expression<DateTime>? gatePassedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (sleepHours != null) 'sleep_hours': sleepHours,
      if (weightKg != null) 'weight_kg': weightKg,
      if (steps != null) 'steps': steps,
      if (gatePassed != null) 'gate_passed': gatePassed,
      if (gatePassedAt != null) 'gate_passed_at': gatePassedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyStateCompanion copyWith(
      {Value<String>? date,
      Value<int?>? energyLevel,
      Value<double?>? sleepHours,
      Value<double?>? weightKg,
      Value<int?>? steps,
      Value<bool>? gatePassed,
      Value<DateTime?>? gatePassedAt,
      Value<int>? rowid}) {
    return DailyStateCompanion(
      date: date ?? this.date,
      energyLevel: energyLevel ?? this.energyLevel,
      sleepHours: sleepHours ?? this.sleepHours,
      weightKg: weightKg ?? this.weightKg,
      steps: steps ?? this.steps,
      gatePassed: gatePassed ?? this.gatePassed,
      gatePassedAt: gatePassedAt ?? this.gatePassedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (sleepHours.present) {
      map['sleep_hours'] = Variable<double>(sleepHours.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (gatePassed.present) {
      map['gate_passed'] = Variable<bool>(gatePassed.value);
    }
    if (gatePassedAt.present) {
      map['gate_passed_at'] = Variable<DateTime>(gatePassedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyStateCompanion(')
          ..write('date: $date, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('sleepHours: $sleepHours, ')
          ..write('weightKg: $weightKg, ')
          ..write('steps: $steps, ')
          ..write('gatePassed: $gatePassed, ')
          ..write('gatePassedAt: $gatePassedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('check'));
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isCoreMeta = const VerificationMeta('isCore');
  @override
  late final GeneratedColumn<bool> isCore = GeneratedColumn<bool>(
      'is_core', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_core" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _archivedMeta =
      const VerificationMeta('archived');
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
      'archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("archived" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<int> tier = GeneratedColumn<int>(
      'tier', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _scheduledTimeMeta =
      const VerificationMeta('scheduledTime');
  @override
  late final GeneratedColumn<String> scheduledTime = GeneratedColumn<String>(
      'scheduled_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, label, icon, sortOrder, isCore, archived, tier, scheduledTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    }
    if (data.containsKey('is_core')) {
      context.handle(_isCoreMeta,
          isCore.isAcceptableOrUnknown(data['is_core']!, _isCoreMeta));
    }
    if (data.containsKey('archived')) {
      context.handle(_archivedMeta,
          archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta));
    }
    if (data.containsKey('tier')) {
      context.handle(
          _tierMeta, tier.isAcceptableOrUnknown(data['tier']!, _tierMeta));
    }
    if (data.containsKey('scheduled_time')) {
      context.handle(
          _scheduledTimeMeta,
          scheduledTime.isAcceptableOrUnknown(
              data['scheduled_time']!, _scheduledTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isCore: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_core'])!,
      archived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}archived'])!,
      tier: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tier'])!,
      scheduledTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}scheduled_time']),
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String label;
  final String icon;
  final int sortOrder;
  final bool isCore;
  final bool archived;
  final int tier;
  final String? scheduledTime;
  const Habit(
      {required this.id,
      required this.label,
      required this.icon,
      required this.sortOrder,
      required this.isCore,
      required this.archived,
      required this.tier,
      this.scheduledTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['icon'] = Variable<String>(icon);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_core'] = Variable<bool>(isCore);
    map['archived'] = Variable<bool>(archived);
    map['tier'] = Variable<int>(tier);
    if (!nullToAbsent || scheduledTime != null) {
      map['scheduled_time'] = Variable<String>(scheduledTime);
    }
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      label: Value(label),
      icon: Value(icon),
      sortOrder: Value(sortOrder),
      isCore: Value(isCore),
      archived: Value(archived),
      tier: Value(tier),
      scheduledTime: scheduledTime == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledTime),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      icon: serializer.fromJson<String>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isCore: serializer.fromJson<bool>(json['isCore']),
      archived: serializer.fromJson<bool>(json['archived']),
      tier: serializer.fromJson<int>(json['tier']),
      scheduledTime: serializer.fromJson<String?>(json['scheduledTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'icon': serializer.toJson<String>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isCore': serializer.toJson<bool>(isCore),
      'archived': serializer.toJson<bool>(archived),
      'tier': serializer.toJson<int>(tier),
      'scheduledTime': serializer.toJson<String?>(scheduledTime),
    };
  }

  Habit copyWith(
          {String? id,
          String? label,
          String? icon,
          int? sortOrder,
          bool? isCore,
          bool? archived,
          int? tier,
          Value<String?> scheduledTime = const Value.absent()}) =>
      Habit(
        id: id ?? this.id,
        label: label ?? this.label,
        icon: icon ?? this.icon,
        sortOrder: sortOrder ?? this.sortOrder,
        isCore: isCore ?? this.isCore,
        archived: archived ?? this.archived,
        tier: tier ?? this.tier,
        scheduledTime:
            scheduledTime.present ? scheduledTime.value : this.scheduledTime,
      );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isCore: data.isCore.present ? data.isCore.value : this.isCore,
      archived: data.archived.present ? data.archived.value : this.archived,
      tier: data.tier.present ? data.tier.value : this.tier,
      scheduledTime: data.scheduledTime.present
          ? data.scheduledTime.value
          : this.scheduledTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isCore: $isCore, ')
          ..write('archived: $archived, ')
          ..write('tier: $tier, ')
          ..write('scheduledTime: $scheduledTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, label, icon, sortOrder, isCore, archived, tier, scheduledTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.label == this.label &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder &&
          other.isCore == this.isCore &&
          other.archived == this.archived &&
          other.tier == this.tier &&
          other.scheduledTime == this.scheduledTime);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> label;
  final Value<String> icon;
  final Value<int> sortOrder;
  final Value<bool> isCore;
  final Value<bool> archived;
  final Value<int> tier;
  final Value<String?> scheduledTime;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isCore = const Value.absent(),
    this.archived = const Value.absent(),
    this.tier = const Value.absent(),
    this.scheduledTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String label,
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isCore = const Value.absent(),
    this.archived = const Value.absent(),
    this.tier = const Value.absent(),
    this.scheduledTime = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        label = Value(label);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? label,
    Expression<String>? icon,
    Expression<int>? sortOrder,
    Expression<bool>? isCore,
    Expression<bool>? archived,
    Expression<int>? tier,
    Expression<String>? scheduledTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isCore != null) 'is_core': isCore,
      if (archived != null) 'archived': archived,
      if (tier != null) 'tier': tier,
      if (scheduledTime != null) 'scheduled_time': scheduledTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? label,
      Value<String>? icon,
      Value<int>? sortOrder,
      Value<bool>? isCore,
      Value<bool>? archived,
      Value<int>? tier,
      Value<String?>? scheduledTime,
      Value<int>? rowid}) {
    return HabitsCompanion(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      isCore: isCore ?? this.isCore,
      archived: archived ?? this.archived,
      tier: tier ?? this.tier,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isCore.present) {
      map['is_core'] = Variable<bool>(isCore.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (tier.present) {
      map['tier'] = Variable<int>(tier.value);
    }
    if (scheduledTime.present) {
      map['scheduled_time'] = Variable<String>(scheduledTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isCore: $isCore, ')
          ..write('archived: $archived, ')
          ..write('tier: $tier, ')
          ..write('scheduledTime: $scheduledTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _doneMeta = const VerificationMeta('done');
  @override
  late final GeneratedColumn<bool> done = GeneratedColumn<bool>(
      'done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("done" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _outcomeMeta =
      const VerificationMeta('outcome');
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
      'outcome', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [habitId, date, done, completedAt, outcome];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(Insertable<HabitLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('done')) {
      context.handle(
          _doneMeta, done.isAcceptableOrUnknown(data['done']!, _doneMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('outcome')) {
      context.handle(_outcomeMeta,
          outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, date};
  @override
  HabitLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLog(
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      done: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}done'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      outcome: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}outcome']),
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }
}

class HabitLog extends DataClass implements Insertable<HabitLog> {
  final String habitId;
  final String date;
  final bool done;
  final DateTime? completedAt;
  final String? outcome;
  const HabitLog(
      {required this.habitId,
      required this.date,
      required this.done,
      this.completedAt,
      this.outcome});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['date'] = Variable<String>(date);
    map['done'] = Variable<bool>(done);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || outcome != null) {
      map['outcome'] = Variable<String>(outcome);
    }
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      habitId: Value(habitId),
      date: Value(date),
      done: Value(done),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      outcome: outcome == null && nullToAbsent
          ? const Value.absent()
          : Value(outcome),
    );
  }

  factory HabitLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLog(
      habitId: serializer.fromJson<String>(json['habitId']),
      date: serializer.fromJson<String>(json['date']),
      done: serializer.fromJson<bool>(json['done']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      outcome: serializer.fromJson<String?>(json['outcome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'date': serializer.toJson<String>(date),
      'done': serializer.toJson<bool>(done),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'outcome': serializer.toJson<String?>(outcome),
    };
  }

  HabitLog copyWith(
          {String? habitId,
          String? date,
          bool? done,
          Value<DateTime?> completedAt = const Value.absent(),
          Value<String?> outcome = const Value.absent()}) =>
      HabitLog(
        habitId: habitId ?? this.habitId,
        date: date ?? this.date,
        done: done ?? this.done,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        outcome: outcome.present ? outcome.value : this.outcome,
      );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      done: data.done.present ? data.done.value : this.done,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('done: $done, ')
          ..write('completedAt: $completedAt, ')
          ..write('outcome: $outcome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(habitId, date, done, completedAt, outcome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.done == this.done &&
          other.completedAt == this.completedAt &&
          other.outcome == this.outcome);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<String> habitId;
  final Value<String> date;
  final Value<bool> done;
  final Value<DateTime?> completedAt;
  final Value<String?> outcome;
  final Value<int> rowid;
  const HabitLogsCompanion({
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.done = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.outcome = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    required String habitId,
    required String date,
    this.done = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.outcome = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : habitId = Value(habitId),
        date = Value(date);
  static Insertable<HabitLog> custom({
    Expression<String>? habitId,
    Expression<String>? date,
    Expression<bool>? done,
    Expression<DateTime>? completedAt,
    Expression<String>? outcome,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (done != null) 'done': done,
      if (completedAt != null) 'completed_at': completedAt,
      if (outcome != null) 'outcome': outcome,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitLogsCompanion copyWith(
      {Value<String>? habitId,
      Value<String>? date,
      Value<bool>? done,
      Value<DateTime?>? completedAt,
      Value<String?>? outcome,
      Value<int>? rowid}) {
    return HabitLogsCompanion(
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      done: done ?? this.done,
      completedAt: completedAt ?? this.completedAt,
      outcome: outcome ?? this.outcome,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (done.present) {
      map['done'] = Variable<bool>(done.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('done: $done, ')
          ..write('completedAt: $completedAt, ')
          ..write('outcome: $outcome, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StreakStateTable extends StreakState
    with TableInfo<$StreakStateTable, StreakStateData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StreakStateTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalPointsMeta =
      const VerificationMeta('totalPoints');
  @override
  late final GeneratedColumn<int> totalPoints = GeneratedColumn<int>(
      'total_points', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _streakFreezesAvailableMeta =
      const VerificationMeta('streakFreezesAvailable');
  @override
  late final GeneratedColumn<int> streakFreezesAvailable = GeneratedColumn<int>(
      'streak_freezes_available', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(2));
  static const VerificationMeta _lastCompletedDateMeta =
      const VerificationMeta('lastCompletedDate');
  @override
  late final GeneratedColumn<String> lastCompletedDate =
      GeneratedColumn<String>('last_completed_date', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastPenaltyDateMeta =
      const VerificationMeta('lastPenaltyDate');
  @override
  late final GeneratedColumn<String> lastPenaltyDate = GeneratedColumn<String>(
      'last_penalty_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        currentStreak,
        longestStreak,
        totalPoints,
        streakFreezesAvailable,
        lastCompletedDate,
        lastPenaltyDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'streak_state';
  @override
  VerificationContext validateIntegrity(Insertable<StreakStateData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('total_points')) {
      context.handle(
          _totalPointsMeta,
          totalPoints.isAcceptableOrUnknown(
              data['total_points']!, _totalPointsMeta));
    }
    if (data.containsKey('streak_freezes_available')) {
      context.handle(
          _streakFreezesAvailableMeta,
          streakFreezesAvailable.isAcceptableOrUnknown(
              data['streak_freezes_available']!, _streakFreezesAvailableMeta));
    }
    if (data.containsKey('last_completed_date')) {
      context.handle(
          _lastCompletedDateMeta,
          lastCompletedDate.isAcceptableOrUnknown(
              data['last_completed_date']!, _lastCompletedDateMeta));
    }
    if (data.containsKey('last_penalty_date')) {
      context.handle(
          _lastPenaltyDateMeta,
          lastPenaltyDate.isAcceptableOrUnknown(
              data['last_penalty_date']!, _lastPenaltyDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StreakStateData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StreakStateData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      totalPoints: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_points'])!,
      streakFreezesAvailable: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}streak_freezes_available'])!,
      lastCompletedDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_completed_date']),
      lastPenaltyDate: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}last_penalty_date']),
    );
  }

  @override
  $StreakStateTable createAlias(String alias) {
    return $StreakStateTable(attachedDatabase, alias);
  }
}

class StreakStateData extends DataClass implements Insertable<StreakStateData> {
  final int id;
  final int currentStreak;
  final int longestStreak;
  final int totalPoints;
  final int streakFreezesAvailable;
  final String? lastCompletedDate;
  final String? lastPenaltyDate;
  const StreakStateData(
      {required this.id,
      required this.currentStreak,
      required this.longestStreak,
      required this.totalPoints,
      required this.streakFreezesAvailable,
      this.lastCompletedDate,
      this.lastPenaltyDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    map['total_points'] = Variable<int>(totalPoints);
    map['streak_freezes_available'] = Variable<int>(streakFreezesAvailable);
    if (!nullToAbsent || lastCompletedDate != null) {
      map['last_completed_date'] = Variable<String>(lastCompletedDate);
    }
    if (!nullToAbsent || lastPenaltyDate != null) {
      map['last_penalty_date'] = Variable<String>(lastPenaltyDate);
    }
    return map;
  }

  StreakStateCompanion toCompanion(bool nullToAbsent) {
    return StreakStateCompanion(
      id: Value(id),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      totalPoints: Value(totalPoints),
      streakFreezesAvailable: Value(streakFreezesAvailable),
      lastCompletedDate: lastCompletedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCompletedDate),
      lastPenaltyDate: lastPenaltyDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPenaltyDate),
    );
  }

  factory StreakStateData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StreakStateData(
      id: serializer.fromJson<int>(json['id']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      totalPoints: serializer.fromJson<int>(json['totalPoints']),
      streakFreezesAvailable:
          serializer.fromJson<int>(json['streakFreezesAvailable']),
      lastCompletedDate:
          serializer.fromJson<String?>(json['lastCompletedDate']),
      lastPenaltyDate: serializer.fromJson<String?>(json['lastPenaltyDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'totalPoints': serializer.toJson<int>(totalPoints),
      'streakFreezesAvailable': serializer.toJson<int>(streakFreezesAvailable),
      'lastCompletedDate': serializer.toJson<String?>(lastCompletedDate),
      'lastPenaltyDate': serializer.toJson<String?>(lastPenaltyDate),
    };
  }

  StreakStateData copyWith(
          {int? id,
          int? currentStreak,
          int? longestStreak,
          int? totalPoints,
          int? streakFreezesAvailable,
          Value<String?> lastCompletedDate = const Value.absent(),
          Value<String?> lastPenaltyDate = const Value.absent()}) =>
      StreakStateData(
        id: id ?? this.id,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        totalPoints: totalPoints ?? this.totalPoints,
        streakFreezesAvailable:
            streakFreezesAvailable ?? this.streakFreezesAvailable,
        lastCompletedDate: lastCompletedDate.present
            ? lastCompletedDate.value
            : this.lastCompletedDate,
        lastPenaltyDate: lastPenaltyDate.present
            ? lastPenaltyDate.value
            : this.lastPenaltyDate,
      );
  StreakStateData copyWithCompanion(StreakStateCompanion data) {
    return StreakStateData(
      id: data.id.present ? data.id.value : this.id,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      totalPoints:
          data.totalPoints.present ? data.totalPoints.value : this.totalPoints,
      streakFreezesAvailable: data.streakFreezesAvailable.present
          ? data.streakFreezesAvailable.value
          : this.streakFreezesAvailable,
      lastCompletedDate: data.lastCompletedDate.present
          ? data.lastCompletedDate.value
          : this.lastCompletedDate,
      lastPenaltyDate: data.lastPenaltyDate.present
          ? data.lastPenaltyDate.value
          : this.lastPenaltyDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StreakStateData(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('streakFreezesAvailable: $streakFreezesAvailable, ')
          ..write('lastCompletedDate: $lastCompletedDate, ')
          ..write('lastPenaltyDate: $lastPenaltyDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, currentStreak, longestStreak, totalPoints,
      streakFreezesAvailable, lastCompletedDate, lastPenaltyDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StreakStateData &&
          other.id == this.id &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.totalPoints == this.totalPoints &&
          other.streakFreezesAvailable == this.streakFreezesAvailable &&
          other.lastCompletedDate == this.lastCompletedDate &&
          other.lastPenaltyDate == this.lastPenaltyDate);
}

class StreakStateCompanion extends UpdateCompanion<StreakStateData> {
  final Value<int> id;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<int> totalPoints;
  final Value<int> streakFreezesAvailable;
  final Value<String?> lastCompletedDate;
  final Value<String?> lastPenaltyDate;
  const StreakStateCompanion({
    this.id = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.streakFreezesAvailable = const Value.absent(),
    this.lastCompletedDate = const Value.absent(),
    this.lastPenaltyDate = const Value.absent(),
  });
  StreakStateCompanion.insert({
    this.id = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.totalPoints = const Value.absent(),
    this.streakFreezesAvailable = const Value.absent(),
    this.lastCompletedDate = const Value.absent(),
    this.lastPenaltyDate = const Value.absent(),
  });
  static Insertable<StreakStateData> custom({
    Expression<int>? id,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<int>? totalPoints,
    Expression<int>? streakFreezesAvailable,
    Expression<String>? lastCompletedDate,
    Expression<String>? lastPenaltyDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (totalPoints != null) 'total_points': totalPoints,
      if (streakFreezesAvailable != null)
        'streak_freezes_available': streakFreezesAvailable,
      if (lastCompletedDate != null) 'last_completed_date': lastCompletedDate,
      if (lastPenaltyDate != null) 'last_penalty_date': lastPenaltyDate,
    });
  }

  StreakStateCompanion copyWith(
      {Value<int>? id,
      Value<int>? currentStreak,
      Value<int>? longestStreak,
      Value<int>? totalPoints,
      Value<int>? streakFreezesAvailable,
      Value<String?>? lastCompletedDate,
      Value<String?>? lastPenaltyDate}) {
    return StreakStateCompanion(
      id: id ?? this.id,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalPoints: totalPoints ?? this.totalPoints,
      streakFreezesAvailable:
          streakFreezesAvailable ?? this.streakFreezesAvailable,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      lastPenaltyDate: lastPenaltyDate ?? this.lastPenaltyDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (totalPoints.present) {
      map['total_points'] = Variable<int>(totalPoints.value);
    }
    if (streakFreezesAvailable.present) {
      map['streak_freezes_available'] =
          Variable<int>(streakFreezesAvailable.value);
    }
    if (lastCompletedDate.present) {
      map['last_completed_date'] = Variable<String>(lastCompletedDate.value);
    }
    if (lastPenaltyDate.present) {
      map['last_penalty_date'] = Variable<String>(lastPenaltyDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StreakStateCompanion(')
          ..write('id: $id, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('totalPoints: $totalPoints, ')
          ..write('streakFreezesAvailable: $streakFreezesAvailable, ')
          ..write('lastCompletedDate: $lastCompletedDate, ')
          ..write('lastPenaltyDate: $lastPenaltyDate')
          ..write(')'))
        .toString();
  }
}

class $ExerciseLogsTable extends ExerciseLogs
    with TableInfo<$ExerciseLogsTable, ExerciseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMinMeta =
      const VerificationMeta('durationMin');
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
      'duration_min', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _energyRatingMeta =
      const VerificationMeta('energyRating');
  @override
  late final GeneratedColumn<int> energyRating = GeneratedColumn<int>(
      'energy_rating', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _muscleGroupMeta =
      const VerificationMeta('muscleGroup');
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
      'muscle_group', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        type,
        durationMin,
        energyRating,
        notes,
        createdAt,
        muscleGroup
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_logs';
  @override
  VerificationContext validateIntegrity(Insertable<ExerciseLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
          _durationMinMeta,
          durationMin.isAcceptableOrUnknown(
              data['duration_min']!, _durationMinMeta));
    }
    if (data.containsKey('energy_rating')) {
      context.handle(
          _energyRatingMeta,
          energyRating.isAcceptableOrUnknown(
              data['energy_rating']!, _energyRatingMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
          _muscleGroupMeta,
          muscleGroup.isAcceptableOrUnknown(
              data['muscle_group']!, _muscleGroupMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      durationMin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_min']),
      energyRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}energy_rating']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      muscleGroup: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}muscle_group']),
    );
  }

  @override
  $ExerciseLogsTable createAlias(String alias) {
    return $ExerciseLogsTable(attachedDatabase, alias);
  }
}

class ExerciseLog extends DataClass implements Insertable<ExerciseLog> {
  final String id;
  final String date;
  final String type;
  final int? durationMin;
  final int? energyRating;
  final String? notes;
  final DateTime createdAt;
  final String? muscleGroup;
  const ExerciseLog(
      {required this.id,
      required this.date,
      required this.type,
      this.durationMin,
      this.energyRating,
      this.notes,
      required this.createdAt,
      this.muscleGroup});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || durationMin != null) {
      map['duration_min'] = Variable<int>(durationMin);
    }
    if (!nullToAbsent || energyRating != null) {
      map['energy_rating'] = Variable<int>(energyRating);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || muscleGroup != null) {
      map['muscle_group'] = Variable<String>(muscleGroup);
    }
    return map;
  }

  ExerciseLogsCompanion toCompanion(bool nullToAbsent) {
    return ExerciseLogsCompanion(
      id: Value(id),
      date: Value(date),
      type: Value(type),
      durationMin: durationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMin),
      energyRating: energyRating == null && nullToAbsent
          ? const Value.absent()
          : Value(energyRating),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      muscleGroup: muscleGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleGroup),
    );
  }

  factory ExerciseLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseLog(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      type: serializer.fromJson<String>(json['type']),
      durationMin: serializer.fromJson<int?>(json['durationMin']),
      energyRating: serializer.fromJson<int?>(json['energyRating']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      muscleGroup: serializer.fromJson<String?>(json['muscleGroup']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'type': serializer.toJson<String>(type),
      'durationMin': serializer.toJson<int?>(durationMin),
      'energyRating': serializer.toJson<int?>(energyRating),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'muscleGroup': serializer.toJson<String?>(muscleGroup),
    };
  }

  ExerciseLog copyWith(
          {String? id,
          String? date,
          String? type,
          Value<int?> durationMin = const Value.absent(),
          Value<int?> energyRating = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          Value<String?> muscleGroup = const Value.absent()}) =>
      ExerciseLog(
        id: id ?? this.id,
        date: date ?? this.date,
        type: type ?? this.type,
        durationMin: durationMin.present ? durationMin.value : this.durationMin,
        energyRating:
            energyRating.present ? energyRating.value : this.energyRating,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        muscleGroup: muscleGroup.present ? muscleGroup.value : this.muscleGroup,
      );
  ExerciseLog copyWithCompanion(ExerciseLogsCompanion data) {
    return ExerciseLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      durationMin:
          data.durationMin.present ? data.durationMin.value : this.durationMin,
      energyRating: data.energyRating.present
          ? data.energyRating.value
          : this.energyRating,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      muscleGroup:
          data.muscleGroup.present ? data.muscleGroup.value : this.muscleGroup,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('durationMin: $durationMin, ')
          ..write('energyRating: $energyRating, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('muscleGroup: $muscleGroup')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, type, durationMin, energyRating, notes, createdAt, muscleGroup);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.type == this.type &&
          other.durationMin == this.durationMin &&
          other.energyRating == this.energyRating &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.muscleGroup == this.muscleGroup);
}

class ExerciseLogsCompanion extends UpdateCompanion<ExerciseLog> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> type;
  final Value<int?> durationMin;
  final Value<int?> energyRating;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<String?> muscleGroup;
  final Value<int> rowid;
  const ExerciseLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.energyRating = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseLogsCompanion.insert({
    required String id,
    required String date,
    required String type,
    this.durationMin = const Value.absent(),
    this.energyRating = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        type = Value(type);
  static Insertable<ExerciseLog> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? type,
    Expression<int>? durationMin,
    Expression<int>? energyRating,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<String>? muscleGroup,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (durationMin != null) 'duration_min': durationMin,
      if (energyRating != null) 'energy_rating': energyRating,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String>? type,
      Value<int?>? durationMin,
      Value<int?>? energyRating,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<String?>? muscleGroup,
      Value<int>? rowid}) {
    return ExerciseLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      durationMin: durationMin ?? this.durationMin,
      energyRating: energyRating ?? this.energyRating,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (energyRating.present) {
      map['energy_rating'] = Variable<int>(energyRating.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('durationMin: $durationMin, ')
          ..write('energyRating: $energyRating, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bedtimeMeta =
      const VerificationMeta('bedtime');
  @override
  late final GeneratedColumn<String> bedtime = GeneratedColumn<String>(
      'bedtime', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _wakeTimeMeta =
      const VerificationMeta('wakeTime');
  @override
  late final GeneratedColumn<String> wakeTime = GeneratedColumn<String>(
      'wake_time', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hoursMeta = const VerificationMeta('hours');
  @override
  late final GeneratedColumn<double> hours = GeneratedColumn<double>(
      'hours', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _qualityMeta =
      const VerificationMeta('quality');
  @override
  late final GeneratedColumn<int> quality = GeneratedColumn<int>(
      'quality', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, bedtime, wakeTime, hours, quality];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SleepLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('bedtime')) {
      context.handle(_bedtimeMeta,
          bedtime.isAcceptableOrUnknown(data['bedtime']!, _bedtimeMeta));
    }
    if (data.containsKey('wake_time')) {
      context.handle(_wakeTimeMeta,
          wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta));
    }
    if (data.containsKey('hours')) {
      context.handle(
          _hoursMeta, hours.isAcceptableOrUnknown(data['hours']!, _hoursMeta));
    }
    if (data.containsKey('quality')) {
      context.handle(_qualityMeta,
          quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      bedtime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}bedtime']),
      wakeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wake_time']),
      hours: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hours']),
      quality: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quality']),
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final String id;
  final String date;
  final String? bedtime;
  final String? wakeTime;
  final double? hours;
  final int? quality;
  const SleepLog(
      {required this.id,
      required this.date,
      this.bedtime,
      this.wakeTime,
      this.hours,
      this.quality});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || bedtime != null) {
      map['bedtime'] = Variable<String>(bedtime);
    }
    if (!nullToAbsent || wakeTime != null) {
      map['wake_time'] = Variable<String>(wakeTime);
    }
    if (!nullToAbsent || hours != null) {
      map['hours'] = Variable<double>(hours);
    }
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<int>(quality);
    }
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      date: Value(date),
      bedtime: bedtime == null && nullToAbsent
          ? const Value.absent()
          : Value(bedtime),
      wakeTime: wakeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(wakeTime),
      hours:
          hours == null && nullToAbsent ? const Value.absent() : Value(hours),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
    );
  }

  factory SleepLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      bedtime: serializer.fromJson<String?>(json['bedtime']),
      wakeTime: serializer.fromJson<String?>(json['wakeTime']),
      hours: serializer.fromJson<double?>(json['hours']),
      quality: serializer.fromJson<int?>(json['quality']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'bedtime': serializer.toJson<String?>(bedtime),
      'wakeTime': serializer.toJson<String?>(wakeTime),
      'hours': serializer.toJson<double?>(hours),
      'quality': serializer.toJson<int?>(quality),
    };
  }

  SleepLog copyWith(
          {String? id,
          String? date,
          Value<String?> bedtime = const Value.absent(),
          Value<String?> wakeTime = const Value.absent(),
          Value<double?> hours = const Value.absent(),
          Value<int?> quality = const Value.absent()}) =>
      SleepLog(
        id: id ?? this.id,
        date: date ?? this.date,
        bedtime: bedtime.present ? bedtime.value : this.bedtime,
        wakeTime: wakeTime.present ? wakeTime.value : this.wakeTime,
        hours: hours.present ? hours.value : this.hours,
        quality: quality.present ? quality.value : this.quality,
      );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      bedtime: data.bedtime.present ? data.bedtime.value : this.bedtime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      hours: data.hours.present ? data.hours.value : this.hours,
      quality: data.quality.present ? data.quality.value : this.quality,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('hours: $hours, ')
          ..write('quality: $quality')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, bedtime, wakeTime, hours, quality);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.bedtime == this.bedtime &&
          other.wakeTime == this.wakeTime &&
          other.hours == this.hours &&
          other.quality == this.quality);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<String> id;
  final Value<String> date;
  final Value<String?> bedtime;
  final Value<String?> wakeTime;
  final Value<double?> hours;
  final Value<int?> quality;
  final Value<int> rowid;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.bedtime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.hours = const Value.absent(),
    this.quality = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    required String id,
    required String date,
    this.bedtime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.hours = const Value.absent(),
    this.quality = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<SleepLog> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? bedtime,
    Expression<String>? wakeTime,
    Expression<double>? hours,
    Expression<int>? quality,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (bedtime != null) 'bedtime': bedtime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (hours != null) 'hours': hours,
      if (quality != null) 'quality': quality,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String?>? bedtime,
      Value<String?>? wakeTime,
      Value<double?>? hours,
      Value<int?>? quality,
      Value<int>? rowid}) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      bedtime: bedtime ?? this.bedtime,
      wakeTime: wakeTime ?? this.wakeTime,
      hours: hours ?? this.hours,
      quality: quality ?? this.quality,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (bedtime.present) {
      map['bedtime'] = Variable<String>(bedtime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<String>(wakeTime.value);
    }
    if (hours.present) {
      map['hours'] = Variable<double>(hours.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('bedtime: $bedtime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('hours: $hours, ')
          ..write('quality: $quality, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightLogsTable extends WeightLogs
    with TableInfo<$WeightLogsTable, WeightLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, weightKg, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_logs';
  @override
  VerificationContext validateIntegrity(Insertable<WeightLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
    );
  }

  @override
  $WeightLogsTable createAlias(String alias) {
    return $WeightLogsTable(attachedDatabase, alias);
  }
}

class WeightLog extends DataClass implements Insertable<WeightLog> {
  final String id;
  final String date;
  final double weightKg;
  final String? notes;
  const WeightLog(
      {required this.id,
      required this.date,
      required this.weightKg,
      this.notes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  WeightLogsCompanion toCompanion(bool nullToAbsent) {
    return WeightLogsCompanion(
      id: Value(id),
      date: Value(date),
      weightKg: Value(weightKg),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory WeightLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightLog(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'weightKg': serializer.toJson<double>(weightKg),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  WeightLog copyWith(
          {String? id,
          String? date,
          double? weightKg,
          Value<String?> notes = const Value.absent()}) =>
      WeightLog(
        id: id ?? this.id,
        date: date ?? this.date,
        weightKg: weightKg ?? this.weightKg,
        notes: notes.present ? notes.value : this.notes,
      );
  WeightLog copyWithCompanion(WeightLogsCompanion data) {
    return WeightLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, weightKg, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.weightKg == this.weightKg &&
          other.notes == this.notes);
}

class WeightLogsCompanion extends UpdateCompanion<WeightLog> {
  final Value<String> id;
  final Value<String> date;
  final Value<double> weightKg;
  final Value<String?> notes;
  final Value<int> rowid;
  const WeightLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeightLogsCompanion.insert({
    required String id,
    required String date,
    required double weightKg,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        weightKg = Value(weightKg);
  static Insertable<WeightLog> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<double>? weightKg,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (weightKg != null) 'weight_kg': weightKg,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeightLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<double>? weightKg,
      Value<String?>? notes,
      Value<int>? rowid}) {
    return WeightLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningLogsTable extends LearningLogs
    with TableInfo<$LearningLogsTable, LearningLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subjectMeta =
      const VerificationMeta('subject');
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
      'subject', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMinMeta =
      const VerificationMeta('durationMin');
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
      'duration_min', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _focusRatingMeta =
      const VerificationMeta('focusRating');
  @override
  late final GeneratedColumn<int> focusRating = GeneratedColumn<int>(
      'focus_rating', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, subject, durationMin, focusRating];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_logs';
  @override
  VerificationContext validateIntegrity(Insertable<LearningLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
          _durationMinMeta,
          durationMin.isAcceptableOrUnknown(
              data['duration_min']!, _durationMinMeta));
    }
    if (data.containsKey('focus_rating')) {
      context.handle(
          _focusRatingMeta,
          focusRating.isAcceptableOrUnknown(
              data['focus_rating']!, _focusRatingMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      subject: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject'])!,
      durationMin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_min']),
      focusRating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}focus_rating']),
    );
  }

  @override
  $LearningLogsTable createAlias(String alias) {
    return $LearningLogsTable(attachedDatabase, alias);
  }
}

class LearningLog extends DataClass implements Insertable<LearningLog> {
  final String id;
  final String date;
  final String subject;
  final int? durationMin;
  final int? focusRating;
  const LearningLog(
      {required this.id,
      required this.date,
      required this.subject,
      this.durationMin,
      this.focusRating});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['subject'] = Variable<String>(subject);
    if (!nullToAbsent || durationMin != null) {
      map['duration_min'] = Variable<int>(durationMin);
    }
    if (!nullToAbsent || focusRating != null) {
      map['focus_rating'] = Variable<int>(focusRating);
    }
    return map;
  }

  LearningLogsCompanion toCompanion(bool nullToAbsent) {
    return LearningLogsCompanion(
      id: Value(id),
      date: Value(date),
      subject: Value(subject),
      durationMin: durationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMin),
      focusRating: focusRating == null && nullToAbsent
          ? const Value.absent()
          : Value(focusRating),
    );
  }

  factory LearningLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningLog(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      subject: serializer.fromJson<String>(json['subject']),
      durationMin: serializer.fromJson<int?>(json['durationMin']),
      focusRating: serializer.fromJson<int?>(json['focusRating']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'subject': serializer.toJson<String>(subject),
      'durationMin': serializer.toJson<int?>(durationMin),
      'focusRating': serializer.toJson<int?>(focusRating),
    };
  }

  LearningLog copyWith(
          {String? id,
          String? date,
          String? subject,
          Value<int?> durationMin = const Value.absent(),
          Value<int?> focusRating = const Value.absent()}) =>
      LearningLog(
        id: id ?? this.id,
        date: date ?? this.date,
        subject: subject ?? this.subject,
        durationMin: durationMin.present ? durationMin.value : this.durationMin,
        focusRating: focusRating.present ? focusRating.value : this.focusRating,
      );
  LearningLog copyWithCompanion(LearningLogsCompanion data) {
    return LearningLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      subject: data.subject.present ? data.subject.value : this.subject,
      durationMin:
          data.durationMin.present ? data.durationMin.value : this.durationMin,
      focusRating:
          data.focusRating.present ? data.focusRating.value : this.focusRating,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('subject: $subject, ')
          ..write('durationMin: $durationMin, ')
          ..write('focusRating: $focusRating')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, subject, durationMin, focusRating);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.subject == this.subject &&
          other.durationMin == this.durationMin &&
          other.focusRating == this.focusRating);
}

class LearningLogsCompanion extends UpdateCompanion<LearningLog> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> subject;
  final Value<int?> durationMin;
  final Value<int?> focusRating;
  final Value<int> rowid;
  const LearningLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.subject = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.focusRating = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningLogsCompanion.insert({
    required String id,
    required String date,
    required String subject,
    this.durationMin = const Value.absent(),
    this.focusRating = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        subject = Value(subject);
  static Insertable<LearningLog> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? subject,
    Expression<int>? durationMin,
    Expression<int>? focusRating,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (subject != null) 'subject': subject,
      if (durationMin != null) 'duration_min': durationMin,
      if (focusRating != null) 'focus_rating': focusRating,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String>? subject,
      Value<int?>? durationMin,
      Value<int?>? focusRating,
      Value<int>? rowid}) {
    return LearningLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      subject: subject ?? this.subject,
      durationMin: durationMin ?? this.durationMin,
      focusRating: focusRating ?? this.focusRating,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (focusRating.present) {
      map['focus_rating'] = Variable<int>(focusRating.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('subject: $subject, ')
          ..write('durationMin: $durationMin, ')
          ..write('focusRating: $focusRating, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MartialArtsLogsTable extends MartialArtsLogs
    with TableInfo<$MartialArtsLogsTable, MartialArtsLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MartialArtsLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _focusMeta = const VerificationMeta('focus');
  @override
  late final GeneratedColumn<String> focus = GeneratedColumn<String>(
      'focus', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
      'rank', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, focus, rank, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'martial_arts_logs';
  @override
  VerificationContext validateIntegrity(Insertable<MartialArtsLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('focus')) {
      context.handle(
          _focusMeta, focus.isAcceptableOrUnknown(data['focus']!, _focusMeta));
    }
    if (data.containsKey('rank')) {
      context.handle(
          _rankMeta, rank.isAcceptableOrUnknown(data['rank']!, _rankMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MartialArtsLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MartialArtsLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      focus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}focus']),
      rank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rank']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $MartialArtsLogsTable createAlias(String alias) {
    return $MartialArtsLogsTable(attachedDatabase, alias);
  }
}

class MartialArtsLog extends DataClass implements Insertable<MartialArtsLog> {
  final String id;
  final String date;
  final String? focus;
  final String? rank;
  final String? note;
  const MartialArtsLog(
      {required this.id, required this.date, this.focus, this.rank, this.note});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || focus != null) {
      map['focus'] = Variable<String>(focus);
    }
    if (!nullToAbsent || rank != null) {
      map['rank'] = Variable<String>(rank);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  MartialArtsLogsCompanion toCompanion(bool nullToAbsent) {
    return MartialArtsLogsCompanion(
      id: Value(id),
      date: Value(date),
      focus:
          focus == null && nullToAbsent ? const Value.absent() : Value(focus),
      rank: rank == null && nullToAbsent ? const Value.absent() : Value(rank),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory MartialArtsLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MartialArtsLog(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      focus: serializer.fromJson<String?>(json['focus']),
      rank: serializer.fromJson<String?>(json['rank']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'focus': serializer.toJson<String?>(focus),
      'rank': serializer.toJson<String?>(rank),
      'note': serializer.toJson<String?>(note),
    };
  }

  MartialArtsLog copyWith(
          {String? id,
          String? date,
          Value<String?> focus = const Value.absent(),
          Value<String?> rank = const Value.absent(),
          Value<String?> note = const Value.absent()}) =>
      MartialArtsLog(
        id: id ?? this.id,
        date: date ?? this.date,
        focus: focus.present ? focus.value : this.focus,
        rank: rank.present ? rank.value : this.rank,
        note: note.present ? note.value : this.note,
      );
  MartialArtsLog copyWithCompanion(MartialArtsLogsCompanion data) {
    return MartialArtsLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      focus: data.focus.present ? data.focus.value : this.focus,
      rank: data.rank.present ? data.rank.value : this.rank,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MartialArtsLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('focus: $focus, ')
          ..write('rank: $rank, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, focus, rank, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MartialArtsLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.focus == this.focus &&
          other.rank == this.rank &&
          other.note == this.note);
}

class MartialArtsLogsCompanion extends UpdateCompanion<MartialArtsLog> {
  final Value<String> id;
  final Value<String> date;
  final Value<String?> focus;
  final Value<String?> rank;
  final Value<String?> note;
  final Value<int> rowid;
  const MartialArtsLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.focus = const Value.absent(),
    this.rank = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MartialArtsLogsCompanion.insert({
    required String id,
    required String date,
    this.focus = const Value.absent(),
    this.rank = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<MartialArtsLog> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? focus,
    Expression<String>? rank,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (focus != null) 'focus': focus,
      if (rank != null) 'rank': rank,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MartialArtsLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String?>? focus,
      Value<String?>? rank,
      Value<String?>? note,
      Value<int>? rowid}) {
    return MartialArtsLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      focus: focus ?? this.focus,
      rank: rank ?? this.rank,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (focus.present) {
      map['focus'] = Variable<String>(focus.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MartialArtsLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('focus: $focus, ')
          ..write('rank: $rank, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HobbyLogsTable extends HobbyLogs
    with TableInfo<$HobbyLogsTable, HobbyLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HobbyLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hobbyMeta = const VerificationMeta('hobby');
  @override
  late final GeneratedColumn<String> hobby = GeneratedColumn<String>(
      'hobby', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMinMeta =
      const VerificationMeta('durationMin');
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
      'duration_min', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, category, hobby, durationMin];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hobby_logs';
  @override
  VerificationContext validateIntegrity(Insertable<HobbyLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('hobby')) {
      context.handle(
          _hobbyMeta, hobby.isAcceptableOrUnknown(data['hobby']!, _hobbyMeta));
    } else if (isInserting) {
      context.missing(_hobbyMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
          _durationMinMeta,
          durationMin.isAcceptableOrUnknown(
              data['duration_min']!, _durationMinMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HobbyLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HobbyLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      hobby: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}hobby'])!,
      durationMin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_min']),
    );
  }

  @override
  $HobbyLogsTable createAlias(String alias) {
    return $HobbyLogsTable(attachedDatabase, alias);
  }
}

class HobbyLog extends DataClass implements Insertable<HobbyLog> {
  final String id;
  final String date;
  final String category;
  final String hobby;
  final int? durationMin;
  const HobbyLog(
      {required this.id,
      required this.date,
      required this.category,
      required this.hobby,
      this.durationMin});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['category'] = Variable<String>(category);
    map['hobby'] = Variable<String>(hobby);
    if (!nullToAbsent || durationMin != null) {
      map['duration_min'] = Variable<int>(durationMin);
    }
    return map;
  }

  HobbyLogsCompanion toCompanion(bool nullToAbsent) {
    return HobbyLogsCompanion(
      id: Value(id),
      date: Value(date),
      category: Value(category),
      hobby: Value(hobby),
      durationMin: durationMin == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMin),
    );
  }

  factory HobbyLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HobbyLog(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      category: serializer.fromJson<String>(json['category']),
      hobby: serializer.fromJson<String>(json['hobby']),
      durationMin: serializer.fromJson<int?>(json['durationMin']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'category': serializer.toJson<String>(category),
      'hobby': serializer.toJson<String>(hobby),
      'durationMin': serializer.toJson<int?>(durationMin),
    };
  }

  HobbyLog copyWith(
          {String? id,
          String? date,
          String? category,
          String? hobby,
          Value<int?> durationMin = const Value.absent()}) =>
      HobbyLog(
        id: id ?? this.id,
        date: date ?? this.date,
        category: category ?? this.category,
        hobby: hobby ?? this.hobby,
        durationMin: durationMin.present ? durationMin.value : this.durationMin,
      );
  HobbyLog copyWithCompanion(HobbyLogsCompanion data) {
    return HobbyLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      category: data.category.present ? data.category.value : this.category,
      hobby: data.hobby.present ? data.hobby.value : this.hobby,
      durationMin:
          data.durationMin.present ? data.durationMin.value : this.durationMin,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HobbyLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('hobby: $hobby, ')
          ..write('durationMin: $durationMin')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, category, hobby, durationMin);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HobbyLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.category == this.category &&
          other.hobby == this.hobby &&
          other.durationMin == this.durationMin);
}

class HobbyLogsCompanion extends UpdateCompanion<HobbyLog> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> category;
  final Value<String> hobby;
  final Value<int?> durationMin;
  final Value<int> rowid;
  const HobbyLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.category = const Value.absent(),
    this.hobby = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HobbyLogsCompanion.insert({
    required String id,
    required String date,
    required String category,
    required String hobby,
    this.durationMin = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        category = Value(category),
        hobby = Value(hobby);
  static Insertable<HobbyLog> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? category,
    Expression<String>? hobby,
    Expression<int>? durationMin,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (category != null) 'category': category,
      if (hobby != null) 'hobby': hobby,
      if (durationMin != null) 'duration_min': durationMin,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HobbyLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String>? category,
      Value<String>? hobby,
      Value<int?>? durationMin,
      Value<int>? rowid}) {
    return HobbyLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      category: category ?? this.category,
      hobby: hobby ?? this.hobby,
      durationMin: durationMin ?? this.durationMin,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (hobby.present) {
      map['hobby'] = Variable<String>(hobby.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HobbyLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('category: $category, ')
          ..write('hobby: $hobby, ')
          ..write('durationMin: $durationMin, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NutritionLogsTable extends NutritionLogs
    with TableInfo<$NutritionLogsTable, NutritionLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mealMeta = const VerificationMeta('meal');
  @override
  late final GeneratedColumn<String> meal = GeneratedColumn<String>(
      'meal', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _onPlanMeta = const VerificationMeta('onPlan');
  @override
  late final GeneratedColumn<bool> onPlan = GeneratedColumn<bool>(
      'on_plan', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("on_plan" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _photoPathMeta =
      const VerificationMeta('photoPath');
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
      'photo_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _estCaloriesMeta =
      const VerificationMeta('estCalories');
  @override
  late final GeneratedColumn<double> estCalories = GeneratedColumn<double>(
      'est_calories', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _estProteinGMeta =
      const VerificationMeta('estProteinG');
  @override
  late final GeneratedColumn<double> estProteinG = GeneratedColumn<double>(
      'est_protein_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _estCarbsGMeta =
      const VerificationMeta('estCarbsG');
  @override
  late final GeneratedColumn<double> estCarbsG = GeneratedColumn<double>(
      'est_carbs_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _estFatGMeta =
      const VerificationMeta('estFatG');
  @override
  late final GeneratedColumn<double> estFatG = GeneratedColumn<double>(
      'est_fat_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _aiEstimatedMeta =
      const VerificationMeta('aiEstimated');
  @override
  late final GeneratedColumn<bool> aiEstimated = GeneratedColumn<bool>(
      'ai_estimated', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("ai_estimated" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        date,
        meal,
        description,
        onPlan,
        photoPath,
        estCalories,
        estProteinG,
        estCarbsG,
        estFatG,
        aiEstimated
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_logs';
  @override
  VerificationContext validateIntegrity(Insertable<NutritionLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('meal')) {
      context.handle(
          _mealMeta, meal.isAcceptableOrUnknown(data['meal']!, _mealMeta));
    } else if (isInserting) {
      context.missing(_mealMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('on_plan')) {
      context.handle(_onPlanMeta,
          onPlan.isAcceptableOrUnknown(data['on_plan']!, _onPlanMeta));
    }
    if (data.containsKey('photo_path')) {
      context.handle(_photoPathMeta,
          photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta));
    }
    if (data.containsKey('est_calories')) {
      context.handle(
          _estCaloriesMeta,
          estCalories.isAcceptableOrUnknown(
              data['est_calories']!, _estCaloriesMeta));
    }
    if (data.containsKey('est_protein_g')) {
      context.handle(
          _estProteinGMeta,
          estProteinG.isAcceptableOrUnknown(
              data['est_protein_g']!, _estProteinGMeta));
    }
    if (data.containsKey('est_carbs_g')) {
      context.handle(
          _estCarbsGMeta,
          estCarbsG.isAcceptableOrUnknown(
              data['est_carbs_g']!, _estCarbsGMeta));
    }
    if (data.containsKey('est_fat_g')) {
      context.handle(_estFatGMeta,
          estFatG.isAcceptableOrUnknown(data['est_fat_g']!, _estFatGMeta));
    }
    if (data.containsKey('ai_estimated')) {
      context.handle(
          _aiEstimatedMeta,
          aiEstimated.isAcceptableOrUnknown(
              data['ai_estimated']!, _aiEstimatedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      meal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      onPlan: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}on_plan'])!,
      photoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_path']),
      estCalories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}est_calories']),
      estProteinG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}est_protein_g']),
      estCarbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}est_carbs_g']),
      estFatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}est_fat_g']),
      aiEstimated: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}ai_estimated'])!,
    );
  }

  @override
  $NutritionLogsTable createAlias(String alias) {
    return $NutritionLogsTable(attachedDatabase, alias);
  }
}

class NutritionLog extends DataClass implements Insertable<NutritionLog> {
  final String id;
  final String date;
  final String meal;
  final String description;
  final bool onPlan;
  final String? photoPath;
  final double? estCalories;
  final double? estProteinG;
  final double? estCarbsG;
  final double? estFatG;
  final bool aiEstimated;
  const NutritionLog(
      {required this.id,
      required this.date,
      required this.meal,
      required this.description,
      required this.onPlan,
      this.photoPath,
      this.estCalories,
      this.estProteinG,
      this.estCarbsG,
      this.estFatG,
      required this.aiEstimated});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    map['meal'] = Variable<String>(meal);
    map['description'] = Variable<String>(description);
    map['on_plan'] = Variable<bool>(onPlan);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    if (!nullToAbsent || estCalories != null) {
      map['est_calories'] = Variable<double>(estCalories);
    }
    if (!nullToAbsent || estProteinG != null) {
      map['est_protein_g'] = Variable<double>(estProteinG);
    }
    if (!nullToAbsent || estCarbsG != null) {
      map['est_carbs_g'] = Variable<double>(estCarbsG);
    }
    if (!nullToAbsent || estFatG != null) {
      map['est_fat_g'] = Variable<double>(estFatG);
    }
    map['ai_estimated'] = Variable<bool>(aiEstimated);
    return map;
  }

  NutritionLogsCompanion toCompanion(bool nullToAbsent) {
    return NutritionLogsCompanion(
      id: Value(id),
      date: Value(date),
      meal: Value(meal),
      description: Value(description),
      onPlan: Value(onPlan),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      estCalories: estCalories == null && nullToAbsent
          ? const Value.absent()
          : Value(estCalories),
      estProteinG: estProteinG == null && nullToAbsent
          ? const Value.absent()
          : Value(estProteinG),
      estCarbsG: estCarbsG == null && nullToAbsent
          ? const Value.absent()
          : Value(estCarbsG),
      estFatG: estFatG == null && nullToAbsent
          ? const Value.absent()
          : Value(estFatG),
      aiEstimated: Value(aiEstimated),
    );
  }

  factory NutritionLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionLog(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      meal: serializer.fromJson<String>(json['meal']),
      description: serializer.fromJson<String>(json['description']),
      onPlan: serializer.fromJson<bool>(json['onPlan']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      estCalories: serializer.fromJson<double?>(json['estCalories']),
      estProteinG: serializer.fromJson<double?>(json['estProteinG']),
      estCarbsG: serializer.fromJson<double?>(json['estCarbsG']),
      estFatG: serializer.fromJson<double?>(json['estFatG']),
      aiEstimated: serializer.fromJson<bool>(json['aiEstimated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'meal': serializer.toJson<String>(meal),
      'description': serializer.toJson<String>(description),
      'onPlan': serializer.toJson<bool>(onPlan),
      'photoPath': serializer.toJson<String?>(photoPath),
      'estCalories': serializer.toJson<double?>(estCalories),
      'estProteinG': serializer.toJson<double?>(estProteinG),
      'estCarbsG': serializer.toJson<double?>(estCarbsG),
      'estFatG': serializer.toJson<double?>(estFatG),
      'aiEstimated': serializer.toJson<bool>(aiEstimated),
    };
  }

  NutritionLog copyWith(
          {String? id,
          String? date,
          String? meal,
          String? description,
          bool? onPlan,
          Value<String?> photoPath = const Value.absent(),
          Value<double?> estCalories = const Value.absent(),
          Value<double?> estProteinG = const Value.absent(),
          Value<double?> estCarbsG = const Value.absent(),
          Value<double?> estFatG = const Value.absent(),
          bool? aiEstimated}) =>
      NutritionLog(
        id: id ?? this.id,
        date: date ?? this.date,
        meal: meal ?? this.meal,
        description: description ?? this.description,
        onPlan: onPlan ?? this.onPlan,
        photoPath: photoPath.present ? photoPath.value : this.photoPath,
        estCalories: estCalories.present ? estCalories.value : this.estCalories,
        estProteinG: estProteinG.present ? estProteinG.value : this.estProteinG,
        estCarbsG: estCarbsG.present ? estCarbsG.value : this.estCarbsG,
        estFatG: estFatG.present ? estFatG.value : this.estFatG,
        aiEstimated: aiEstimated ?? this.aiEstimated,
      );
  NutritionLog copyWithCompanion(NutritionLogsCompanion data) {
    return NutritionLog(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      meal: data.meal.present ? data.meal.value : this.meal,
      description:
          data.description.present ? data.description.value : this.description,
      onPlan: data.onPlan.present ? data.onPlan.value : this.onPlan,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      estCalories:
          data.estCalories.present ? data.estCalories.value : this.estCalories,
      estProteinG:
          data.estProteinG.present ? data.estProteinG.value : this.estProteinG,
      estCarbsG: data.estCarbsG.present ? data.estCarbsG.value : this.estCarbsG,
      estFatG: data.estFatG.present ? data.estFatG.value : this.estFatG,
      aiEstimated:
          data.aiEstimated.present ? data.aiEstimated.value : this.aiEstimated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionLog(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('meal: $meal, ')
          ..write('description: $description, ')
          ..write('onPlan: $onPlan, ')
          ..write('photoPath: $photoPath, ')
          ..write('estCalories: $estCalories, ')
          ..write('estProteinG: $estProteinG, ')
          ..write('estCarbsG: $estCarbsG, ')
          ..write('estFatG: $estFatG, ')
          ..write('aiEstimated: $aiEstimated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, meal, description, onPlan,
      photoPath, estCalories, estProteinG, estCarbsG, estFatG, aiEstimated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionLog &&
          other.id == this.id &&
          other.date == this.date &&
          other.meal == this.meal &&
          other.description == this.description &&
          other.onPlan == this.onPlan &&
          other.photoPath == this.photoPath &&
          other.estCalories == this.estCalories &&
          other.estProteinG == this.estProteinG &&
          other.estCarbsG == this.estCarbsG &&
          other.estFatG == this.estFatG &&
          other.aiEstimated == this.aiEstimated);
}

class NutritionLogsCompanion extends UpdateCompanion<NutritionLog> {
  final Value<String> id;
  final Value<String> date;
  final Value<String> meal;
  final Value<String> description;
  final Value<bool> onPlan;
  final Value<String?> photoPath;
  final Value<double?> estCalories;
  final Value<double?> estProteinG;
  final Value<double?> estCarbsG;
  final Value<double?> estFatG;
  final Value<bool> aiEstimated;
  final Value<int> rowid;
  const NutritionLogsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.meal = const Value.absent(),
    this.description = const Value.absent(),
    this.onPlan = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.estCalories = const Value.absent(),
    this.estProteinG = const Value.absent(),
    this.estCarbsG = const Value.absent(),
    this.estFatG = const Value.absent(),
    this.aiEstimated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NutritionLogsCompanion.insert({
    required String id,
    required String date,
    required String meal,
    required String description,
    this.onPlan = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.estCalories = const Value.absent(),
    this.estProteinG = const Value.absent(),
    this.estCarbsG = const Value.absent(),
    this.estFatG = const Value.absent(),
    this.aiEstimated = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        meal = Value(meal),
        description = Value(description);
  static Insertable<NutritionLog> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? meal,
    Expression<String>? description,
    Expression<bool>? onPlan,
    Expression<String>? photoPath,
    Expression<double>? estCalories,
    Expression<double>? estProteinG,
    Expression<double>? estCarbsG,
    Expression<double>? estFatG,
    Expression<bool>? aiEstimated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (meal != null) 'meal': meal,
      if (description != null) 'description': description,
      if (onPlan != null) 'on_plan': onPlan,
      if (photoPath != null) 'photo_path': photoPath,
      if (estCalories != null) 'est_calories': estCalories,
      if (estProteinG != null) 'est_protein_g': estProteinG,
      if (estCarbsG != null) 'est_carbs_g': estCarbsG,
      if (estFatG != null) 'est_fat_g': estFatG,
      if (aiEstimated != null) 'ai_estimated': aiEstimated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NutritionLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String>? meal,
      Value<String>? description,
      Value<bool>? onPlan,
      Value<String?>? photoPath,
      Value<double?>? estCalories,
      Value<double?>? estProteinG,
      Value<double?>? estCarbsG,
      Value<double?>? estFatG,
      Value<bool>? aiEstimated,
      Value<int>? rowid}) {
    return NutritionLogsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      meal: meal ?? this.meal,
      description: description ?? this.description,
      onPlan: onPlan ?? this.onPlan,
      photoPath: photoPath ?? this.photoPath,
      estCalories: estCalories ?? this.estCalories,
      estProteinG: estProteinG ?? this.estProteinG,
      estCarbsG: estCarbsG ?? this.estCarbsG,
      estFatG: estFatG ?? this.estFatG,
      aiEstimated: aiEstimated ?? this.aiEstimated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (meal.present) {
      map['meal'] = Variable<String>(meal.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (onPlan.present) {
      map['on_plan'] = Variable<bool>(onPlan.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (estCalories.present) {
      map['est_calories'] = Variable<double>(estCalories.value);
    }
    if (estProteinG.present) {
      map['est_protein_g'] = Variable<double>(estProteinG.value);
    }
    if (estCarbsG.present) {
      map['est_carbs_g'] = Variable<double>(estCarbsG.value);
    }
    if (estFatG.present) {
      map['est_fat_g'] = Variable<double>(estFatG.value);
    }
    if (aiEstimated.present) {
      map['ai_estimated'] = Variable<bool>(aiEstimated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionLogsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('meal: $meal, ')
          ..write('description: $description, ')
          ..write('onPlan: $onPlan, ')
          ..write('photoPath: $photoPath, ')
          ..write('estCalories: $estCalories, ')
          ..write('estProteinG: $estProteinG, ')
          ..write('estCarbsG: $estCarbsG, ')
          ..write('estFatG: $estFatG, ')
          ..write('aiEstimated: $aiEstimated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyReviewsTable extends WeeklyReviews
    with TableInfo<$WeeklyReviewsTable, WeeklyReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _winMeta = const VerificationMeta('win');
  @override
  late final GeneratedColumn<String> win = GeneratedColumn<String>(
      'win', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _adjustMeta = const VerificationMeta('adjust');
  @override
  late final GeneratedColumn<String> adjust = GeneratedColumn<String>(
      'adjust', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, date, win, adjust];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_reviews';
  @override
  VerificationContext validateIntegrity(Insertable<WeeklyReview> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('win')) {
      context.handle(
          _winMeta, win.isAcceptableOrUnknown(data['win']!, _winMeta));
    }
    if (data.containsKey('adjust')) {
      context.handle(_adjustMeta,
          adjust.isAcceptableOrUnknown(data['adjust']!, _adjustMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyReview(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      win: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}win']),
      adjust: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}adjust']),
    );
  }

  @override
  $WeeklyReviewsTable createAlias(String alias) {
    return $WeeklyReviewsTable(attachedDatabase, alias);
  }
}

class WeeklyReview extends DataClass implements Insertable<WeeklyReview> {
  final String id;
  final String date;
  final String? win;
  final String? adjust;
  const WeeklyReview(
      {required this.id, required this.date, this.win, this.adjust});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<String>(date);
    if (!nullToAbsent || win != null) {
      map['win'] = Variable<String>(win);
    }
    if (!nullToAbsent || adjust != null) {
      map['adjust'] = Variable<String>(adjust);
    }
    return map;
  }

  WeeklyReviewsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyReviewsCompanion(
      id: Value(id),
      date: Value(date),
      win: win == null && nullToAbsent ? const Value.absent() : Value(win),
      adjust:
          adjust == null && nullToAbsent ? const Value.absent() : Value(adjust),
    );
  }

  factory WeeklyReview.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyReview(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      win: serializer.fromJson<String?>(json['win']),
      adjust: serializer.fromJson<String?>(json['adjust']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<String>(date),
      'win': serializer.toJson<String?>(win),
      'adjust': serializer.toJson<String?>(adjust),
    };
  }

  WeeklyReview copyWith(
          {String? id,
          String? date,
          Value<String?> win = const Value.absent(),
          Value<String?> adjust = const Value.absent()}) =>
      WeeklyReview(
        id: id ?? this.id,
        date: date ?? this.date,
        win: win.present ? win.value : this.win,
        adjust: adjust.present ? adjust.value : this.adjust,
      );
  WeeklyReview copyWithCompanion(WeeklyReviewsCompanion data) {
    return WeeklyReview(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      win: data.win.present ? data.win.value : this.win,
      adjust: data.adjust.present ? data.adjust.value : this.adjust,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReview(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('win: $win, ')
          ..write('adjust: $adjust')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, win, adjust);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyReview &&
          other.id == this.id &&
          other.date == this.date &&
          other.win == this.win &&
          other.adjust == this.adjust);
}

class WeeklyReviewsCompanion extends UpdateCompanion<WeeklyReview> {
  final Value<String> id;
  final Value<String> date;
  final Value<String?> win;
  final Value<String?> adjust;
  final Value<int> rowid;
  const WeeklyReviewsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.win = const Value.absent(),
    this.adjust = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyReviewsCompanion.insert({
    required String id,
    required String date,
    this.win = const Value.absent(),
    this.adjust = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date);
  static Insertable<WeeklyReview> custom({
    Expression<String>? id,
    Expression<String>? date,
    Expression<String>? win,
    Expression<String>? adjust,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (win != null) 'win': win,
      if (adjust != null) 'adjust': adjust,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyReviewsCompanion copyWith(
      {Value<String>? id,
      Value<String>? date,
      Value<String?>? win,
      Value<String?>? adjust,
      Value<int>? rowid}) {
    return WeeklyReviewsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      win: win ?? this.win,
      adjust: adjust ?? this.adjust,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (win.present) {
      map['win'] = Variable<String>(win.value);
    }
    if (adjust.present) {
      map['adjust'] = Variable<String>(adjust.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('win: $win, ')
          ..write('adjust: $adjust, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressTable extends ReadingProgress
    with TableInfo<$ReadingProgressTable, ReadingProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chapterIdMeta =
      const VerificationMeta('chapterId');
  @override
  late final GeneratedColumn<String> chapterId = GeneratedColumn<String>(
      'chapter_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastPageIndexMeta =
      const VerificationMeta('lastPageIndex');
  @override
  late final GeneratedColumn<int> lastPageIndex = GeneratedColumn<int>(
      'last_page_index', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [chapterId, completed, completedAt, lastPageIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress';
  @override
  VerificationContext validateIntegrity(
      Insertable<ReadingProgressData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chapter_id')) {
      context.handle(_chapterIdMeta,
          chapterId.isAcceptableOrUnknown(data['chapter_id']!, _chapterIdMeta));
    } else if (isInserting) {
      context.missing(_chapterIdMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('last_page_index')) {
      context.handle(
          _lastPageIndexMeta,
          lastPageIndex.isAcceptableOrUnknown(
              data['last_page_index']!, _lastPageIndexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {chapterId};
  @override
  ReadingProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingProgressData(
      chapterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chapter_id'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      lastPageIndex: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_page_index'])!,
    );
  }

  @override
  $ReadingProgressTable createAlias(String alias) {
    return $ReadingProgressTable(attachedDatabase, alias);
  }
}

class ReadingProgressData extends DataClass
    implements Insertable<ReadingProgressData> {
  final String chapterId;
  final bool completed;
  final DateTime? completedAt;
  final int lastPageIndex;
  const ReadingProgressData(
      {required this.chapterId,
      required this.completed,
      this.completedAt,
      required this.lastPageIndex});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chapter_id'] = Variable<String>(chapterId);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['last_page_index'] = Variable<int>(lastPageIndex);
    return map;
  }

  ReadingProgressCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressCompanion(
      chapterId: Value(chapterId),
      completed: Value(completed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      lastPageIndex: Value(lastPageIndex),
    );
  }

  factory ReadingProgressData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingProgressData(
      chapterId: serializer.fromJson<String>(json['chapterId']),
      completed: serializer.fromJson<bool>(json['completed']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      lastPageIndex: serializer.fromJson<int>(json['lastPageIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chapterId': serializer.toJson<String>(chapterId),
      'completed': serializer.toJson<bool>(completed),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'lastPageIndex': serializer.toJson<int>(lastPageIndex),
    };
  }

  ReadingProgressData copyWith(
          {String? chapterId,
          bool? completed,
          Value<DateTime?> completedAt = const Value.absent(),
          int? lastPageIndex}) =>
      ReadingProgressData(
        chapterId: chapterId ?? this.chapterId,
        completed: completed ?? this.completed,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        lastPageIndex: lastPageIndex ?? this.lastPageIndex,
      );
  ReadingProgressData copyWithCompanion(ReadingProgressCompanion data) {
    return ReadingProgressData(
      chapterId: data.chapterId.present ? data.chapterId.value : this.chapterId,
      completed: data.completed.present ? data.completed.value : this.completed,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      lastPageIndex: data.lastPageIndex.present
          ? data.lastPageIndex.value
          : this.lastPageIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressData(')
          ..write('chapterId: $chapterId, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastPageIndex: $lastPageIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(chapterId, completed, completedAt, lastPageIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReadingProgressData &&
          other.chapterId == this.chapterId &&
          other.completed == this.completed &&
          other.completedAt == this.completedAt &&
          other.lastPageIndex == this.lastPageIndex);
}

class ReadingProgressCompanion extends UpdateCompanion<ReadingProgressData> {
  final Value<String> chapterId;
  final Value<bool> completed;
  final Value<DateTime?> completedAt;
  final Value<int> lastPageIndex;
  final Value<int> rowid;
  const ReadingProgressCompanion({
    this.chapterId = const Value.absent(),
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.lastPageIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingProgressCompanion.insert({
    required String chapterId,
    this.completed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.lastPageIndex = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : chapterId = Value(chapterId);
  static Insertable<ReadingProgressData> custom({
    Expression<String>? chapterId,
    Expression<bool>? completed,
    Expression<DateTime>? completedAt,
    Expression<int>? lastPageIndex,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (chapterId != null) 'chapter_id': chapterId,
      if (completed != null) 'completed': completed,
      if (completedAt != null) 'completed_at': completedAt,
      if (lastPageIndex != null) 'last_page_index': lastPageIndex,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingProgressCompanion copyWith(
      {Value<String>? chapterId,
      Value<bool>? completed,
      Value<DateTime?>? completedAt,
      Value<int>? lastPageIndex,
      Value<int>? rowid}) {
    return ReadingProgressCompanion(
      chapterId: chapterId ?? this.chapterId,
      completed: completed ?? this.completed,
      completedAt: completedAt ?? this.completedAt,
      lastPageIndex: lastPageIndex ?? this.lastPageIndex,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chapterId.present) {
      map['chapter_id'] = Variable<String>(chapterId.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (lastPageIndex.present) {
      map['last_page_index'] = Variable<int>(lastPageIndex.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressCompanion(')
          ..write('chapterId: $chapterId, ')
          ..write('completed: $completed, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastPageIndex: $lastPageIndex, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPrefsTable extends UserPrefs
    with TableInfo<$UserPrefsTable, UserPref> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPrefsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_prefs';
  @override
  VerificationContext validateIntegrity(Insertable<UserPref> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  UserPref map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPref(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $UserPrefsTable createAlias(String alias) {
    return $UserPrefsTable(attachedDatabase, alias);
  }
}

class UserPref extends DataClass implements Insertable<UserPref> {
  final String key;
  final String value;
  const UserPref({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  UserPrefsCompanion toCompanion(bool nullToAbsent) {
    return UserPrefsCompanion(
      key: Value(key),
      value: Value(value),
    );
  }

  factory UserPref.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPref(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  UserPref copyWith({String? key, String? value}) => UserPref(
        key: key ?? this.key,
        value: value ?? this.value,
      );
  UserPref copyWithCompanion(UserPrefsCompanion data) {
    return UserPref(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPref(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPref && other.key == this.key && other.value == this.value);
}

class UserPrefsCompanion extends UpdateCompanion<UserPref> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const UserPrefsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPrefsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value);
  static Insertable<UserPref> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPrefsCompanion copyWith(
      {Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return UserPrefsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPrefsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuickLogsTable extends QuickLogs
    with TableInfo<$QuickLogsTable, QuickLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuickLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subtypeMeta =
      const VerificationMeta('subtype');
  @override
  late final GeneratedColumn<String> subtype = GeneratedColumn<String>(
      'subtype', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<int> mood = GeneratedColumn<int>(
      'mood', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, subtype, value, unit, mood, note, date, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quick_logs';
  @override
  VerificationContext validateIntegrity(Insertable<QuickLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('subtype')) {
      context.handle(_subtypeMeta,
          subtype.isAcceptableOrUnknown(data['subtype']!, _subtypeMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('mood')) {
      context.handle(
          _moodMeta, mood.isAcceptableOrUnknown(data['mood']!, _moodMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuickLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuickLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      subtype: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subtype']),
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value']),
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      mood: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mood']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $QuickLogsTable createAlias(String alias) {
    return $QuickLogsTable(attachedDatabase, alias);
  }
}

class QuickLog extends DataClass implements Insertable<QuickLog> {
  final String id;
  final String type;
  final String? subtype;
  final double? value;
  final String? unit;
  final int? mood;
  final String? note;
  final String date;
  final DateTime timestamp;
  const QuickLog(
      {required this.id,
      required this.type,
      this.subtype,
      this.value,
      this.unit,
      this.mood,
      this.note,
      required this.date,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || subtype != null) {
      map['subtype'] = Variable<String>(subtype);
    }
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<int>(mood);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['date'] = Variable<String>(date);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  QuickLogsCompanion toCompanion(bool nullToAbsent) {
    return QuickLogsCompanion(
      id: Value(id),
      type: Value(type),
      subtype: subtype == null && nullToAbsent
          ? const Value.absent()
          : Value(subtype),
      value:
          value == null && nullToAbsent ? const Value.absent() : Value(value),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      date: Value(date),
      timestamp: Value(timestamp),
    );
  }

  factory QuickLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuickLog(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      subtype: serializer.fromJson<String?>(json['subtype']),
      value: serializer.fromJson<double?>(json['value']),
      unit: serializer.fromJson<String?>(json['unit']),
      mood: serializer.fromJson<int?>(json['mood']),
      note: serializer.fromJson<String?>(json['note']),
      date: serializer.fromJson<String>(json['date']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'subtype': serializer.toJson<String?>(subtype),
      'value': serializer.toJson<double?>(value),
      'unit': serializer.toJson<String?>(unit),
      'mood': serializer.toJson<int?>(mood),
      'note': serializer.toJson<String?>(note),
      'date': serializer.toJson<String>(date),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  QuickLog copyWith(
          {String? id,
          String? type,
          Value<String?> subtype = const Value.absent(),
          Value<double?> value = const Value.absent(),
          Value<String?> unit = const Value.absent(),
          Value<int?> mood = const Value.absent(),
          Value<String?> note = const Value.absent(),
          String? date,
          DateTime? timestamp}) =>
      QuickLog(
        id: id ?? this.id,
        type: type ?? this.type,
        subtype: subtype.present ? subtype.value : this.subtype,
        value: value.present ? value.value : this.value,
        unit: unit.present ? unit.value : this.unit,
        mood: mood.present ? mood.value : this.mood,
        note: note.present ? note.value : this.note,
        date: date ?? this.date,
        timestamp: timestamp ?? this.timestamp,
      );
  QuickLog copyWithCompanion(QuickLogsCompanion data) {
    return QuickLog(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      subtype: data.subtype.present ? data.subtype.value : this.subtype,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      mood: data.mood.present ? data.mood.value : this.mood,
      note: data.note.present ? data.note.value : this.note,
      date: data.date.present ? data.date.value : this.date,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuickLog(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('subtype: $subtype, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('mood: $mood, ')
          ..write('note: $note, ')
          ..write('date: $date, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, subtype, value, unit, mood, note, date, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuickLog &&
          other.id == this.id &&
          other.type == this.type &&
          other.subtype == this.subtype &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.mood == this.mood &&
          other.note == this.note &&
          other.date == this.date &&
          other.timestamp == this.timestamp);
}

class QuickLogsCompanion extends UpdateCompanion<QuickLog> {
  final Value<String> id;
  final Value<String> type;
  final Value<String?> subtype;
  final Value<double?> value;
  final Value<String?> unit;
  final Value<int?> mood;
  final Value<String?> note;
  final Value<String> date;
  final Value<DateTime> timestamp;
  final Value<int> rowid;
  const QuickLogsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.subtype = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.mood = const Value.absent(),
    this.note = const Value.absent(),
    this.date = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuickLogsCompanion.insert({
    required String id,
    required String type,
    this.subtype = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.mood = const Value.absent(),
    this.note = const Value.absent(),
    required String date,
    this.timestamp = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        date = Value(date);
  static Insertable<QuickLog> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? subtype,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<int>? mood,
    Expression<String>? note,
    Expression<String>? date,
    Expression<DateTime>? timestamp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (subtype != null) 'subtype': subtype,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (mood != null) 'mood': mood,
      if (note != null) 'note': note,
      if (date != null) 'date': date,
      if (timestamp != null) 'timestamp': timestamp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuickLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<String?>? subtype,
      Value<double?>? value,
      Value<String?>? unit,
      Value<int?>? mood,
      Value<String?>? note,
      Value<String>? date,
      Value<DateTime>? timestamp,
      Value<int>? rowid}) {
    return QuickLogsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      mood: mood ?? this.mood,
      note: note ?? this.note,
      date: date ?? this.date,
      timestamp: timestamp ?? this.timestamp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (subtype.present) {
      map['subtype'] = Variable<String>(subtype.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (mood.present) {
      map['mood'] = Variable<int>(mood.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuickLogsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('subtype: $subtype, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('mood: $mood, ')
          ..write('note: $note, ')
          ..write('date: $date, ')
          ..write('timestamp: $timestamp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitCalendarEventsTable extends HabitCalendarEvents
    with TableInfo<$HabitCalendarEventsTable, HabitCalendarEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCalendarEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eventIdMeta =
      const VerificationMeta('eventId');
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
      'event_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _calendarIdMeta =
      const VerificationMeta('calendarId');
  @override
  late final GeneratedColumn<String> calendarId = GeneratedColumn<String>(
      'calendar_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scheduledStartMeta =
      const VerificationMeta('scheduledStart');
  @override
  late final GeneratedColumn<DateTime> scheduledStart =
      GeneratedColumn<DateTime>('scheduled_start', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _scheduledEndMeta =
      const VerificationMeta('scheduledEnd');
  @override
  late final GeneratedColumn<DateTime> scheduledEnd = GeneratedColumn<DateTime>(
      'scheduled_end', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [habitId, date, eventId, calendarId, scheduledStart, scheduledEnd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_calendar_events';
  @override
  VerificationContext validateIntegrity(Insertable<HabitCalendarEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('calendar_id')) {
      context.handle(
          _calendarIdMeta,
          calendarId.isAcceptableOrUnknown(
              data['calendar_id']!, _calendarIdMeta));
    } else if (isInserting) {
      context.missing(_calendarIdMeta);
    }
    if (data.containsKey('scheduled_start')) {
      context.handle(
          _scheduledStartMeta,
          scheduledStart.isAcceptableOrUnknown(
              data['scheduled_start']!, _scheduledStartMeta));
    } else if (isInserting) {
      context.missing(_scheduledStartMeta);
    }
    if (data.containsKey('scheduled_end')) {
      context.handle(
          _scheduledEndMeta,
          scheduledEnd.isAcceptableOrUnknown(
              data['scheduled_end']!, _scheduledEndMeta));
    } else if (isInserting) {
      context.missing(_scheduledEndMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, date};
  @override
  HabitCalendarEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCalendarEvent(
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      eventId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_id'])!,
      calendarId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}calendar_id'])!,
      scheduledStart: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_start'])!,
      scheduledEnd: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_end'])!,
    );
  }

  @override
  $HabitCalendarEventsTable createAlias(String alias) {
    return $HabitCalendarEventsTable(attachedDatabase, alias);
  }
}

class HabitCalendarEvent extends DataClass
    implements Insertable<HabitCalendarEvent> {
  final String habitId;
  final String date;
  final String eventId;
  final String calendarId;
  final DateTime scheduledStart;
  final DateTime scheduledEnd;
  const HabitCalendarEvent(
      {required this.habitId,
      required this.date,
      required this.eventId,
      required this.calendarId,
      required this.scheduledStart,
      required this.scheduledEnd});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['date'] = Variable<String>(date);
    map['event_id'] = Variable<String>(eventId);
    map['calendar_id'] = Variable<String>(calendarId);
    map['scheduled_start'] = Variable<DateTime>(scheduledStart);
    map['scheduled_end'] = Variable<DateTime>(scheduledEnd);
    return map;
  }

  HabitCalendarEventsCompanion toCompanion(bool nullToAbsent) {
    return HabitCalendarEventsCompanion(
      habitId: Value(habitId),
      date: Value(date),
      eventId: Value(eventId),
      calendarId: Value(calendarId),
      scheduledStart: Value(scheduledStart),
      scheduledEnd: Value(scheduledEnd),
    );
  }

  factory HabitCalendarEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCalendarEvent(
      habitId: serializer.fromJson<String>(json['habitId']),
      date: serializer.fromJson<String>(json['date']),
      eventId: serializer.fromJson<String>(json['eventId']),
      calendarId: serializer.fromJson<String>(json['calendarId']),
      scheduledStart: serializer.fromJson<DateTime>(json['scheduledStart']),
      scheduledEnd: serializer.fromJson<DateTime>(json['scheduledEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'date': serializer.toJson<String>(date),
      'eventId': serializer.toJson<String>(eventId),
      'calendarId': serializer.toJson<String>(calendarId),
      'scheduledStart': serializer.toJson<DateTime>(scheduledStart),
      'scheduledEnd': serializer.toJson<DateTime>(scheduledEnd),
    };
  }

  HabitCalendarEvent copyWith(
          {String? habitId,
          String? date,
          String? eventId,
          String? calendarId,
          DateTime? scheduledStart,
          DateTime? scheduledEnd}) =>
      HabitCalendarEvent(
        habitId: habitId ?? this.habitId,
        date: date ?? this.date,
        eventId: eventId ?? this.eventId,
        calendarId: calendarId ?? this.calendarId,
        scheduledStart: scheduledStart ?? this.scheduledStart,
        scheduledEnd: scheduledEnd ?? this.scheduledEnd,
      );
  HabitCalendarEvent copyWithCompanion(HabitCalendarEventsCompanion data) {
    return HabitCalendarEvent(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      calendarId:
          data.calendarId.present ? data.calendarId.value : this.calendarId,
      scheduledStart: data.scheduledStart.present
          ? data.scheduledStart.value
          : this.scheduledStart,
      scheduledEnd: data.scheduledEnd.present
          ? data.scheduledEnd.value
          : this.scheduledEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCalendarEvent(')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('eventId: $eventId, ')
          ..write('calendarId: $calendarId, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('scheduledEnd: $scheduledEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      habitId, date, eventId, calendarId, scheduledStart, scheduledEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitCalendarEvent &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.eventId == this.eventId &&
          other.calendarId == this.calendarId &&
          other.scheduledStart == this.scheduledStart &&
          other.scheduledEnd == this.scheduledEnd);
}

class HabitCalendarEventsCompanion extends UpdateCompanion<HabitCalendarEvent> {
  final Value<String> habitId;
  final Value<String> date;
  final Value<String> eventId;
  final Value<String> calendarId;
  final Value<DateTime> scheduledStart;
  final Value<DateTime> scheduledEnd;
  final Value<int> rowid;
  const HabitCalendarEventsCompanion({
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.eventId = const Value.absent(),
    this.calendarId = const Value.absent(),
    this.scheduledStart = const Value.absent(),
    this.scheduledEnd = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitCalendarEventsCompanion.insert({
    required String habitId,
    required String date,
    required String eventId,
    required String calendarId,
    required DateTime scheduledStart,
    required DateTime scheduledEnd,
    this.rowid = const Value.absent(),
  })  : habitId = Value(habitId),
        date = Value(date),
        eventId = Value(eventId),
        calendarId = Value(calendarId),
        scheduledStart = Value(scheduledStart),
        scheduledEnd = Value(scheduledEnd);
  static Insertable<HabitCalendarEvent> custom({
    Expression<String>? habitId,
    Expression<String>? date,
    Expression<String>? eventId,
    Expression<String>? calendarId,
    Expression<DateTime>? scheduledStart,
    Expression<DateTime>? scheduledEnd,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (eventId != null) 'event_id': eventId,
      if (calendarId != null) 'calendar_id': calendarId,
      if (scheduledStart != null) 'scheduled_start': scheduledStart,
      if (scheduledEnd != null) 'scheduled_end': scheduledEnd,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitCalendarEventsCompanion copyWith(
      {Value<String>? habitId,
      Value<String>? date,
      Value<String>? eventId,
      Value<String>? calendarId,
      Value<DateTime>? scheduledStart,
      Value<DateTime>? scheduledEnd,
      Value<int>? rowid}) {
    return HabitCalendarEventsCompanion(
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      eventId: eventId ?? this.eventId,
      calendarId: calendarId ?? this.calendarId,
      scheduledStart: scheduledStart ?? this.scheduledStart,
      scheduledEnd: scheduledEnd ?? this.scheduledEnd,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (calendarId.present) {
      map['calendar_id'] = Variable<String>(calendarId.value);
    }
    if (scheduledStart.present) {
      map['scheduled_start'] = Variable<DateTime>(scheduledStart.value);
    }
    if (scheduledEnd.present) {
      map['scheduled_end'] = Variable<DateTime>(scheduledEnd.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitCalendarEventsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('eventId: $eventId, ')
          ..write('calendarId: $calendarId, ')
          ..write('scheduledStart: $scheduledStart, ')
          ..write('scheduledEnd: $scheduledEnd, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BlockedAppsTable extends BlockedApps
    with TableInfo<$BlockedAppsTable, BlockedApp> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BlockedAppsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _packageNameMeta =
      const VerificationMeta('packageName');
  @override
  late final GeneratedColumn<String> packageName = GeneratedColumn<String>(
      'package_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [packageName, label, enabled];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blocked_apps';
  @override
  VerificationContext validateIntegrity(Insertable<BlockedApp> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('package_name')) {
      context.handle(
          _packageNameMeta,
          packageName.isAcceptableOrUnknown(
              data['package_name']!, _packageNameMeta));
    } else if (isInserting) {
      context.missing(_packageNameMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {packageName};
  @override
  BlockedApp map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BlockedApp(
      packageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}package_name'])!,
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
    );
  }

  @override
  $BlockedAppsTable createAlias(String alias) {
    return $BlockedAppsTable(attachedDatabase, alias);
  }
}

class BlockedApp extends DataClass implements Insertable<BlockedApp> {
  final String packageName;
  final String label;
  final bool enabled;
  const BlockedApp(
      {required this.packageName, required this.label, required this.enabled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['package_name'] = Variable<String>(packageName);
    map['label'] = Variable<String>(label);
    map['enabled'] = Variable<bool>(enabled);
    return map;
  }

  BlockedAppsCompanion toCompanion(bool nullToAbsent) {
    return BlockedAppsCompanion(
      packageName: Value(packageName),
      label: Value(label),
      enabled: Value(enabled),
    );
  }

  factory BlockedApp.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BlockedApp(
      packageName: serializer.fromJson<String>(json['packageName']),
      label: serializer.fromJson<String>(json['label']),
      enabled: serializer.fromJson<bool>(json['enabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'packageName': serializer.toJson<String>(packageName),
      'label': serializer.toJson<String>(label),
      'enabled': serializer.toJson<bool>(enabled),
    };
  }

  BlockedApp copyWith({String? packageName, String? label, bool? enabled}) =>
      BlockedApp(
        packageName: packageName ?? this.packageName,
        label: label ?? this.label,
        enabled: enabled ?? this.enabled,
      );
  BlockedApp copyWithCompanion(BlockedAppsCompanion data) {
    return BlockedApp(
      packageName:
          data.packageName.present ? data.packageName.value : this.packageName,
      label: data.label.present ? data.label.value : this.label,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BlockedApp(')
          ..write('packageName: $packageName, ')
          ..write('label: $label, ')
          ..write('enabled: $enabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(packageName, label, enabled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BlockedApp &&
          other.packageName == this.packageName &&
          other.label == this.label &&
          other.enabled == this.enabled);
}

class BlockedAppsCompanion extends UpdateCompanion<BlockedApp> {
  final Value<String> packageName;
  final Value<String> label;
  final Value<bool> enabled;
  final Value<int> rowid;
  const BlockedAppsCompanion({
    this.packageName = const Value.absent(),
    this.label = const Value.absent(),
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BlockedAppsCompanion.insert({
    required String packageName,
    required String label,
    this.enabled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : packageName = Value(packageName),
        label = Value(label);
  static Insertable<BlockedApp> custom({
    Expression<String>? packageName,
    Expression<String>? label,
    Expression<bool>? enabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (packageName != null) 'package_name': packageName,
      if (label != null) 'label': label,
      if (enabled != null) 'enabled': enabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BlockedAppsCompanion copyWith(
      {Value<String>? packageName,
      Value<String>? label,
      Value<bool>? enabled,
      Value<int>? rowid}) {
    return BlockedAppsCompanion(
      packageName: packageName ?? this.packageName,
      label: label ?? this.label,
      enabled: enabled ?? this.enabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (packageName.present) {
      map['package_name'] = Variable<String>(packageName.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlockedAppsCompanion(')
          ..write('packageName: $packageName, ')
          ..write('label: $label, ')
          ..write('enabled: $enabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ScreenTimeCreditsTable extends ScreenTimeCredits
    with TableInfo<$ScreenTimeCreditsTable, ScreenTimeCredit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScreenTimeCreditsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
      'date', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _earnedMinutesMeta =
      const VerificationMeta('earnedMinutes');
  @override
  late final GeneratedColumn<int> earnedMinutes = GeneratedColumn<int>(
      'earned_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _usedMinutesMeta =
      const VerificationMeta('usedMinutes');
  @override
  late final GeneratedColumn<int> usedMinutes = GeneratedColumn<int>(
      'used_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [date, earnedMinutes, usedMinutes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'screen_time_credits';
  @override
  VerificationContext validateIntegrity(Insertable<ScreenTimeCredit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('earned_minutes')) {
      context.handle(
          _earnedMinutesMeta,
          earnedMinutes.isAcceptableOrUnknown(
              data['earned_minutes']!, _earnedMinutesMeta));
    }
    if (data.containsKey('used_minutes')) {
      context.handle(
          _usedMinutesMeta,
          usedMinutes.isAcceptableOrUnknown(
              data['used_minutes']!, _usedMinutesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {date};
  @override
  ScreenTimeCredit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScreenTimeCredit(
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date'])!,
      earnedMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}earned_minutes'])!,
      usedMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}used_minutes'])!,
    );
  }

  @override
  $ScreenTimeCreditsTable createAlias(String alias) {
    return $ScreenTimeCreditsTable(attachedDatabase, alias);
  }
}

class ScreenTimeCredit extends DataClass
    implements Insertable<ScreenTimeCredit> {
  final String date;
  final int earnedMinutes;
  final int usedMinutes;
  const ScreenTimeCredit(
      {required this.date,
      required this.earnedMinutes,
      required this.usedMinutes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date'] = Variable<String>(date);
    map['earned_minutes'] = Variable<int>(earnedMinutes);
    map['used_minutes'] = Variable<int>(usedMinutes);
    return map;
  }

  ScreenTimeCreditsCompanion toCompanion(bool nullToAbsent) {
    return ScreenTimeCreditsCompanion(
      date: Value(date),
      earnedMinutes: Value(earnedMinutes),
      usedMinutes: Value(usedMinutes),
    );
  }

  factory ScreenTimeCredit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScreenTimeCredit(
      date: serializer.fromJson<String>(json['date']),
      earnedMinutes: serializer.fromJson<int>(json['earnedMinutes']),
      usedMinutes: serializer.fromJson<int>(json['usedMinutes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'date': serializer.toJson<String>(date),
      'earnedMinutes': serializer.toJson<int>(earnedMinutes),
      'usedMinutes': serializer.toJson<int>(usedMinutes),
    };
  }

  ScreenTimeCredit copyWith(
          {String? date, int? earnedMinutes, int? usedMinutes}) =>
      ScreenTimeCredit(
        date: date ?? this.date,
        earnedMinutes: earnedMinutes ?? this.earnedMinutes,
        usedMinutes: usedMinutes ?? this.usedMinutes,
      );
  ScreenTimeCredit copyWithCompanion(ScreenTimeCreditsCompanion data) {
    return ScreenTimeCredit(
      date: data.date.present ? data.date.value : this.date,
      earnedMinutes: data.earnedMinutes.present
          ? data.earnedMinutes.value
          : this.earnedMinutes,
      usedMinutes:
          data.usedMinutes.present ? data.usedMinutes.value : this.usedMinutes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScreenTimeCredit(')
          ..write('date: $date, ')
          ..write('earnedMinutes: $earnedMinutes, ')
          ..write('usedMinutes: $usedMinutes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(date, earnedMinutes, usedMinutes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScreenTimeCredit &&
          other.date == this.date &&
          other.earnedMinutes == this.earnedMinutes &&
          other.usedMinutes == this.usedMinutes);
}

class ScreenTimeCreditsCompanion extends UpdateCompanion<ScreenTimeCredit> {
  final Value<String> date;
  final Value<int> earnedMinutes;
  final Value<int> usedMinutes;
  final Value<int> rowid;
  const ScreenTimeCreditsCompanion({
    this.date = const Value.absent(),
    this.earnedMinutes = const Value.absent(),
    this.usedMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ScreenTimeCreditsCompanion.insert({
    required String date,
    this.earnedMinutes = const Value.absent(),
    this.usedMinutes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : date = Value(date);
  static Insertable<ScreenTimeCredit> custom({
    Expression<String>? date,
    Expression<int>? earnedMinutes,
    Expression<int>? usedMinutes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (date != null) 'date': date,
      if (earnedMinutes != null) 'earned_minutes': earnedMinutes,
      if (usedMinutes != null) 'used_minutes': usedMinutes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ScreenTimeCreditsCompanion copyWith(
      {Value<String>? date,
      Value<int>? earnedMinutes,
      Value<int>? usedMinutes,
      Value<int>? rowid}) {
    return ScreenTimeCreditsCompanion(
      date: date ?? this.date,
      earnedMinutes: earnedMinutes ?? this.earnedMinutes,
      usedMinutes: usedMinutes ?? this.usedMinutes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (earnedMinutes.present) {
      map['earned_minutes'] = Variable<int>(earnedMinutes.value);
    }
    if (usedMinutes.present) {
      map['used_minutes'] = Variable<int>(usedMinutes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScreenTimeCreditsCompanion(')
          ..write('date: $date, ')
          ..write('earnedMinutes: $earnedMinutes, ')
          ..write('usedMinutes: $usedMinutes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiWeeklyReviewsTable extends AiWeeklyReviews
    with TableInfo<$AiWeeklyReviewsTable, AiWeeklyReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiWeeklyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _weekStartMeta =
      const VerificationMeta('weekStart');
  @override
  late final GeneratedColumn<String> weekStart = GeneratedColumn<String>(
      'week_start', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _generatedAtMeta =
      const VerificationMeta('generatedAt');
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
      'generated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [weekStart, content, generatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_weekly_reviews';
  @override
  VerificationContext validateIntegrity(Insertable<AiWeeklyReview> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('week_start')) {
      context.handle(_weekStartMeta,
          weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta));
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
          _generatedAtMeta,
          generatedAt.isAcceptableOrUnknown(
              data['generated_at']!, _generatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {weekStart};
  @override
  AiWeeklyReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiWeeklyReview(
      weekStart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}week_start'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      generatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}generated_at'])!,
    );
  }

  @override
  $AiWeeklyReviewsTable createAlias(String alias) {
    return $AiWeeklyReviewsTable(attachedDatabase, alias);
  }
}

class AiWeeklyReview extends DataClass implements Insertable<AiWeeklyReview> {
  final String weekStart;
  final String content;
  final DateTime generatedAt;
  const AiWeeklyReview(
      {required this.weekStart,
      required this.content,
      required this.generatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['week_start'] = Variable<String>(weekStart);
    map['content'] = Variable<String>(content);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  AiWeeklyReviewsCompanion toCompanion(bool nullToAbsent) {
    return AiWeeklyReviewsCompanion(
      weekStart: Value(weekStart),
      content: Value(content),
      generatedAt: Value(generatedAt),
    );
  }

  factory AiWeeklyReview.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiWeeklyReview(
      weekStart: serializer.fromJson<String>(json['weekStart']),
      content: serializer.fromJson<String>(json['content']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'weekStart': serializer.toJson<String>(weekStart),
      'content': serializer.toJson<String>(content),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  AiWeeklyReview copyWith(
          {String? weekStart, String? content, DateTime? generatedAt}) =>
      AiWeeklyReview(
        weekStart: weekStart ?? this.weekStart,
        content: content ?? this.content,
        generatedAt: generatedAt ?? this.generatedAt,
      );
  AiWeeklyReview copyWithCompanion(AiWeeklyReviewsCompanion data) {
    return AiWeeklyReview(
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      content: data.content.present ? data.content.value : this.content,
      generatedAt:
          data.generatedAt.present ? data.generatedAt.value : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiWeeklyReview(')
          ..write('weekStart: $weekStart, ')
          ..write('content: $content, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(weekStart, content, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiWeeklyReview &&
          other.weekStart == this.weekStart &&
          other.content == this.content &&
          other.generatedAt == this.generatedAt);
}

class AiWeeklyReviewsCompanion extends UpdateCompanion<AiWeeklyReview> {
  final Value<String> weekStart;
  final Value<String> content;
  final Value<DateTime> generatedAt;
  final Value<int> rowid;
  const AiWeeklyReviewsCompanion({
    this.weekStart = const Value.absent(),
    this.content = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AiWeeklyReviewsCompanion.insert({
    required String weekStart,
    required String content,
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : weekStart = Value(weekStart),
        content = Value(content);
  static Insertable<AiWeeklyReview> custom({
    Expression<String>? weekStart,
    Expression<String>? content,
    Expression<DateTime>? generatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (weekStart != null) 'week_start': weekStart,
      if (content != null) 'content': content,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AiWeeklyReviewsCompanion copyWith(
      {Value<String>? weekStart,
      Value<String>? content,
      Value<DateTime>? generatedAt,
      Value<int>? rowid}) {
    return AiWeeklyReviewsCompanion(
      weekStart: weekStart ?? this.weekStart,
      content: content ?? this.content,
      generatedAt: generatedAt ?? this.generatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (weekStart.present) {
      map['week_start'] = Variable<String>(weekStart.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiWeeklyReviewsCompanion(')
          ..write('weekStart: $weekStart, ')
          ..write('content: $content, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DailyStateTable dailyState = $DailyStateTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $StreakStateTable streakState = $StreakStateTable(this);
  late final $ExerciseLogsTable exerciseLogs = $ExerciseLogsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $WeightLogsTable weightLogs = $WeightLogsTable(this);
  late final $LearningLogsTable learningLogs = $LearningLogsTable(this);
  late final $MartialArtsLogsTable martialArtsLogs =
      $MartialArtsLogsTable(this);
  late final $HobbyLogsTable hobbyLogs = $HobbyLogsTable(this);
  late final $NutritionLogsTable nutritionLogs = $NutritionLogsTable(this);
  late final $WeeklyReviewsTable weeklyReviews = $WeeklyReviewsTable(this);
  late final $ReadingProgressTable readingProgress =
      $ReadingProgressTable(this);
  late final $UserPrefsTable userPrefs = $UserPrefsTable(this);
  late final $QuickLogsTable quickLogs = $QuickLogsTable(this);
  late final $HabitCalendarEventsTable habitCalendarEvents =
      $HabitCalendarEventsTable(this);
  late final $BlockedAppsTable blockedApps = $BlockedAppsTable(this);
  late final $ScreenTimeCreditsTable screenTimeCredits =
      $ScreenTimeCreditsTable(this);
  late final $AiWeeklyReviewsTable aiWeeklyReviews =
      $AiWeeklyReviewsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        dailyState,
        habits,
        habitLogs,
        streakState,
        exerciseLogs,
        sleepLogs,
        weightLogs,
        learningLogs,
        martialArtsLogs,
        hobbyLogs,
        nutritionLogs,
        weeklyReviews,
        readingProgress,
        userPrefs,
        quickLogs,
        habitCalendarEvents,
        blockedApps,
        screenTimeCredits,
        aiWeeklyReviews
      ];
}

typedef $$DailyStateTableCreateCompanionBuilder = DailyStateCompanion Function({
  required String date,
  Value<int?> energyLevel,
  Value<double?> sleepHours,
  Value<double?> weightKg,
  Value<int?> steps,
  Value<bool> gatePassed,
  Value<DateTime?> gatePassedAt,
  Value<int> rowid,
});
typedef $$DailyStateTableUpdateCompanionBuilder = DailyStateCompanion Function({
  Value<String> date,
  Value<int?> energyLevel,
  Value<double?> sleepHours,
  Value<double?> weightKg,
  Value<int?> steps,
  Value<bool> gatePassed,
  Value<DateTime?> gatePassedAt,
  Value<int> rowid,
});

class $$DailyStateTableFilterComposer
    extends Composer<_$AppDatabase, $DailyStateTable> {
  $$DailyStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get gatePassed => $composableBuilder(
      column: $table.gatePassed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get gatePassedAt => $composableBuilder(
      column: $table.gatePassedAt, builder: (column) => ColumnFilters(column));
}

class $$DailyStateTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyStateTable> {
  $$DailyStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get gatePassed => $composableBuilder(
      column: $table.gatePassed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get gatePassedAt => $composableBuilder(
      column: $table.gatePassedAt,
      builder: (column) => ColumnOrderings(column));
}

class $$DailyStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyStateTable> {
  $$DailyStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get energyLevel => $composableBuilder(
      column: $table.energyLevel, builder: (column) => column);

  GeneratedColumn<double> get sleepHours => $composableBuilder(
      column: $table.sleepHours, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<bool> get gatePassed => $composableBuilder(
      column: $table.gatePassed, builder: (column) => column);

  GeneratedColumn<DateTime> get gatePassedAt => $composableBuilder(
      column: $table.gatePassedAt, builder: (column) => column);
}

class $$DailyStateTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DailyStateTable,
    DailyStateData,
    $$DailyStateTableFilterComposer,
    $$DailyStateTableOrderingComposer,
    $$DailyStateTableAnnotationComposer,
    $$DailyStateTableCreateCompanionBuilder,
    $$DailyStateTableUpdateCompanionBuilder,
    (
      DailyStateData,
      BaseReferences<_$AppDatabase, $DailyStateTable, DailyStateData>
    ),
    DailyStateData,
    PrefetchHooks Function()> {
  $$DailyStateTableTableManager(_$AppDatabase db, $DailyStateTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<int?> energyLevel = const Value.absent(),
            Value<double?> sleepHours = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<int?> steps = const Value.absent(),
            Value<bool> gatePassed = const Value.absent(),
            Value<DateTime?> gatePassedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyStateCompanion(
            date: date,
            energyLevel: energyLevel,
            sleepHours: sleepHours,
            weightKg: weightKg,
            steps: steps,
            gatePassed: gatePassed,
            gatePassedAt: gatePassedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
            Value<int?> energyLevel = const Value.absent(),
            Value<double?> sleepHours = const Value.absent(),
            Value<double?> weightKg = const Value.absent(),
            Value<int?> steps = const Value.absent(),
            Value<bool> gatePassed = const Value.absent(),
            Value<DateTime?> gatePassedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DailyStateCompanion.insert(
            date: date,
            energyLevel: energyLevel,
            sleepHours: sleepHours,
            weightKg: weightKg,
            steps: steps,
            gatePassed: gatePassed,
            gatePassedAt: gatePassedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DailyStateTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DailyStateTable,
    DailyStateData,
    $$DailyStateTableFilterComposer,
    $$DailyStateTableOrderingComposer,
    $$DailyStateTableAnnotationComposer,
    $$DailyStateTableCreateCompanionBuilder,
    $$DailyStateTableUpdateCompanionBuilder,
    (
      DailyStateData,
      BaseReferences<_$AppDatabase, $DailyStateTable, DailyStateData>
    ),
    DailyStateData,
    PrefetchHooks Function()>;
typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String label,
  Value<String> icon,
  Value<int> sortOrder,
  Value<bool> isCore,
  Value<bool> archived,
  Value<int> tier,
  Value<String?> scheduledTime,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> label,
  Value<String> icon,
  Value<int> sortOrder,
  Value<bool> isCore,
  Value<bool> archived,
  Value<int> tier,
  Value<String?> scheduledTime,
  Value<int> rowid,
});

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCore => $composableBuilder(
      column: $table.isCore, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get archived => $composableBuilder(
      column: $table.archived, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scheduledTime => $composableBuilder(
      column: $table.scheduledTime, builder: (column) => ColumnFilters(column));
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCore => $composableBuilder(
      column: $table.isCore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get archived => $composableBuilder(
      column: $table.archived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get tier => $composableBuilder(
      column: $table.tier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scheduledTime => $composableBuilder(
      column: $table.scheduledTime,
      builder: (column) => ColumnOrderings(column));
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isCore =>
      $composableBuilder(column: $table.isCore, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<int> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get scheduledTime => $composableBuilder(
      column: $table.scheduledTime, builder: (column) => column);
}

class $$HabitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
    Habit,
    PrefetchHooks Function()> {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isCore = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<int> tier = const Value.absent(),
            Value<String?> scheduledTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion(
            id: id,
            label: label,
            icon: icon,
            sortOrder: sortOrder,
            isCore: isCore,
            archived: archived,
            tier: tier,
            scheduledTime: scheduledTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String label,
            Value<String> icon = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isCore = const Value.absent(),
            Value<bool> archived = const Value.absent(),
            Value<int> tier = const Value.absent(),
            Value<String?> scheduledTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion.insert(
            id: id,
            label: label,
            icon: icon,
            sortOrder: sortOrder,
            isCore: isCore,
            archived: archived,
            tier: tier,
            scheduledTime: scheduledTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
    Habit,
    PrefetchHooks Function()>;
typedef $$HabitLogsTableCreateCompanionBuilder = HabitLogsCompanion Function({
  required String habitId,
  required String date,
  Value<bool> done,
  Value<DateTime?> completedAt,
  Value<String?> outcome,
  Value<int> rowid,
});
typedef $$HabitLogsTableUpdateCompanionBuilder = HabitLogsCompanion Function({
  Value<String> habitId,
  Value<String> date,
  Value<bool> done,
  Value<DateTime?> completedAt,
  Value<String?> outcome,
  Value<int> rowid,
});

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get outcome => $composableBuilder(
      column: $table.outcome, builder: (column) => ColumnFilters(column));
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get done => $composableBuilder(
      column: $table.done, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get outcome => $composableBuilder(
      column: $table.outcome, builder: (column) => ColumnOrderings(column));
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get done =>
      $composableBuilder(column: $table.done, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);
}

class $$HabitLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitLogsTable,
    HabitLog,
    $$HabitLogsTableFilterComposer,
    $$HabitLogsTableOrderingComposer,
    $$HabitLogsTableAnnotationComposer,
    $$HabitLogsTableCreateCompanionBuilder,
    $$HabitLogsTableUpdateCompanionBuilder,
    (HabitLog, BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog>),
    HabitLog,
    PrefetchHooks Function()> {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> habitId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<bool> done = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String?> outcome = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitLogsCompanion(
            habitId: habitId,
            date: date,
            done: done,
            completedAt: completedAt,
            outcome: outcome,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String habitId,
            required String date,
            Value<bool> done = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<String?> outcome = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitLogsCompanion.insert(
            habitId: habitId,
            date: date,
            done: done,
            completedAt: completedAt,
            outcome: outcome,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitLogsTable,
    HabitLog,
    $$HabitLogsTableFilterComposer,
    $$HabitLogsTableOrderingComposer,
    $$HabitLogsTableAnnotationComposer,
    $$HabitLogsTableCreateCompanionBuilder,
    $$HabitLogsTableUpdateCompanionBuilder,
    (HabitLog, BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog>),
    HabitLog,
    PrefetchHooks Function()>;
typedef $$StreakStateTableCreateCompanionBuilder = StreakStateCompanion
    Function({
  Value<int> id,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<int> totalPoints,
  Value<int> streakFreezesAvailable,
  Value<String?> lastCompletedDate,
  Value<String?> lastPenaltyDate,
});
typedef $$StreakStateTableUpdateCompanionBuilder = StreakStateCompanion
    Function({
  Value<int> id,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<int> totalPoints,
  Value<int> streakFreezesAvailable,
  Value<String?> lastCompletedDate,
  Value<String?> lastPenaltyDate,
});

class $$StreakStateTableFilterComposer
    extends Composer<_$AppDatabase, $StreakStateTable> {
  $$StreakStateTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalPoints => $composableBuilder(
      column: $table.totalPoints, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get streakFreezesAvailable => $composableBuilder(
      column: $table.streakFreezesAvailable,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastCompletedDate => $composableBuilder(
      column: $table.lastCompletedDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastPenaltyDate => $composableBuilder(
      column: $table.lastPenaltyDate,
      builder: (column) => ColumnFilters(column));
}

class $$StreakStateTableOrderingComposer
    extends Composer<_$AppDatabase, $StreakStateTable> {
  $$StreakStateTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalPoints => $composableBuilder(
      column: $table.totalPoints, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get streakFreezesAvailable => $composableBuilder(
      column: $table.streakFreezesAvailable,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastCompletedDate => $composableBuilder(
      column: $table.lastCompletedDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastPenaltyDate => $composableBuilder(
      column: $table.lastPenaltyDate,
      builder: (column) => ColumnOrderings(column));
}

class $$StreakStateTableAnnotationComposer
    extends Composer<_$AppDatabase, $StreakStateTable> {
  $$StreakStateTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<int> get totalPoints => $composableBuilder(
      column: $table.totalPoints, builder: (column) => column);

  GeneratedColumn<int> get streakFreezesAvailable => $composableBuilder(
      column: $table.streakFreezesAvailable, builder: (column) => column);

  GeneratedColumn<String> get lastCompletedDate => $composableBuilder(
      column: $table.lastCompletedDate, builder: (column) => column);

  GeneratedColumn<String> get lastPenaltyDate => $composableBuilder(
      column: $table.lastPenaltyDate, builder: (column) => column);
}

class $$StreakStateTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StreakStateTable,
    StreakStateData,
    $$StreakStateTableFilterComposer,
    $$StreakStateTableOrderingComposer,
    $$StreakStateTableAnnotationComposer,
    $$StreakStateTableCreateCompanionBuilder,
    $$StreakStateTableUpdateCompanionBuilder,
    (
      StreakStateData,
      BaseReferences<_$AppDatabase, $StreakStateTable, StreakStateData>
    ),
    StreakStateData,
    PrefetchHooks Function()> {
  $$StreakStateTableTableManager(_$AppDatabase db, $StreakStateTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StreakStateTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StreakStateTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StreakStateTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<int> totalPoints = const Value.absent(),
            Value<int> streakFreezesAvailable = const Value.absent(),
            Value<String?> lastCompletedDate = const Value.absent(),
            Value<String?> lastPenaltyDate = const Value.absent(),
          }) =>
              StreakStateCompanion(
            id: id,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            totalPoints: totalPoints,
            streakFreezesAvailable: streakFreezesAvailable,
            lastCompletedDate: lastCompletedDate,
            lastPenaltyDate: lastPenaltyDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<int> totalPoints = const Value.absent(),
            Value<int> streakFreezesAvailable = const Value.absent(),
            Value<String?> lastCompletedDate = const Value.absent(),
            Value<String?> lastPenaltyDate = const Value.absent(),
          }) =>
              StreakStateCompanion.insert(
            id: id,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            totalPoints: totalPoints,
            streakFreezesAvailable: streakFreezesAvailable,
            lastCompletedDate: lastCompletedDate,
            lastPenaltyDate: lastPenaltyDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StreakStateTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StreakStateTable,
    StreakStateData,
    $$StreakStateTableFilterComposer,
    $$StreakStateTableOrderingComposer,
    $$StreakStateTableAnnotationComposer,
    $$StreakStateTableCreateCompanionBuilder,
    $$StreakStateTableUpdateCompanionBuilder,
    (
      StreakStateData,
      BaseReferences<_$AppDatabase, $StreakStateTable, StreakStateData>
    ),
    StreakStateData,
    PrefetchHooks Function()>;
typedef $$ExerciseLogsTableCreateCompanionBuilder = ExerciseLogsCompanion
    Function({
  required String id,
  required String date,
  required String type,
  Value<int?> durationMin,
  Value<int?> energyRating,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<String?> muscleGroup,
  Value<int> rowid,
});
typedef $$ExerciseLogsTableUpdateCompanionBuilder = ExerciseLogsCompanion
    Function({
  Value<String> id,
  Value<String> date,
  Value<String> type,
  Value<int?> durationMin,
  Value<int?> energyRating,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<String?> muscleGroup,
  Value<int> rowid,
});

class $$ExerciseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseLogsTable> {
  $$ExerciseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get energyRating => $composableBuilder(
      column: $table.energyRating, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnFilters(column));
}

class $$ExerciseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseLogsTable> {
  $$ExerciseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get energyRating => $composableBuilder(
      column: $table.energyRating,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => ColumnOrderings(column));
}

class $$ExerciseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseLogsTable> {
  $$ExerciseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => column);

  GeneratedColumn<int> get energyRating => $composableBuilder(
      column: $table.energyRating, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
      column: $table.muscleGroup, builder: (column) => column);
}

class $$ExerciseLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExerciseLogsTable,
    ExerciseLog,
    $$ExerciseLogsTableFilterComposer,
    $$ExerciseLogsTableOrderingComposer,
    $$ExerciseLogsTableAnnotationComposer,
    $$ExerciseLogsTableCreateCompanionBuilder,
    $$ExerciseLogsTableUpdateCompanionBuilder,
    (
      ExerciseLog,
      BaseReferences<_$AppDatabase, $ExerciseLogsTable, ExerciseLog>
    ),
    ExerciseLog,
    PrefetchHooks Function()> {
  $$ExerciseLogsTableTableManager(_$AppDatabase db, $ExerciseLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int?> durationMin = const Value.absent(),
            Value<int?> energyRating = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> muscleGroup = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseLogsCompanion(
            id: id,
            date: date,
            type: type,
            durationMin: durationMin,
            energyRating: energyRating,
            notes: notes,
            createdAt: createdAt,
            muscleGroup: muscleGroup,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            required String type,
            Value<int?> durationMin = const Value.absent(),
            Value<int?> energyRating = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> muscleGroup = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExerciseLogsCompanion.insert(
            id: id,
            date: date,
            type: type,
            durationMin: durationMin,
            energyRating: energyRating,
            notes: notes,
            createdAt: createdAt,
            muscleGroup: muscleGroup,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ExerciseLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExerciseLogsTable,
    ExerciseLog,
    $$ExerciseLogsTableFilterComposer,
    $$ExerciseLogsTableOrderingComposer,
    $$ExerciseLogsTableAnnotationComposer,
    $$ExerciseLogsTableCreateCompanionBuilder,
    $$ExerciseLogsTableUpdateCompanionBuilder,
    (
      ExerciseLog,
      BaseReferences<_$AppDatabase, $ExerciseLogsTable, ExerciseLog>
    ),
    ExerciseLog,
    PrefetchHooks Function()>;
typedef $$SleepLogsTableCreateCompanionBuilder = SleepLogsCompanion Function({
  required String id,
  required String date,
  Value<String?> bedtime,
  Value<String?> wakeTime,
  Value<double?> hours,
  Value<int?> quality,
  Value<int> rowid,
});
typedef $$SleepLogsTableUpdateCompanionBuilder = SleepLogsCompanion Function({
  Value<String> id,
  Value<String> date,
  Value<String?> bedtime,
  Value<String?> wakeTime,
  Value<double?> hours,
  Value<int?> quality,
  Value<int> rowid,
});

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get bedtime => $composableBuilder(
      column: $table.bedtime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wakeTime => $composableBuilder(
      column: $table.wakeTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hours => $composableBuilder(
      column: $table.hours, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quality => $composableBuilder(
      column: $table.quality, builder: (column) => ColumnFilters(column));
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get bedtime => $composableBuilder(
      column: $table.bedtime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wakeTime => $composableBuilder(
      column: $table.wakeTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hours => $composableBuilder(
      column: $table.hours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quality => $composableBuilder(
      column: $table.quality, builder: (column) => ColumnOrderings(column));
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get bedtime =>
      $composableBuilder(column: $table.bedtime, builder: (column) => column);

  GeneratedColumn<String> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumn<double> get hours =>
      $composableBuilder(column: $table.hours, builder: (column) => column);

  GeneratedColumn<int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);
}

class $$SleepLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SleepLogsTable,
    SleepLog,
    $$SleepLogsTableFilterComposer,
    $$SleepLogsTableOrderingComposer,
    $$SleepLogsTableAnnotationComposer,
    $$SleepLogsTableCreateCompanionBuilder,
    $$SleepLogsTableUpdateCompanionBuilder,
    (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
    SleepLog,
    PrefetchHooks Function()> {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String?> bedtime = const Value.absent(),
            Value<String?> wakeTime = const Value.absent(),
            Value<double?> hours = const Value.absent(),
            Value<int?> quality = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepLogsCompanion(
            id: id,
            date: date,
            bedtime: bedtime,
            wakeTime: wakeTime,
            hours: hours,
            quality: quality,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            Value<String?> bedtime = const Value.absent(),
            Value<String?> wakeTime = const Value.absent(),
            Value<double?> hours = const Value.absent(),
            Value<int?> quality = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepLogsCompanion.insert(
            id: id,
            date: date,
            bedtime: bedtime,
            wakeTime: wakeTime,
            hours: hours,
            quality: quality,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SleepLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SleepLogsTable,
    SleepLog,
    $$SleepLogsTableFilterComposer,
    $$SleepLogsTableOrderingComposer,
    $$SleepLogsTableAnnotationComposer,
    $$SleepLogsTableCreateCompanionBuilder,
    $$SleepLogsTableUpdateCompanionBuilder,
    (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
    SleepLog,
    PrefetchHooks Function()>;
typedef $$WeightLogsTableCreateCompanionBuilder = WeightLogsCompanion Function({
  required String id,
  required String date,
  required double weightKg,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$WeightLogsTableUpdateCompanionBuilder = WeightLogsCompanion Function({
  Value<String> id,
  Value<String> date,
  Value<double> weightKg,
  Value<String?> notes,
  Value<int> rowid,
});

class $$WeightLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));
}

class $$WeightLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));
}

class $$WeightLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$WeightLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeightLogsTable,
    WeightLog,
    $$WeightLogsTableFilterComposer,
    $$WeightLogsTableOrderingComposer,
    $$WeightLogsTableAnnotationComposer,
    $$WeightLogsTableCreateCompanionBuilder,
    $$WeightLogsTableUpdateCompanionBuilder,
    (WeightLog, BaseReferences<_$AppDatabase, $WeightLogsTable, WeightLog>),
    WeightLog,
    PrefetchHooks Function()> {
  $$WeightLogsTableTableManager(_$AppDatabase db, $WeightLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<double> weightKg = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeightLogsCompanion(
            id: id,
            date: date,
            weightKg: weightKg,
            notes: notes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            required double weightKg,
            Value<String?> notes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeightLogsCompanion.insert(
            id: id,
            date: date,
            weightKg: weightKg,
            notes: notes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeightLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeightLogsTable,
    WeightLog,
    $$WeightLogsTableFilterComposer,
    $$WeightLogsTableOrderingComposer,
    $$WeightLogsTableAnnotationComposer,
    $$WeightLogsTableCreateCompanionBuilder,
    $$WeightLogsTableUpdateCompanionBuilder,
    (WeightLog, BaseReferences<_$AppDatabase, $WeightLogsTable, WeightLog>),
    WeightLog,
    PrefetchHooks Function()>;
typedef $$LearningLogsTableCreateCompanionBuilder = LearningLogsCompanion
    Function({
  required String id,
  required String date,
  required String subject,
  Value<int?> durationMin,
  Value<int?> focusRating,
  Value<int> rowid,
});
typedef $$LearningLogsTableUpdateCompanionBuilder = LearningLogsCompanion
    Function({
  Value<String> id,
  Value<String> date,
  Value<String> subject,
  Value<int?> durationMin,
  Value<int?> focusRating,
  Value<int> rowid,
});

class $$LearningLogsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningLogsTable> {
  $$LearningLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subject => $composableBuilder(
      column: $table.subject, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get focusRating => $composableBuilder(
      column: $table.focusRating, builder: (column) => ColumnFilters(column));
}

class $$LearningLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningLogsTable> {
  $$LearningLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subject => $composableBuilder(
      column: $table.subject, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get focusRating => $composableBuilder(
      column: $table.focusRating, builder: (column) => ColumnOrderings(column));
}

class $$LearningLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningLogsTable> {
  $$LearningLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => column);

  GeneratedColumn<int> get focusRating => $composableBuilder(
      column: $table.focusRating, builder: (column) => column);
}

class $$LearningLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LearningLogsTable,
    LearningLog,
    $$LearningLogsTableFilterComposer,
    $$LearningLogsTableOrderingComposer,
    $$LearningLogsTableAnnotationComposer,
    $$LearningLogsTableCreateCompanionBuilder,
    $$LearningLogsTableUpdateCompanionBuilder,
    (
      LearningLog,
      BaseReferences<_$AppDatabase, $LearningLogsTable, LearningLog>
    ),
    LearningLog,
    PrefetchHooks Function()> {
  $$LearningLogsTableTableManager(_$AppDatabase db, $LearningLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> subject = const Value.absent(),
            Value<int?> durationMin = const Value.absent(),
            Value<int?> focusRating = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LearningLogsCompanion(
            id: id,
            date: date,
            subject: subject,
            durationMin: durationMin,
            focusRating: focusRating,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            required String subject,
            Value<int?> durationMin = const Value.absent(),
            Value<int?> focusRating = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LearningLogsCompanion.insert(
            id: id,
            date: date,
            subject: subject,
            durationMin: durationMin,
            focusRating: focusRating,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LearningLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LearningLogsTable,
    LearningLog,
    $$LearningLogsTableFilterComposer,
    $$LearningLogsTableOrderingComposer,
    $$LearningLogsTableAnnotationComposer,
    $$LearningLogsTableCreateCompanionBuilder,
    $$LearningLogsTableUpdateCompanionBuilder,
    (
      LearningLog,
      BaseReferences<_$AppDatabase, $LearningLogsTable, LearningLog>
    ),
    LearningLog,
    PrefetchHooks Function()>;
typedef $$MartialArtsLogsTableCreateCompanionBuilder = MartialArtsLogsCompanion
    Function({
  required String id,
  required String date,
  Value<String?> focus,
  Value<String?> rank,
  Value<String?> note,
  Value<int> rowid,
});
typedef $$MartialArtsLogsTableUpdateCompanionBuilder = MartialArtsLogsCompanion
    Function({
  Value<String> id,
  Value<String> date,
  Value<String?> focus,
  Value<String?> rank,
  Value<String?> note,
  Value<int> rowid,
});

class $$MartialArtsLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MartialArtsLogsTable> {
  $$MartialArtsLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get focus => $composableBuilder(
      column: $table.focus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rank => $composableBuilder(
      column: $table.rank, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));
}

class $$MartialArtsLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MartialArtsLogsTable> {
  $$MartialArtsLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get focus => $composableBuilder(
      column: $table.focus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rank => $composableBuilder(
      column: $table.rank, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));
}

class $$MartialArtsLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MartialArtsLogsTable> {
  $$MartialArtsLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get focus =>
      $composableBuilder(column: $table.focus, builder: (column) => column);

  GeneratedColumn<String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$MartialArtsLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MartialArtsLogsTable,
    MartialArtsLog,
    $$MartialArtsLogsTableFilterComposer,
    $$MartialArtsLogsTableOrderingComposer,
    $$MartialArtsLogsTableAnnotationComposer,
    $$MartialArtsLogsTableCreateCompanionBuilder,
    $$MartialArtsLogsTableUpdateCompanionBuilder,
    (
      MartialArtsLog,
      BaseReferences<_$AppDatabase, $MartialArtsLogsTable, MartialArtsLog>
    ),
    MartialArtsLog,
    PrefetchHooks Function()> {
  $$MartialArtsLogsTableTableManager(
      _$AppDatabase db, $MartialArtsLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MartialArtsLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MartialArtsLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MartialArtsLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String?> focus = const Value.absent(),
            Value<String?> rank = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MartialArtsLogsCompanion(
            id: id,
            date: date,
            focus: focus,
            rank: rank,
            note: note,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            Value<String?> focus = const Value.absent(),
            Value<String?> rank = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MartialArtsLogsCompanion.insert(
            id: id,
            date: date,
            focus: focus,
            rank: rank,
            note: note,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MartialArtsLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MartialArtsLogsTable,
    MartialArtsLog,
    $$MartialArtsLogsTableFilterComposer,
    $$MartialArtsLogsTableOrderingComposer,
    $$MartialArtsLogsTableAnnotationComposer,
    $$MartialArtsLogsTableCreateCompanionBuilder,
    $$MartialArtsLogsTableUpdateCompanionBuilder,
    (
      MartialArtsLog,
      BaseReferences<_$AppDatabase, $MartialArtsLogsTable, MartialArtsLog>
    ),
    MartialArtsLog,
    PrefetchHooks Function()>;
typedef $$HobbyLogsTableCreateCompanionBuilder = HobbyLogsCompanion Function({
  required String id,
  required String date,
  required String category,
  required String hobby,
  Value<int?> durationMin,
  Value<int> rowid,
});
typedef $$HobbyLogsTableUpdateCompanionBuilder = HobbyLogsCompanion Function({
  Value<String> id,
  Value<String> date,
  Value<String> category,
  Value<String> hobby,
  Value<int?> durationMin,
  Value<int> rowid,
});

class $$HobbyLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HobbyLogsTable> {
  $$HobbyLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get hobby => $composableBuilder(
      column: $table.hobby, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnFilters(column));
}

class $$HobbyLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HobbyLogsTable> {
  $$HobbyLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get hobby => $composableBuilder(
      column: $table.hobby, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnOrderings(column));
}

class $$HobbyLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HobbyLogsTable> {
  $$HobbyLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get hobby =>
      $composableBuilder(column: $table.hobby, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => column);
}

class $$HobbyLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HobbyLogsTable,
    HobbyLog,
    $$HobbyLogsTableFilterComposer,
    $$HobbyLogsTableOrderingComposer,
    $$HobbyLogsTableAnnotationComposer,
    $$HobbyLogsTableCreateCompanionBuilder,
    $$HobbyLogsTableUpdateCompanionBuilder,
    (HobbyLog, BaseReferences<_$AppDatabase, $HobbyLogsTable, HobbyLog>),
    HobbyLog,
    PrefetchHooks Function()> {
  $$HobbyLogsTableTableManager(_$AppDatabase db, $HobbyLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HobbyLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HobbyLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HobbyLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> hobby = const Value.absent(),
            Value<int?> durationMin = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HobbyLogsCompanion(
            id: id,
            date: date,
            category: category,
            hobby: hobby,
            durationMin: durationMin,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            required String category,
            required String hobby,
            Value<int?> durationMin = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HobbyLogsCompanion.insert(
            id: id,
            date: date,
            category: category,
            hobby: hobby,
            durationMin: durationMin,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HobbyLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HobbyLogsTable,
    HobbyLog,
    $$HobbyLogsTableFilterComposer,
    $$HobbyLogsTableOrderingComposer,
    $$HobbyLogsTableAnnotationComposer,
    $$HobbyLogsTableCreateCompanionBuilder,
    $$HobbyLogsTableUpdateCompanionBuilder,
    (HobbyLog, BaseReferences<_$AppDatabase, $HobbyLogsTable, HobbyLog>),
    HobbyLog,
    PrefetchHooks Function()>;
typedef $$NutritionLogsTableCreateCompanionBuilder = NutritionLogsCompanion
    Function({
  required String id,
  required String date,
  required String meal,
  required String description,
  Value<bool> onPlan,
  Value<String?> photoPath,
  Value<double?> estCalories,
  Value<double?> estProteinG,
  Value<double?> estCarbsG,
  Value<double?> estFatG,
  Value<bool> aiEstimated,
  Value<int> rowid,
});
typedef $$NutritionLogsTableUpdateCompanionBuilder = NutritionLogsCompanion
    Function({
  Value<String> id,
  Value<String> date,
  Value<String> meal,
  Value<String> description,
  Value<bool> onPlan,
  Value<String?> photoPath,
  Value<double?> estCalories,
  Value<double?> estProteinG,
  Value<double?> estCarbsG,
  Value<double?> estFatG,
  Value<bool> aiEstimated,
  Value<int> rowid,
});

class $$NutritionLogsTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionLogsTable> {
  $$NutritionLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meal => $composableBuilder(
      column: $table.meal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get onPlan => $composableBuilder(
      column: $table.onPlan, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estCalories => $composableBuilder(
      column: $table.estCalories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estProteinG => $composableBuilder(
      column: $table.estProteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estCarbsG => $composableBuilder(
      column: $table.estCarbsG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get estFatG => $composableBuilder(
      column: $table.estFatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get aiEstimated => $composableBuilder(
      column: $table.aiEstimated, builder: (column) => ColumnFilters(column));
}

class $$NutritionLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionLogsTable> {
  $$NutritionLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meal => $composableBuilder(
      column: $table.meal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get onPlan => $composableBuilder(
      column: $table.onPlan, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoPath => $composableBuilder(
      column: $table.photoPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estCalories => $composableBuilder(
      column: $table.estCalories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estProteinG => $composableBuilder(
      column: $table.estProteinG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estCarbsG => $composableBuilder(
      column: $table.estCarbsG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get estFatG => $composableBuilder(
      column: $table.estFatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get aiEstimated => $composableBuilder(
      column: $table.aiEstimated, builder: (column) => ColumnOrderings(column));
}

class $$NutritionLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionLogsTable> {
  $$NutritionLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get meal =>
      $composableBuilder(column: $table.meal, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<bool> get onPlan =>
      $composableBuilder(column: $table.onPlan, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<double> get estCalories => $composableBuilder(
      column: $table.estCalories, builder: (column) => column);

  GeneratedColumn<double> get estProteinG => $composableBuilder(
      column: $table.estProteinG, builder: (column) => column);

  GeneratedColumn<double> get estCarbsG =>
      $composableBuilder(column: $table.estCarbsG, builder: (column) => column);

  GeneratedColumn<double> get estFatG =>
      $composableBuilder(column: $table.estFatG, builder: (column) => column);

  GeneratedColumn<bool> get aiEstimated => $composableBuilder(
      column: $table.aiEstimated, builder: (column) => column);
}

class $$NutritionLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NutritionLogsTable,
    NutritionLog,
    $$NutritionLogsTableFilterComposer,
    $$NutritionLogsTableOrderingComposer,
    $$NutritionLogsTableAnnotationComposer,
    $$NutritionLogsTableCreateCompanionBuilder,
    $$NutritionLogsTableUpdateCompanionBuilder,
    (
      NutritionLog,
      BaseReferences<_$AppDatabase, $NutritionLogsTable, NutritionLog>
    ),
    NutritionLog,
    PrefetchHooks Function()> {
  $$NutritionLogsTableTableManager(_$AppDatabase db, $NutritionLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> meal = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<bool> onPlan = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<double?> estCalories = const Value.absent(),
            Value<double?> estProteinG = const Value.absent(),
            Value<double?> estCarbsG = const Value.absent(),
            Value<double?> estFatG = const Value.absent(),
            Value<bool> aiEstimated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NutritionLogsCompanion(
            id: id,
            date: date,
            meal: meal,
            description: description,
            onPlan: onPlan,
            photoPath: photoPath,
            estCalories: estCalories,
            estProteinG: estProteinG,
            estCarbsG: estCarbsG,
            estFatG: estFatG,
            aiEstimated: aiEstimated,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            required String meal,
            required String description,
            Value<bool> onPlan = const Value.absent(),
            Value<String?> photoPath = const Value.absent(),
            Value<double?> estCalories = const Value.absent(),
            Value<double?> estProteinG = const Value.absent(),
            Value<double?> estCarbsG = const Value.absent(),
            Value<double?> estFatG = const Value.absent(),
            Value<bool> aiEstimated = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              NutritionLogsCompanion.insert(
            id: id,
            date: date,
            meal: meal,
            description: description,
            onPlan: onPlan,
            photoPath: photoPath,
            estCalories: estCalories,
            estProteinG: estProteinG,
            estCarbsG: estCarbsG,
            estFatG: estFatG,
            aiEstimated: aiEstimated,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NutritionLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NutritionLogsTable,
    NutritionLog,
    $$NutritionLogsTableFilterComposer,
    $$NutritionLogsTableOrderingComposer,
    $$NutritionLogsTableAnnotationComposer,
    $$NutritionLogsTableCreateCompanionBuilder,
    $$NutritionLogsTableUpdateCompanionBuilder,
    (
      NutritionLog,
      BaseReferences<_$AppDatabase, $NutritionLogsTable, NutritionLog>
    ),
    NutritionLog,
    PrefetchHooks Function()>;
typedef $$WeeklyReviewsTableCreateCompanionBuilder = WeeklyReviewsCompanion
    Function({
  required String id,
  required String date,
  Value<String?> win,
  Value<String?> adjust,
  Value<int> rowid,
});
typedef $$WeeklyReviewsTableUpdateCompanionBuilder = WeeklyReviewsCompanion
    Function({
  Value<String> id,
  Value<String> date,
  Value<String?> win,
  Value<String?> adjust,
  Value<int> rowid,
});

class $$WeeklyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get win => $composableBuilder(
      column: $table.win, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get adjust => $composableBuilder(
      column: $table.adjust, builder: (column) => ColumnFilters(column));
}

class $$WeeklyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get win => $composableBuilder(
      column: $table.win, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get adjust => $composableBuilder(
      column: $table.adjust, builder: (column) => ColumnOrderings(column));
}

class $$WeeklyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get win =>
      $composableBuilder(column: $table.win, builder: (column) => column);

  GeneratedColumn<String> get adjust =>
      $composableBuilder(column: $table.adjust, builder: (column) => column);
}

class $$WeeklyReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeeklyReviewsTable,
    WeeklyReview,
    $$WeeklyReviewsTableFilterComposer,
    $$WeeklyReviewsTableOrderingComposer,
    $$WeeklyReviewsTableAnnotationComposer,
    $$WeeklyReviewsTableCreateCompanionBuilder,
    $$WeeklyReviewsTableUpdateCompanionBuilder,
    (
      WeeklyReview,
      BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReview>
    ),
    WeeklyReview,
    PrefetchHooks Function()> {
  $$WeeklyReviewsTableTableManager(_$AppDatabase db, $WeeklyReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String?> win = const Value.absent(),
            Value<String?> adjust = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyReviewsCompanion(
            id: id,
            date: date,
            win: win,
            adjust: adjust,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String date,
            Value<String?> win = const Value.absent(),
            Value<String?> adjust = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyReviewsCompanion.insert(
            id: id,
            date: date,
            win: win,
            adjust: adjust,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeeklyReviewsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeeklyReviewsTable,
    WeeklyReview,
    $$WeeklyReviewsTableFilterComposer,
    $$WeeklyReviewsTableOrderingComposer,
    $$WeeklyReviewsTableAnnotationComposer,
    $$WeeklyReviewsTableCreateCompanionBuilder,
    $$WeeklyReviewsTableUpdateCompanionBuilder,
    (
      WeeklyReview,
      BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReview>
    ),
    WeeklyReview,
    PrefetchHooks Function()>;
typedef $$ReadingProgressTableCreateCompanionBuilder = ReadingProgressCompanion
    Function({
  required String chapterId,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<int> lastPageIndex,
  Value<int> rowid,
});
typedef $$ReadingProgressTableUpdateCompanionBuilder = ReadingProgressCompanion
    Function({
  Value<String> chapterId,
  Value<bool> completed,
  Value<DateTime?> completedAt,
  Value<int> lastPageIndex,
  Value<int> rowid,
});

class $$ReadingProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get chapterId => $composableBuilder(
      column: $table.chapterId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastPageIndex => $composableBuilder(
      column: $table.lastPageIndex, builder: (column) => ColumnFilters(column));
}

class $$ReadingProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get chapterId => $composableBuilder(
      column: $table.chapterId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastPageIndex => $composableBuilder(
      column: $table.lastPageIndex,
      builder: (column) => ColumnOrderings(column));
}

class $$ReadingProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingProgressTable> {
  $$ReadingProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get chapterId =>
      $composableBuilder(column: $table.chapterId, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<int> get lastPageIndex => $composableBuilder(
      column: $table.lastPageIndex, builder: (column) => column);
}

class $$ReadingProgressTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReadingProgressTable,
    ReadingProgressData,
    $$ReadingProgressTableFilterComposer,
    $$ReadingProgressTableOrderingComposer,
    $$ReadingProgressTableAnnotationComposer,
    $$ReadingProgressTableCreateCompanionBuilder,
    $$ReadingProgressTableUpdateCompanionBuilder,
    (
      ReadingProgressData,
      BaseReferences<_$AppDatabase, $ReadingProgressTable, ReadingProgressData>
    ),
    ReadingProgressData,
    PrefetchHooks Function()> {
  $$ReadingProgressTableTableManager(
      _$AppDatabase db, $ReadingProgressTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> chapterId = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> lastPageIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReadingProgressCompanion(
            chapterId: chapterId,
            completed: completed,
            completedAt: completedAt,
            lastPageIndex: lastPageIndex,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String chapterId,
            Value<bool> completed = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> lastPageIndex = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReadingProgressCompanion.insert(
            chapterId: chapterId,
            completed: completed,
            completedAt: completedAt,
            lastPageIndex: lastPageIndex,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReadingProgressTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReadingProgressTable,
    ReadingProgressData,
    $$ReadingProgressTableFilterComposer,
    $$ReadingProgressTableOrderingComposer,
    $$ReadingProgressTableAnnotationComposer,
    $$ReadingProgressTableCreateCompanionBuilder,
    $$ReadingProgressTableUpdateCompanionBuilder,
    (
      ReadingProgressData,
      BaseReferences<_$AppDatabase, $ReadingProgressTable, ReadingProgressData>
    ),
    ReadingProgressData,
    PrefetchHooks Function()>;
typedef $$UserPrefsTableCreateCompanionBuilder = UserPrefsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$UserPrefsTableUpdateCompanionBuilder = UserPrefsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$UserPrefsTableFilterComposer
    extends Composer<_$AppDatabase, $UserPrefsTable> {
  $$UserPrefsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$UserPrefsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPrefsTable> {
  $$UserPrefsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$UserPrefsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPrefsTable> {
  $$UserPrefsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$UserPrefsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserPrefsTable,
    UserPref,
    $$UserPrefsTableFilterComposer,
    $$UserPrefsTableOrderingComposer,
    $$UserPrefsTableAnnotationComposer,
    $$UserPrefsTableCreateCompanionBuilder,
    $$UserPrefsTableUpdateCompanionBuilder,
    (UserPref, BaseReferences<_$AppDatabase, $UserPrefsTable, UserPref>),
    UserPref,
    PrefetchHooks Function()> {
  $$UserPrefsTableTableManager(_$AppDatabase db, $UserPrefsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPrefsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPrefsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPrefsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserPrefsCompanion(
            key: key,
            value: value,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserPrefsCompanion.insert(
            key: key,
            value: value,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserPrefsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserPrefsTable,
    UserPref,
    $$UserPrefsTableFilterComposer,
    $$UserPrefsTableOrderingComposer,
    $$UserPrefsTableAnnotationComposer,
    $$UserPrefsTableCreateCompanionBuilder,
    $$UserPrefsTableUpdateCompanionBuilder,
    (UserPref, BaseReferences<_$AppDatabase, $UserPrefsTable, UserPref>),
    UserPref,
    PrefetchHooks Function()>;
typedef $$QuickLogsTableCreateCompanionBuilder = QuickLogsCompanion Function({
  required String id,
  required String type,
  Value<String?> subtype,
  Value<double?> value,
  Value<String?> unit,
  Value<int?> mood,
  Value<String?> note,
  required String date,
  Value<DateTime> timestamp,
  Value<int> rowid,
});
typedef $$QuickLogsTableUpdateCompanionBuilder = QuickLogsCompanion Function({
  Value<String> id,
  Value<String> type,
  Value<String?> subtype,
  Value<double?> value,
  Value<String?> unit,
  Value<int?> mood,
  Value<String?> note,
  Value<String> date,
  Value<DateTime> timestamp,
  Value<int> rowid,
});

class $$QuickLogsTableFilterComposer
    extends Composer<_$AppDatabase, $QuickLogsTable> {
  $$QuickLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get subtype => $composableBuilder(
      column: $table.subtype, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));
}

class $$QuickLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuickLogsTable> {
  $$QuickLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get subtype => $composableBuilder(
      column: $table.subtype, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mood => $composableBuilder(
      column: $table.mood, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));
}

class $$QuickLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuickLogsTable> {
  $$QuickLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get subtype =>
      $composableBuilder(column: $table.subtype, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$QuickLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuickLogsTable,
    QuickLog,
    $$QuickLogsTableFilterComposer,
    $$QuickLogsTableOrderingComposer,
    $$QuickLogsTableAnnotationComposer,
    $$QuickLogsTableCreateCompanionBuilder,
    $$QuickLogsTableUpdateCompanionBuilder,
    (QuickLog, BaseReferences<_$AppDatabase, $QuickLogsTable, QuickLog>),
    QuickLog,
    PrefetchHooks Function()> {
  $$QuickLogsTableTableManager(_$AppDatabase db, $QuickLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuickLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuickLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuickLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String?> subtype = const Value.absent(),
            Value<double?> value = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<int?> mood = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuickLogsCompanion(
            id: id,
            type: type,
            subtype: subtype,
            value: value,
            unit: unit,
            mood: mood,
            note: note,
            date: date,
            timestamp: timestamp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            Value<String?> subtype = const Value.absent(),
            Value<double?> value = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<int?> mood = const Value.absent(),
            Value<String?> note = const Value.absent(),
            required String date,
            Value<DateTime> timestamp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuickLogsCompanion.insert(
            id: id,
            type: type,
            subtype: subtype,
            value: value,
            unit: unit,
            mood: mood,
            note: note,
            date: date,
            timestamp: timestamp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$QuickLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuickLogsTable,
    QuickLog,
    $$QuickLogsTableFilterComposer,
    $$QuickLogsTableOrderingComposer,
    $$QuickLogsTableAnnotationComposer,
    $$QuickLogsTableCreateCompanionBuilder,
    $$QuickLogsTableUpdateCompanionBuilder,
    (QuickLog, BaseReferences<_$AppDatabase, $QuickLogsTable, QuickLog>),
    QuickLog,
    PrefetchHooks Function()>;
typedef $$HabitCalendarEventsTableCreateCompanionBuilder
    = HabitCalendarEventsCompanion Function({
  required String habitId,
  required String date,
  required String eventId,
  required String calendarId,
  required DateTime scheduledStart,
  required DateTime scheduledEnd,
  Value<int> rowid,
});
typedef $$HabitCalendarEventsTableUpdateCompanionBuilder
    = HabitCalendarEventsCompanion Function({
  Value<String> habitId,
  Value<String> date,
  Value<String> eventId,
  Value<String> calendarId,
  Value<DateTime> scheduledStart,
  Value<DateTime> scheduledEnd,
  Value<int> rowid,
});

class $$HabitCalendarEventsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCalendarEventsTable> {
  $$HabitCalendarEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventId => $composableBuilder(
      column: $table.eventId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get calendarId => $composableBuilder(
      column: $table.calendarId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledStart => $composableBuilder(
      column: $table.scheduledStart,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledEnd => $composableBuilder(
      column: $table.scheduledEnd, builder: (column) => ColumnFilters(column));
}

class $$HabitCalendarEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCalendarEventsTable> {
  $$HabitCalendarEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventId => $composableBuilder(
      column: $table.eventId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get calendarId => $composableBuilder(
      column: $table.calendarId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledStart => $composableBuilder(
      column: $table.scheduledStart,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledEnd => $composableBuilder(
      column: $table.scheduledEnd,
      builder: (column) => ColumnOrderings(column));
}

class $$HabitCalendarEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCalendarEventsTable> {
  $$HabitCalendarEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get calendarId => $composableBuilder(
      column: $table.calendarId, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledStart => $composableBuilder(
      column: $table.scheduledStart, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledEnd => $composableBuilder(
      column: $table.scheduledEnd, builder: (column) => column);
}

class $$HabitCalendarEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitCalendarEventsTable,
    HabitCalendarEvent,
    $$HabitCalendarEventsTableFilterComposer,
    $$HabitCalendarEventsTableOrderingComposer,
    $$HabitCalendarEventsTableAnnotationComposer,
    $$HabitCalendarEventsTableCreateCompanionBuilder,
    $$HabitCalendarEventsTableUpdateCompanionBuilder,
    (
      HabitCalendarEvent,
      BaseReferences<_$AppDatabase, $HabitCalendarEventsTable,
          HabitCalendarEvent>
    ),
    HabitCalendarEvent,
    PrefetchHooks Function()> {
  $$HabitCalendarEventsTableTableManager(
      _$AppDatabase db, $HabitCalendarEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCalendarEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCalendarEventsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCalendarEventsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> habitId = const Value.absent(),
            Value<String> date = const Value.absent(),
            Value<String> eventId = const Value.absent(),
            Value<String> calendarId = const Value.absent(),
            Value<DateTime> scheduledStart = const Value.absent(),
            Value<DateTime> scheduledEnd = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitCalendarEventsCompanion(
            habitId: habitId,
            date: date,
            eventId: eventId,
            calendarId: calendarId,
            scheduledStart: scheduledStart,
            scheduledEnd: scheduledEnd,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String habitId,
            required String date,
            required String eventId,
            required String calendarId,
            required DateTime scheduledStart,
            required DateTime scheduledEnd,
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitCalendarEventsCompanion.insert(
            habitId: habitId,
            date: date,
            eventId: eventId,
            calendarId: calendarId,
            scheduledStart: scheduledStart,
            scheduledEnd: scheduledEnd,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitCalendarEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitCalendarEventsTable,
    HabitCalendarEvent,
    $$HabitCalendarEventsTableFilterComposer,
    $$HabitCalendarEventsTableOrderingComposer,
    $$HabitCalendarEventsTableAnnotationComposer,
    $$HabitCalendarEventsTableCreateCompanionBuilder,
    $$HabitCalendarEventsTableUpdateCompanionBuilder,
    (
      HabitCalendarEvent,
      BaseReferences<_$AppDatabase, $HabitCalendarEventsTable,
          HabitCalendarEvent>
    ),
    HabitCalendarEvent,
    PrefetchHooks Function()>;
typedef $$BlockedAppsTableCreateCompanionBuilder = BlockedAppsCompanion
    Function({
  required String packageName,
  required String label,
  Value<bool> enabled,
  Value<int> rowid,
});
typedef $$BlockedAppsTableUpdateCompanionBuilder = BlockedAppsCompanion
    Function({
  Value<String> packageName,
  Value<String> label,
  Value<bool> enabled,
  Value<int> rowid,
});

class $$BlockedAppsTableFilterComposer
    extends Composer<_$AppDatabase, $BlockedAppsTable> {
  $$BlockedAppsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnFilters(column));
}

class $$BlockedAppsTableOrderingComposer
    extends Composer<_$AppDatabase, $BlockedAppsTable> {
  $$BlockedAppsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get label => $composableBuilder(
      column: $table.label, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnOrderings(column));
}

class $$BlockedAppsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BlockedAppsTable> {
  $$BlockedAppsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get packageName => $composableBuilder(
      column: $table.packageName, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);
}

class $$BlockedAppsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BlockedAppsTable,
    BlockedApp,
    $$BlockedAppsTableFilterComposer,
    $$BlockedAppsTableOrderingComposer,
    $$BlockedAppsTableAnnotationComposer,
    $$BlockedAppsTableCreateCompanionBuilder,
    $$BlockedAppsTableUpdateCompanionBuilder,
    (BlockedApp, BaseReferences<_$AppDatabase, $BlockedAppsTable, BlockedApp>),
    BlockedApp,
    PrefetchHooks Function()> {
  $$BlockedAppsTableTableManager(_$AppDatabase db, $BlockedAppsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BlockedAppsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BlockedAppsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BlockedAppsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> packageName = const Value.absent(),
            Value<String> label = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BlockedAppsCompanion(
            packageName: packageName,
            label: label,
            enabled: enabled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String packageName,
            required String label,
            Value<bool> enabled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BlockedAppsCompanion.insert(
            packageName: packageName,
            label: label,
            enabled: enabled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BlockedAppsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BlockedAppsTable,
    BlockedApp,
    $$BlockedAppsTableFilterComposer,
    $$BlockedAppsTableOrderingComposer,
    $$BlockedAppsTableAnnotationComposer,
    $$BlockedAppsTableCreateCompanionBuilder,
    $$BlockedAppsTableUpdateCompanionBuilder,
    (BlockedApp, BaseReferences<_$AppDatabase, $BlockedAppsTable, BlockedApp>),
    BlockedApp,
    PrefetchHooks Function()>;
typedef $$ScreenTimeCreditsTableCreateCompanionBuilder
    = ScreenTimeCreditsCompanion Function({
  required String date,
  Value<int> earnedMinutes,
  Value<int> usedMinutes,
  Value<int> rowid,
});
typedef $$ScreenTimeCreditsTableUpdateCompanionBuilder
    = ScreenTimeCreditsCompanion Function({
  Value<String> date,
  Value<int> earnedMinutes,
  Value<int> usedMinutes,
  Value<int> rowid,
});

class $$ScreenTimeCreditsTableFilterComposer
    extends Composer<_$AppDatabase, $ScreenTimeCreditsTable> {
  $$ScreenTimeCreditsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get earnedMinutes => $composableBuilder(
      column: $table.earnedMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get usedMinutes => $composableBuilder(
      column: $table.usedMinutes, builder: (column) => ColumnFilters(column));
}

class $$ScreenTimeCreditsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScreenTimeCreditsTable> {
  $$ScreenTimeCreditsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get earnedMinutes => $composableBuilder(
      column: $table.earnedMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usedMinutes => $composableBuilder(
      column: $table.usedMinutes, builder: (column) => ColumnOrderings(column));
}

class $$ScreenTimeCreditsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScreenTimeCreditsTable> {
  $$ScreenTimeCreditsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get earnedMinutes => $composableBuilder(
      column: $table.earnedMinutes, builder: (column) => column);

  GeneratedColumn<int> get usedMinutes => $composableBuilder(
      column: $table.usedMinutes, builder: (column) => column);
}

class $$ScreenTimeCreditsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ScreenTimeCreditsTable,
    ScreenTimeCredit,
    $$ScreenTimeCreditsTableFilterComposer,
    $$ScreenTimeCreditsTableOrderingComposer,
    $$ScreenTimeCreditsTableAnnotationComposer,
    $$ScreenTimeCreditsTableCreateCompanionBuilder,
    $$ScreenTimeCreditsTableUpdateCompanionBuilder,
    (
      ScreenTimeCredit,
      BaseReferences<_$AppDatabase, $ScreenTimeCreditsTable, ScreenTimeCredit>
    ),
    ScreenTimeCredit,
    PrefetchHooks Function()> {
  $$ScreenTimeCreditsTableTableManager(
      _$AppDatabase db, $ScreenTimeCreditsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScreenTimeCreditsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScreenTimeCreditsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScreenTimeCreditsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> date = const Value.absent(),
            Value<int> earnedMinutes = const Value.absent(),
            Value<int> usedMinutes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ScreenTimeCreditsCompanion(
            date: date,
            earnedMinutes: earnedMinutes,
            usedMinutes: usedMinutes,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String date,
            Value<int> earnedMinutes = const Value.absent(),
            Value<int> usedMinutes = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ScreenTimeCreditsCompanion.insert(
            date: date,
            earnedMinutes: earnedMinutes,
            usedMinutes: usedMinutes,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ScreenTimeCreditsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ScreenTimeCreditsTable,
    ScreenTimeCredit,
    $$ScreenTimeCreditsTableFilterComposer,
    $$ScreenTimeCreditsTableOrderingComposer,
    $$ScreenTimeCreditsTableAnnotationComposer,
    $$ScreenTimeCreditsTableCreateCompanionBuilder,
    $$ScreenTimeCreditsTableUpdateCompanionBuilder,
    (
      ScreenTimeCredit,
      BaseReferences<_$AppDatabase, $ScreenTimeCreditsTable, ScreenTimeCredit>
    ),
    ScreenTimeCredit,
    PrefetchHooks Function()>;
typedef $$AiWeeklyReviewsTableCreateCompanionBuilder = AiWeeklyReviewsCompanion
    Function({
  required String weekStart,
  required String content,
  Value<DateTime> generatedAt,
  Value<int> rowid,
});
typedef $$AiWeeklyReviewsTableUpdateCompanionBuilder = AiWeeklyReviewsCompanion
    Function({
  Value<String> weekStart,
  Value<String> content,
  Value<DateTime> generatedAt,
  Value<int> rowid,
});

class $$AiWeeklyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $AiWeeklyReviewsTable> {
  $$AiWeeklyReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnFilters(column));
}

class $$AiWeeklyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiWeeklyReviewsTable> {
  $$AiWeeklyReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AiWeeklyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiWeeklyReviewsTable> {
  $$AiWeeklyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
      column: $table.generatedAt, builder: (column) => column);
}

class $$AiWeeklyReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AiWeeklyReviewsTable,
    AiWeeklyReview,
    $$AiWeeklyReviewsTableFilterComposer,
    $$AiWeeklyReviewsTableOrderingComposer,
    $$AiWeeklyReviewsTableAnnotationComposer,
    $$AiWeeklyReviewsTableCreateCompanionBuilder,
    $$AiWeeklyReviewsTableUpdateCompanionBuilder,
    (
      AiWeeklyReview,
      BaseReferences<_$AppDatabase, $AiWeeklyReviewsTable, AiWeeklyReview>
    ),
    AiWeeklyReview,
    PrefetchHooks Function()> {
  $$AiWeeklyReviewsTableTableManager(
      _$AppDatabase db, $AiWeeklyReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiWeeklyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiWeeklyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiWeeklyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> weekStart = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> generatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AiWeeklyReviewsCompanion(
            weekStart: weekStart,
            content: content,
            generatedAt: generatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String weekStart,
            required String content,
            Value<DateTime> generatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AiWeeklyReviewsCompanion.insert(
            weekStart: weekStart,
            content: content,
            generatedAt: generatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AiWeeklyReviewsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AiWeeklyReviewsTable,
    AiWeeklyReview,
    $$AiWeeklyReviewsTableFilterComposer,
    $$AiWeeklyReviewsTableOrderingComposer,
    $$AiWeeklyReviewsTableAnnotationComposer,
    $$AiWeeklyReviewsTableCreateCompanionBuilder,
    $$AiWeeklyReviewsTableUpdateCompanionBuilder,
    (
      AiWeeklyReview,
      BaseReferences<_$AppDatabase, $AiWeeklyReviewsTable, AiWeeklyReview>
    ),
    AiWeeklyReview,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DailyStateTableTableManager get dailyState =>
      $$DailyStateTableTableManager(_db, _db.dailyState);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$StreakStateTableTableManager get streakState =>
      $$StreakStateTableTableManager(_db, _db.streakState);
  $$ExerciseLogsTableTableManager get exerciseLogs =>
      $$ExerciseLogsTableTableManager(_db, _db.exerciseLogs);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$WeightLogsTableTableManager get weightLogs =>
      $$WeightLogsTableTableManager(_db, _db.weightLogs);
  $$LearningLogsTableTableManager get learningLogs =>
      $$LearningLogsTableTableManager(_db, _db.learningLogs);
  $$MartialArtsLogsTableTableManager get martialArtsLogs =>
      $$MartialArtsLogsTableTableManager(_db, _db.martialArtsLogs);
  $$HobbyLogsTableTableManager get hobbyLogs =>
      $$HobbyLogsTableTableManager(_db, _db.hobbyLogs);
  $$NutritionLogsTableTableManager get nutritionLogs =>
      $$NutritionLogsTableTableManager(_db, _db.nutritionLogs);
  $$WeeklyReviewsTableTableManager get weeklyReviews =>
      $$WeeklyReviewsTableTableManager(_db, _db.weeklyReviews);
  $$ReadingProgressTableTableManager get readingProgress =>
      $$ReadingProgressTableTableManager(_db, _db.readingProgress);
  $$UserPrefsTableTableManager get userPrefs =>
      $$UserPrefsTableTableManager(_db, _db.userPrefs);
  $$QuickLogsTableTableManager get quickLogs =>
      $$QuickLogsTableTableManager(_db, _db.quickLogs);
  $$HabitCalendarEventsTableTableManager get habitCalendarEvents =>
      $$HabitCalendarEventsTableTableManager(_db, _db.habitCalendarEvents);
  $$BlockedAppsTableTableManager get blockedApps =>
      $$BlockedAppsTableTableManager(_db, _db.blockedApps);
  $$ScreenTimeCreditsTableTableManager get screenTimeCredits =>
      $$ScreenTimeCreditsTableTableManager(_db, _db.screenTimeCredits);
  $$AiWeeklyReviewsTableTableManager get aiWeeklyReviews =>
      $$AiWeeklyReviewsTableTableManager(_db, _db.aiWeeklyReviews);
}
