import 'package:go/go_domain.dart';

abstract class IGoEventsRepo {
  Future<GoEvent> createEvent(GoEvent event);
  Future<void> updateEvent(GoEvent event);
  Future<GoEvent?> getEventById(String id);
  Future<List<GoEvent>> getUserEvents(String userId);
  Future<List<GoEvent>> getGroupEvents(String groupId);
  Future<void> deleteEvent(String id);
}
