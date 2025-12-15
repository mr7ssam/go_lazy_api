import 'package:database/src/tables/index.dart';
import 'package:drift/drift.dart';
import 'package:go/go_domain.dart';
import 'package:uuid/uuid.dart';

@TableIndex(name: 'idx_go_participants_lookup', columns: {#eventId, #userId})
class GoParticipantsTable extends Table {
  TextColumn get id => text().clientDefault(const Uuid().v4)();

  TextColumn get eventId => text().references(GoEventsTable, #id)();

  TextColumn get userId => text().references(UserTable, #id)();

  TextColumn get status => textEnum<GoParticipantStatusEnum>()();

  TextColumn get invitedBy => text().references(UserTable, #id)();

  DateTimeColumn get invitedAt =>
      dateTime().clientDefault(DateTime.now().toUtc)();

  DateTimeColumn? get respondedAt => dateTime().nullable()();

  BoolColumn get isActive =>
      boolean().customConstraint('NOT NULL DEFAULT true')();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
        {eventId, userId},
      ];

  @override
  String get tableName => 'go_participants';
}
