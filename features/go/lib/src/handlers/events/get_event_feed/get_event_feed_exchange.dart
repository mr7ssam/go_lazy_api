import 'package:go/go_domain.dart';

class GetEventFeedRequest {
  GetEventFeedRequest({
    this.startDate,
    this.endDate,
    this.limit = 20,
    this.offset = 0,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final int limit;
  final int offset;
}

class GetEventFeedResponse {
  GetEventFeedResponse({
    required this.events,
    required this.total,
    required this.hasMore,
  });

  final List<EventSummary> events;
  final int total;
  final bool hasMore;

  Map<String, dynamic> toJson() => {
        'events': events.map((e) => e.toJson()).toList(),
        'total': total,
        'hasMore': hasMore,
      };
}

class EventSummary {
  EventSummary({
    required this.id,
    required this.title,
    required this.startDate,
    required this.visibility,
    this.description,
    this.endDate,
    this.locationId,
    this.coverImageUrl,
    this.groupId,
  });

  factory EventSummary.fromGoEvent(GoEvent event) {
    return EventSummary(
      id: event.id,
      title: event.title,
      description: event.description,
      startDate: event.startDate,
      endDate: event.endDate,
      locationId: event.locationId,
      coverImageUrl: event.coverImageUrl,
      groupId: event.groupId,
      visibility: event.visibility,
    );
  }

  final String id;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final String? locationId;
  final String? coverImageUrl;
  final String? groupId;
  final GoVisibilityEnum visibility;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'locationId': locationId,
        'coverImageUrl': coverImageUrl,
        'groupId': groupId,
        'visibility': visibility.name,
      };
}
