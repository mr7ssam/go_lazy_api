# Go Feature - Events & Tasks

## Overview

**Go** is a complete event planning system with collaborative task management. Users create events/outings (e.g., "Go to the beach", "BBQ at the park"), invite participants, and assign tasks with smart reminders to ensure event success.

---

## Core Concepts

| Concept | Description |
|---------|-------------|
| **Event** | An outing/gathering with date, location, and participants |
| **Location** | Reusable location object with name, address, and coordinates |
| **Participant** | User invited to event with RSVP status |
| **Task** | Action item for the event (bring something, prepare, arrange) |
| **Reminder** | Notification for task (time-based) |
| **Saved Location** | Favorite locations saved at user or group level for quick reuse |
| **Poll** | Voting mechanism for date/venue decisions |
| **AI Suggestion** | AI-powered event/venue recommendations based on user inputs |

---

## Unique Features

### 📝 Personal Checklist
- **Private Tasks**: Tasks are visible only to the creator ("Don't forget my ticket")
- **Simple Status**: Checkbox style (Done / Not Done)
- **Categories**: 🛒 Bring, 🍖 Prepare, 📍 Arrange, 🎯 Activity
- **Dependencies**: "Buy meat" → "Marinate meat" (task chains)


### 🔔 Flexible Reminders

- **Time-before-event**: "2 hours before BBQ starts"
- **Time-before-deadline**: "24 hours before task is due"
- **Specific time**: "December 19th at 6 PM"
- **Escalation**: Re-remind if task still incomplete

### 📍 Saved Locations

- **User-level**: Save personal favorite spots ("My favorite cafe", "Home")
- **Group-level**: Shared locations for the group ("Our usual spot", "Office")
- **Quick Selection**: Pick from saved locations when creating events
- **Auto-suggest**: Suggest saved locations based on activity type

### 🔄 Recurring Events

- **Frequency Options**: Daily, weekly, bi-weekly, monthly, yearly, custom
- **End Conditions**: Never, after X occurrences, until specific date
- **Specific Days**: "Every Monday and Thursday"
- **Monthly Patterns**: "First Saturday of every month", "15th of every month"
- **Task Inheritance**: Copy tasks to each occurrence or rotate assignments
- **Edit Options**: Edit single occurrence, this and future, or all occurrences

### 💰 Cost Tracking
- Mark tasks as expenses with amount
- Auto-calculate total spent per person
- Built-in expense splitting

### 🗳️ Collaborative Planning

- Polls for date/venue voting
- Democratic event decisions
- Comments per task for coordination

### 🤖 AI Event Suggestions

- **"Don't know where to go?"** - AI suggests events based on inputs
- **Structured Inputs**: Group size, budget, date/time, activity type, distance willing to travel
- **Preferences**: Indoor/outdoor, kid-friendly, pet-friendly, accessibility needs
- **Mood/Vibe**: Adventurous, relaxing, social, romantic, active
- **Optional Notes**: Free-text for additional context ("we want something unique", "avoid crowded places")
- **Smart Prompt Building**: Combines all inputs into optimized AI prompt
- **Multiple Suggestions**: Returns ranked list of venue/activity ideas with details

---

## Architecture

### Directory Structure

```
features/go/
├── lib/
│   ├── go_data.dart
│   ├── go_domain.dart
│   ├── go_handlers.dart
│   └── src/
│       ├── data/
│       │   ├── index.dart
│       │   ├── repo/
│       │   │   ├── go_events_repo.dart
│       │   │   ├── go_participants_repo.dart
│       │   │   └── go_tasks_repo.dart
│       │   └── transformers/
│       │       ├── go_event_transformer.dart
│       │       ├── go_participant_transformer.dart
│       │       ├── go_task_transformer.dart
│       │       └── go_reminder_transformer.dart
│       │
│       ├── domain/
│       │   ├── index.dart
│       │   ├── go_events_repo.dart          # IGoEventsRepo
│       │   ├── go_tasks_repo.dart           # IGoTasksRepo
│       │   └── entities/
│       │       ├── go_event.dart
│       │       ├── go_participant.dart
│       │       ├── go_rsvp_status.dart
│       │       ├── go_visibility.dart
│       │       ├── go_location.dart         # Reusable location object
│       │       ├── go_task.dart
│       │       ├── go_task_status.dart
│       │       ├── go_task_category.dart
│       │       ├── go_reminder.dart
│       │       ├── go_reminder_type.dart
│       │       ├── go_saved_location.dart    # Saved locations
│       │       ├── go_recurrence.dart        # Recurring event config
│       │       ├── go_poll.dart
│       │       ├── go_poll_option.dart
│       │       ├── go_suggestion_input.dart  # AI suggestion inputs
│       │       └── go_suggestion.dart        # AI suggestion response
│       │
│       └── handlers/
│           ├── index.dart
│           │
│           ├── events/
│           │   ├── create_event/
│           │   ├── get_event/
│           │   ├── get_user_events/
│           │   ├── update_event/
│           │   ├── delete_event/
│           │   ├── rsvp/
│           │   ├── invite_users/
│           │   ├── get_event_progress/
│           │   └── check_in/
│           │
│           ├── tasks/
│           │   ├── create_task/
│           │   ├── get_event_tasks/
│           │   ├── update_task/
│           │   ├── delete_task/
│           │   ├── assign_task/
│           │   ├── claim_task/
│           │   ├── complete_task/
│           │   └── add_expense/
│           │
│           ├── reminders/
│           │   ├── create_reminder/
│           │   ├── update_reminder/
│           │   └── delete_reminder/
│           │
│           ├── locations/
│           │   ├── create_saved_location/    # Save location (user/group)
│           │   ├── get_saved_locations/      # List saved locations
│           │   ├── update_saved_location/
│           │   └── delete_saved_location/
│           │
│           └── polls/
│           │   ├── create_poll/
│           │   ├── vote_poll/
│           │   └── close_poll/
│           │
│           └── suggestions/
│               └── get_ai_suggestions/      # AI event suggestions
│
├── pubspec.yaml
└── test/
    ├── data/
    ├── domain/
    └── handlers/
```

### Routes Structure

```
routes/go/
├── _middleware.dart
├── index.dart                   # GET list / POST create
├── feed.dart                    # GET discover events
└── [id]/
    ├── index.dart               # GET / PATCH / DELETE
    ├── rsvp.dart                # POST
    ├── invite.dart              # POST
    ├── check-in.dart            # POST
    ├── progress.dart            # GET
    │
    ├── participants/
    │   └── [userId].dart        # DELETE
    │
    ├── tasks/
    │   ├── index.dart           # GET / POST
    │   ├── suggestions.dart     # GET AI suggestions
    │   └── [taskId]/
    │       ├── index.dart       # GET / PATCH / DELETE
    │       ├── assign.dart      # POST
    │       ├── claim.dart       # POST
    │       ├── complete.dart    # POST
    │       ├── expense.dart     # POST
    │       └── reminders/
    │           ├── index.dart   # GET / POST
    │           └── [reminderId].dart  # PATCH / DELETE
    │
    └── polls/
        ├── index.dart           # GET / POST
        └── [pollId]/
            ├── index.dart       # GET / DELETE
            └── vote.dart        # POST

routes/go/
├── suggestions.dart             # POST /go/suggestions (AI suggestions)
├── locations/
│   ├── index.dart               # GET / POST saved locations (user-level)
│   └── [locationId].dart        # GET / PATCH / DELETE saved location

routes/groups/[id]/
├── locations/
│   ├── index.dart               # GET / POST saved locations (group-level)
│   └── [locationId].dart        # GET / PATCH / DELETE
```

---

## Database Schema

### `GoLocation` Value Object

> Reusable location structure used in events and reminders

```dart
class GoLocation {
  final String name;          // "Central Park - BBQ Area 3"
  final String? address;      // "Central Park, New York, NY"
  final double? lat;          // 40.7829
  final double? lng;          // -73.9654
  final String? placeId;      // Google Places ID (optional)
  final String? imageUrl;     // Venue image (optional)

  const GoLocation({
    required this.name,
    this.address,
    this.lat,
    this.lng,
    this.placeId,
    this.imageUrl,
  });
}
```

### `GoSuggestionInput` Value Object

> Structured input for AI event suggestions

```dart
class GoSuggestionInput {
  final int groupSize;
  final GoBudgetRange? budget;
  final GoDatePreferences? datePreferences;
  final List<GoActivityType> activityTypes;  // outdoor, indoor, food, adventure, relaxing, social
  final double? maxDistance;
  final String? distanceUnit;                // km or miles
  final GoLocation? currentLocation;
  final GoPreferences? preferences;
  final List<GoMood>? mood;                  // adventurous, romantic, social, active, relaxing
  final String? notes;                       // Free-text additional context

  const GoSuggestionInput({
    required this.groupSize,
    required this.activityTypes,
    this.budget,
    this.datePreferences,
    this.maxDistance,
    this.distanceUnit,
    this.currentLocation,
    this.preferences,
    this.mood,
    this.notes,
  });
}

class GoBudgetRange {
  final double? min;
  final double? max;
  final String currency;

  const GoBudgetRange({
    this.min,
    this.max,
    this.currency = 'USD',
  });
}

class GoDatePreferences {
  final DateTime? date;
  final String? timeOfDay;      // morning, afternoon, evening, night
  final String? duration;       // "2-3 hours", "half-day", "full-day"

  const GoDatePreferences({
    this.date,
    this.timeOfDay,
    this.duration,
  });
}

class GoPreferences {
  final bool kidFriendly;
  final bool petFriendly;
  final bool accessibilityNeeds;
  final String? indoorOutdoor;  // indoor, outdoor, both

  const GoPreferences({
    this.kidFriendly = false,
    this.petFriendly = false,
    this.accessibilityNeeds = false,
    this.indoorOutdoor,
  });
}

enum GoActivityType { outdoor, indoor, food, adventure, relaxing, social, cultural, sports }
enum GoMood { adventurous, romantic, social, active, relaxing, unique, casual, upscale }
```

### `GoRecurrence` Value Object

> Configuration for recurring events

```dart
class GoRecurrence {
  final GoFrequency frequency;       // daily, weekly, biweekly, monthly, yearly, custom
  final int interval;                // Every X (e.g., every 2 weeks)
  final List<String>? daysOfWeek;    // ["monday", "thursday"] for weekly
  final int? dayOfMonth;             // 1-31 for monthly
  final int? weekOfMonth;            // 1-5 (1st, 2nd, 3rd, 4th, last) for monthly
  final String? dayOfWeekInMonth;    // "monday" for "first Monday of month"
  final GoEndType endType;           // never, after_count, until_date
  final int? endAfterCount;          // Stop after X occurrences
  final DateTime? endUntilDate;      // Stop after this date
  final GoTaskMode taskMode;         // copy or rotate

  const GoRecurrence({
    required this.frequency,
    required this.endType,
    this.interval = 1,
    this.daysOfWeek,
    this.dayOfMonth,
    this.weekOfMonth,
    this.dayOfWeekInMonth,
    this.endAfterCount,
    this.endUntilDate,
    this.taskMode = GoTaskMode.copy,
  });
}

enum GoFrequency { daily, weekly, biweekly, monthly, yearly, custom }
enum GoEndType { never, afterCount, untilDate }
enum GoTaskMode { copy, rotate }  // copy = duplicate tasks, rotate = cycle assignments
```

### `go_events` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| creator_id | UUID | FK → users | Event creator |
| group_id | UUID? | FK → groups | Optional group link |
| title | VARCHAR(100) | NOT NULL | Event name |
| description | TEXT | | Event details |
| cover_image | TEXT | | Cloudinary URL |
| location_name | VARCHAR(255) | | Location: venue name |
| location_address | TEXT | | Location: full address |
| location_lat | DOUBLE | | Location: latitude |
| location_lng | DOUBLE | | Location: longitude |
| location_place_id | VARCHAR(255) | | Location: Google Places ID |
| location_image_url | TEXT | | Location: venue image |
| starts_at | TIMESTAMP | NOT NULL | Event start |
| ends_at | TIMESTAMP | | Event end |
| visibility | VARCHAR(20) | NOT NULL | private/group/friends/public |
| max_participants | INT | | Capacity (null = unlimited) |
| estimated_cost | DECIMAL(10,2) | | Cost per person |
| is_recurring | BOOLEAN | DEFAULT false | Has recurrence rule |
| parent_event_id | UUID | FK → go_events | For recurring: link to parent |
| occurrence_index | INT | | For recurring: which occurrence (1, 2, 3...) |
| created_at | TIMESTAMP | NOT NULL | |
| updated_at | TIMESTAMP | NOT NULL | |

### `go_participants` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| event_id | UUID | FK → go_events | |
| user_id | UUID | FK → users | |
| rsvp_status | VARCHAR(20) | NOT NULL | going/maybe/not_going/pending/waitlist |
| invited_by | UUID | FK → users | Who invited |
| checked_in_at | TIMESTAMP | | Check-in time |
| created_at | TIMESTAMP | NOT NULL | |
| updated_at | TIMESTAMP | NOT NULL | |
| | | UNIQUE(event_id, user_id) | |

### `go_tasks` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| event_id | UUID | FK → go_events | |
| created_by | UUID | FK → users | Task owner (private to user) |
| title | VARCHAR(255) | NOT NULL | Task name |
| description | TEXT | | Details |
| category | VARCHAR(20) | NOT NULL | bring/prepare/arrange/activity |
| is_completed | BOOLEAN | DEFAULT false | Done / Not Done |
| due_at | TIMESTAMP | | Deadline |
| completed_at | TIMESTAMP | | Completion time |
| depends_on | UUID | FK → go_tasks | Dependency |
| sort_order | INT | NOT NULL | Display order |
| created_at | TIMESTAMP | NOT NULL | |
| updated_at | TIMESTAMP | NOT NULL | |

### `go_reminders` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| task_id | UUID | FK → go_tasks | |
| user_id | UUID | FK → users | Who to remind |
| reminder_type | VARCHAR(30) | NOT NULL | time_before_event/time_before_deadline/specific_time |
| remind_at | TIMESTAMP | | For specific_time |
| minutes_before | INT | | For relative reminders |
| is_sent | BOOLEAN | DEFAULT false | |
| sent_at | TIMESTAMP | | |
| created_at | TIMESTAMP | NOT NULL | |

### `go_saved_locations` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| user_id | UUID | FK → users | Owner (for user-level) |
| group_id | UUID | FK → groups | Owner (for group-level) |
| name | VARCHAR(255) | NOT NULL | Display name |
| address | TEXT | | Full address |
| lat | DOUBLE | | Latitude |
| lng | DOUBLE | | Longitude |
| place_id | VARCHAR(255) | | Google Places ID |
| image_url | TEXT | | Venue image |
| category | VARCHAR(50) | | restaurant/park/office/home/other |
| is_favorite | BOOLEAN | DEFAULT false | Pin to top |
| created_at | TIMESTAMP | NOT NULL | |
| updated_at | TIMESTAMP | NOT NULL | |
| | | CHECK(user_id IS NOT NULL OR group_id IS NOT NULL) | Must have owner |

### `go_recurrence_rules` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| event_id | UUID | FK → go_events | Parent event |
| frequency | VARCHAR(20) | NOT NULL | daily/weekly/biweekly/monthly/yearly/custom |
| interval | INT | DEFAULT 1 | Every X (e.g., every 2 weeks) |
| days_of_week | VARCHAR(20)[] | | For weekly: ["monday", "thursday"] |
| day_of_month | INT | | For monthly: 1-31 |
| week_of_month | INT | | For monthly: 1-5 (1st, 2nd... 5th=last) |
| end_type | VARCHAR(20) | NOT NULL | never/after_count/until_date |
| end_after_count | INT | | Stop after X occurrences |
| end_until_date | DATE | | Stop after this date |
| task_mode | VARCHAR(20) | DEFAULT 'copy' | copy/rotate (how to handle tasks) |
| created_at | TIMESTAMP | NOT NULL | |

### `go_polls` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| event_id | UUID | FK → go_events | |
| created_by | UUID | FK → users | |
| question | VARCHAR(255) | NOT NULL | Poll question |
| poll_type | VARCHAR(20) | NOT NULL | date/venue/custom |
| is_closed | BOOLEAN | DEFAULT false | |
| created_at | TIMESTAMP | NOT NULL | |

### `go_poll_options` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| id | UUID | PK | Primary key |
| poll_id | UUID | FK → go_polls | |
| label | VARCHAR(255) | NOT NULL | Option text |
| date_value | TIMESTAMP | | For date polls |
| sort_order | INT | NOT NULL | Display order |

### `go_poll_votes` table

| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| poll_option_id | UUID | FK → go_poll_options | |
| user_id | UUID | FK → users | |
| created_at | TIMESTAMP | NOT NULL | |
| | | PK(poll_option_id, user_id) | Composite key |

---

## Entity Relationships

```
User ──┬── creates ──────> GoEvent
       ├── participates ──> GoParticipant ──> GoEvent
       ├── assigned ──────> GoTask
       ├── reminded ──────> GoReminder
       └── votes ─────────> GoPollVote

Group ──── hosts ──> GoEvent (optional)

GoEvent ──┬── has many ──> GoParticipant
          ├── has many ──> GoTask ──┬── has many ──> GoReminder
          │                         └── depends on ──> GoTask (self-ref)
          └── has many ──> GoPoll ──> GoPollOption ──> GoPollVote
```

---

## API Endpoints

### Events

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/go` | List user's events (with filters) |
| POST | `/go` | Create new event |
| GET | `/go/feed` | Discover public/friends events |
| GET | `/go/:id` | Get event details |
| PATCH | `/go/:id` | Update event |
| DELETE | `/go/:id` | Delete event |
| POST | `/go/:id/rsvp` | RSVP to event |
| POST | `/go/:id/invite` | Invite users |
| POST | `/go/:id/check-in` | Check in at venue |
| GET | `/go/:id/progress` | Get progress stats |
| DELETE | `/go/:id/participants/:userId` | Remove participant |

### Tasks

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/go/:id/tasks` | List event tasks |
| POST | `/go/:id/tasks` | Create task |
| GET | `/go/:id/tasks/suggestions` | Get AI task suggestions |
| GET | `/go/:id/tasks/:taskId` | Get task details |
| PATCH | `/go/:id/tasks/:taskId` | Update task |
| DELETE | `/go/:id/tasks/:taskId` | Delete task |
| POST | `/go/:id/tasks/:taskId/assign` | Assign to user |
| POST | `/go/:id/tasks/:taskId/claim` | Claim task |
| POST | `/go/:id/tasks/:taskId/complete` | Complete task |
| POST | `/go/:id/tasks/:taskId/expense` | Add expense |

### Reminders

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/go/:id/tasks/:taskId/reminders` | List reminders |
| POST | `/go/:id/tasks/:taskId/reminders` | Create reminder |
| PATCH | `/go/:id/tasks/:taskId/reminders/:reminderId` | Update reminder |
| DELETE | `/go/:id/tasks/:taskId/reminders/:reminderId` | Delete reminder |

### Polls

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/go/:id/polls` | List polls |
| POST | `/go/:id/polls` | Create poll |
| GET | `/go/:id/polls/:pollId` | Get poll with votes |
| DELETE | `/go/:id/polls/:pollId` | Close/delete poll |
| POST | `/go/:id/polls/:pollId/vote` | Vote on option |

### AI Suggestions

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/go/suggestions` | Get AI event/venue suggestions |

### Saved Locations

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/go/locations` | List user's saved locations |
| POST | `/go/locations` | Save a new location (user-level) |
| GET | `/go/locations/:locationId` | Get saved location details |
| PATCH | `/go/locations/:locationId` | Update saved location |
| DELETE | `/go/locations/:locationId` | Delete saved location |
| GET | `/groups/:groupId/locations` | List group's saved locations |
| POST | `/groups/:groupId/locations` | Save a new location (group-level) |
| PATCH | `/groups/:groupId/locations/:locationId` | Update group location |
| DELETE | `/groups/:groupId/locations/:locationId` | Delete group location |

---

## Implementation Phases

### Phase 1: Core Events & Participants ✅
> Foundation of the Go feature

- [ ] Create `go` feature package structure
- [ ] Add `go_events` table to database
- [ ] Add `go_participants` table to database
- [ ] Create `GoEvent` entity
- [ ] Create `GoParticipant` entity with RSVP status
- [ ] Create `IGoEventsRepo` interface
- [ ] Implement `GoEventsRepo`
- [ ] Implement `GoEventsDao`
- [ ] Create handlers:
  - [ ] `CreateEventHandler`
  - [ ] `GetEventHandler`
  - [ ] `GetUserEventsHandler`
  - [ ] `UpdateEventHandler`
  - [ ] `DeleteEventHandler`
  - [ ] `RsvpHandler`
  - [ ] `InviteUsersHandler`
- [ ] Create routes and middleware
- [ ] Write unit tests

### Phase 2: Task Management 📋
> Personal checklist system

- [ ] Add `go_tasks` table to database
- [ ] Create `GoTask` entity (Normal Dart class)
- [ ] Create `GoTaskCategory` enum (bring/prepare/arrange/activity)
- [ ] Create `IGoTasksRepo` interface
- [ ] Implement `GoTasksRepo`
- [ ] Implement `GoTasksDao`
- [ ] Create handlers:
  - [ ] `CreateTaskHandler`
  - [ ] `GetEventTasksHandler` (Filter by creator)
  - [ ] `UpdateTaskHandler`
  - [ ] `DeleteTaskHandler`
  - [ ] `AssignTaskHandler`
  - [ ] `ClaimTaskHandler`
  - [ ] `CompleteTaskHandler`
- [ ] Create routes
- [ ] Write unit tests

### Phase 3: Reminders System 🔔
> Smart notification system

- [x] Add `go_reminders` table to database
- [x] Create `GoReminder` entity
- [x] Create `GoReminderType` enum
- [x] Create `IGoRemindersRepo` interface
- [x] Implement `GoRemindersRepo`
- [x] Implement `GoRemindersDao`
- [x] Create handlers:
  - [x] `CreateReminderHandler`
  - [x] `UpdateReminderHandler`
  - [x] `DeleteReminderHandler`
  - [x] `GetTaskRemindersHandler`
- [x] Create routes
- [ ] Write unit tests
- [ ] (Future) Implement reminder sending service

### Phase 4: Progress Tracking ✅
> Event readiness monitoring (expenses deferred to future)

- [x] Create `GetEventProgressHandler`
  - Total/completed tasks count
  - Progress percentage
  - Overdue tasks
- [x] Create progress route
- [x] Add localization keys
- [ ] Write unit tests
- [ ] (Future) Add expense tracking features

### Phase 5: Polls & Voting 🗳️
> Democratic event planning

- [ ] Add `go_polls` table to database
- [ ] Add `go_poll_options` table to database
- [ ] Add `go_poll_votes` table to database
- [ ] Create `GoPoll` entity
- [ ] Create `GoPollOption` entity
- [ ] Create `IGoPolsRepo` interface
- [ ] Implement `GoPollsRepo`
- [ ] Implement `GoPollsDao`
- [ ] Create handlers:
  - [ ] `CreatePollHandler`
  - [ ] `GetEventPollsHandler`
  - [ ] `VotePollHandler`
  - [ ] `ClosePollHandler`
- [ ] Create routes
- [ ] Write unit tests

### Phase 6: Discovery & Feed 🌍
> Find public events

- [ ] Implement visibility filtering logic
- [ ] Create `GetEventFeedHandler`
  - Filter by visibility (public/friends/group)
  - Filter by location (nearby)
  - Filter by date range
  - Pagination
- [ ] Create route
- [ ] Write unit tests

### Phase 7: Saved Locations 📍

> Reusable locations for quick event creation

- [ ] Add `go_saved_locations` table to database
- [ ] Create `GoSavedLocation` entity
- [ ] Create `IGoSavedLocationsRepo` interface
- [ ] Implement `GoSavedLocationsRepo`
- [ ] Implement `GoSavedLocationsDao`
- [ ] Create handlers:
  - [ ] `CreateSavedLocationHandler` (user-level)
  - [ ] `GetSavedLocationsHandler` (list with filters)
  - [ ] `UpdateSavedLocationHandler`
  - [ ] `DeleteSavedLocationHandler`
- [ ] Add group-level saved locations (extend group feature)
- [ ] Create routes
- [ ] Write unit tests

### Phase 8: Recurring Events 🔄

> Repeating events with flexible scheduling

- [ ] Add `go_recurrence_rules` table to database
- [ ] Create `GoRecurrence` entity with options:
  - [ ] `frequency`: daily, weekly, biweekly, monthly, yearly, custom
  - [ ] `interval`: every X (e.g., every 2 weeks)
  - [ ] `daysOfWeek`: for weekly (e.g., ["monday", "thursday"])
  - [ ] `dayOfMonth`: for monthly (1-31)
  - [ ] `weekOfMonth`: for monthly (1st Monday, last Friday)
  - [ ] `endType`: never, after_count, until_date
  - [ ] `taskMode`: copy (duplicate tasks) or rotate (cycle assignments)
- [ ] Create `GoRecurrenceHandler` for CRUD
- [ ] Implement occurrence generation logic
- [ ] Create `GetNextOccurrenceHandler`
- [ ] Create `EditRecurringEventHandler` with options:
  - [ ] Edit this occurrence only
  - [ ] Edit this and future occurrences
  - [ ] Edit all occurrences
- [ ] Handle task rotation for recurring events
- [ ] Create routes
- [ ] Write unit tests

### Phase 9: Advanced Features 🚀

> Enhanced functionality

- [ ] **Check-in System**
  - [ ] `CheckInHandler` with location verification
  
- [ ] **Task Dependencies**
  - [ ] Add `depends_on` validation
  - [ ] Prevent completing task before dependency
  
- [ ] **Task Suggestions**
  - [ ] Template tasks by event type
  - [ ] AI-powered suggestions (future)

- [ ] **Event Chat Integration**
  - [ ] Link to group chat feature
  - [ ] Task comments

### Phase 10: AI Suggestions 🤖

> "Don't know where to go?" - AI-powered event recommendations

- [ ] Create `GoSuggestionInput` entity with structured inputs
- [ ] Create `GoSuggestion` entity for AI response
- [ ] Create `GetAiSuggestionsHandler`
- [ ] Build prompt from structured inputs:
  - [ ] Group size
  - [ ] Budget range (per person)
  - [ ] Date/time preferences
  - [ ] Activity type (outdoor/indoor/food/adventure/relaxing)
  - [ ] Distance willing to travel
  - [ ] Preferences (kid-friendly, pet-friendly, accessibility)
  - [ ] Mood/vibe (adventurous, romantic, social, active)
  - [ ] User's current location (optional)
  - [ ] Optional notes (free-text)
- [ ] Integrate with AI service (OpenAI/Claude)
- [ ] Parse AI response into structured suggestions
- [ ] Return ranked list with:
  - [ ] Venue/activity name
  - [ ] Description
  - [ ] Estimated cost
  - [ ] Location details
  - [ ] Why it's recommended
- [ ] Create route `/go/suggestions`
- [ ] Write unit tests

---

## Sample Requests & Responses

### Create Event

```http
POST /go
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "BBQ at Central Park 🍖",
  "description": "Summer BBQ with the crew!",
  "location": {
    "name": "Central Park - BBQ Area 3",
    "address": "Central Park, New York, NY",
    "lat": 40.7829,
    "lng": -73.9654,
    "placeId": "ChIJ4zGFAZpYwokRGUGph3Mf37k"
  },
  "startsAt": "2025-12-20T12:00:00Z",
  "endsAt": "2025-12-20T18:00:00Z",
  "visibility": "group",
  "groupId": "550e8400-e29b-41d4-a716-446655440000",
  "maxParticipants": 15,
  "estimatedCost": 25.00
}
```

### Create Event from Saved Location

```http
POST /go
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Weekly Game Night 🎲",
  "savedLocationId": "770e8400-e29b-41d4-a716-446655440003",
  "startsAt": "2025-12-20T19:00:00Z",
  "endsAt": "2025-12-20T23:00:00Z",
  "visibility": "group",
  "groupId": "550e8400-e29b-41d4-a716-446655440000"
}
```

### Create Recurring Event

```http
POST /go
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Weekly Game Night 🎲",
  "description": "Every Thursday at Ahmad's place",
  "savedLocationId": "770e8400-e29b-41d4-a716-446655440003",
  "startsAt": "2025-12-19T19:00:00Z",
  "endsAt": "2025-12-19T23:00:00Z",
  "visibility": "group",
  "groupId": "550e8400-e29b-41d4-a716-446655440000",
  "recurrence": {
    "frequency": "weekly",
    "interval": 1,
    "daysOfWeek": ["thursday"],
    "endType": "never",
    "taskMode": "rotate"
  }
}
```

### Create Monthly Recurring Event

```http
POST /go
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Monthly Book Club 📚",
  "location": {
    "name": "City Library - Meeting Room B",
    "address": "456 Library Ave, New York, NY",
    "lat": 40.7532,
    "lng": -73.9822
  },
  "startsAt": "2025-12-07T15:00:00Z",
  "endsAt": "2025-12-07T17:00:00Z",
  "visibility": "friends",
  "recurrence": {
    "frequency": "monthly",
    "interval": 1,
    "weekOfMonth": 1,
    "dayOfWeekInMonth": "saturday",
    "endType": "afterCount",
    "endAfterCount": 12,
    "taskMode": "copy"
  }
}
```

### Save Location (User Level)

```http
POST /go/locations
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "My Favorite Cafe",
  "address": "123 Coffee St, New York, NY",
  "lat": 40.7484,
  "lng": -73.9857,
  "placeId": "ChIJ...",
  "category": "restaurant",
  "isFavorite": true
}
```

### Save Location (Group Level)

```http
POST /groups/550e8400-e29b-41d4-a716-446655440000/locations
Authorization: Bearer {token}
Content-Type: application/json

{
  "name": "Our Usual BBQ Spot",
  "address": "Central Park - BBQ Area 3, New York, NY",
  "lat": 40.7829,
  "lng": -73.9654,
  "category": "park",
  "isFavorite": true
}
```

**Response (201 Created):**
```json
{
  "id": "880e8400-e29b-41d4-a716-446655440004",
  "name": "Our Usual BBQ Spot",
  "address": "Central Park - BBQ Area 3, New York, NY",
  "lat": 40.7829,
  "lng": -73.9654,
  "category": "park",
  "isFavorite": true,
  "groupId": "550e8400-e29b-41d4-a716-446655440000",
  "createdAt": "2025-12-07T10:00:00Z"
}
```

**Response (201 Created):**
```json
{
  "id": "660e8400-e29b-41d4-a716-446655440001",
  "title": "BBQ at Central Park 🍖",
  "creator": {
    "id": "...",
    "name": "Ahmad"
  },
  "location": {
    "name": "Central Park - BBQ Area 3",
    "address": "Central Park, New York, NY",
    "lat": 40.7829,
    "lng": -73.9654
  },
  "startsAt": "2025-12-20T12:00:00Z",
  "participantCount": 1,
  "taskCount": 0
}
```

### Create Task

```http
POST /go/660e8400-e29b-41d4-a716-446655440001/tasks
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Buy charcoal and lighter fluid",
  "category": "bring",
  "assignmentMode": "assigned",
  "assignedTo": "770e8400-e29b-41d4-a716-446655440002",
  "priority": 3,
  "dueAt": "2025-12-19T18:00:00Z"
}
```

### Add Reminder

```http
POST /go/.../tasks/.../reminders
Authorization: Bearer {token}
Content-Type: application/json

{
  "reminderType": "time_before_deadline",
  "minutesBefore": 1440
}
```

### Location-Based Reminder

```http
POST /go/.../tasks/.../reminders
Authorization: Bearer {token}
Content-Type: application/json

{
  "reminderType": "location",
  "location": {
    "name": "Costco Wholesale",
    "address": "123 Main St, New York, NY",
    "lat": 40.7128,
    "lng": -74.0060
  },
  "locationRadius": 200
}
```

### Get AI Suggestions

```http
POST /go/suggestions
Authorization: Bearer {token}
Content-Type: application/json

{
  "groupSize": 6,
  "budget": {
    "min": 20,
    "max": 50,
    "currency": "USD"
  },
  "datePreferences": {
    "date": "2025-12-21",
    "timeOfDay": "afternoon",
    "duration": "4-6 hours"
  },
  "activityTypes": ["outdoor", "food", "social"],
  "maxDistance": 30,
  "distanceUnit": "km",
  "currentLocation": {
    "lat": 40.7128,
    "lng": -74.0060
  },
  "preferences": {
    "kidFriendly": false,
    "petFriendly": true,
    "accessibilityNeeds": false,
    "indoorOutdoor": "outdoor"
  },
  "mood": ["adventurous", "social"],
  "notes": "We want something unique, preferably with a nice view. One person is vegetarian."
}
```

**Response (200 OK):**
```json
{
  "suggestions": [
    {
      "rank": 1,
      "title": "Sunset BBQ at Riverside Park",
      "description": "A scenic park with dedicated BBQ areas overlooking the Hudson River. Perfect for groups!",
      "activityType": "outdoor",
      "estimatedCostPerPerson": 35.00,
      "location": {
        "name": "Riverside Park - BBQ Area 5",
        "address": "Riverside Drive, New York, NY",
        "lat": 40.8012,
        "lng": -73.9714
      },
      "duration": "4-5 hours",
      "whyRecommended": "Great views, pet-friendly, has vegetarian-friendly facilities nearby, matches your adventurous mood",
      "tips": [
        "Book the BBQ spot in advance",
        "Bring your own charcoal",
        "Vegetarian options available at nearby food trucks"
      ],
      "rating": 4.5,
      "distance": 12.5,
      "distanceUnit": "km"
    },
    {
      "rank": 2,
      "title": "Rooftop Picnic at Brooklyn Grange",
      "description": "Urban rooftop farm with stunning city views. Unique experience with farm-fresh food.",
      "activityType": "outdoor",
      "estimatedCostPerPerson": 45.00,
      "location": {
        "name": "Brooklyn Grange - Navy Yard",
        "address": "63 Flushing Ave, Brooklyn, NY",
        "lat": 40.6982,
        "lng": -73.9714
      },
      "duration": "3-4 hours",
      "whyRecommended": "Unique rooftop experience, vegetarian-friendly farm, great for social gatherings",
      "tips": [
        "Book a farm tour in advance",
        "They have vegetarian options on-site"
      ],
      "rating": 4.8,
      "distance": 8.2,
      "distanceUnit": "km"
    }
  ],
  "promptUsed": "Find outdoor activities for 6 people with budget $20-50/person..."
}
```

### Get Event Progress

```http
GET /go/660e8400-e29b-41d4-a716-446655440001/progress
Authorization: Bearer {token}
```

**Response (200 OK):**
```json
{
  "totalTasks": 12,
  "completedTasks": 7,
  "inProgressTasks": 2,
  "pendingTasks": 3,
  "progressPercent": 58,
  "totalExpenses": 87.50,
  "expensesByUser": [
    {
      "userId": "...",
      "name": "Ahmad",
      "amount": 45.00,
      "taskCount": 3
    },
    {
      "userId": "...",
      "name": "Sara", 
      "amount": 42.50,
      "taskCount": 2
    }
  ],
  "overdueTasks": [
    {
      "id": "...",
      "title": "Buy ice",
      "assignedTo": "Khaled",
      "dueAt": "2025-12-19T12:00:00Z"
    }
  ],
  "readinessScore": "good"
}
```

---

## Localization Keys

Add to `packages/common/assets/translations/en.json`:

```json
{
  "goEventCreated": "Event created successfully",
  "goEventUpdated": "Event updated",
  "goEventDeleted": "Event deleted",
  "goEventNotFound": "Event not found",
  "goEventFull": "This event has reached capacity",
  "goAddedToWaitlist": "You've been added to the waitlist",
  "goRsvpUpdated": "Your RSVP has been updated",
  "goInviteSent": "Invitation sent",
  "goAlreadyParticipant": "User is already a participant",
  "goNotEventCreator": "Only the event creator can do this",
  "goNotParticipant": "You are not a participant of this event",
  "goCheckedIn": "You've checked in to the event",
  "goTaskCreated": "Task created",
  "goTaskUpdated": "Task updated",
  "goTaskDeleted": "Task deleted",
  "goTaskNotFound": "Task not found",
  "goTaskAssigned": "Task assigned to {name}",
  "goTaskClaimed": "You claimed this task",
  "goTaskCompleted": "Task marked as complete",
  "goTaskAlreadyClaimed": "This task is already claimed",
  "goTaskNotAssignedToYou": "This task is not assigned to you",
  "goTaskDependencyIncomplete": "Complete '{dependsOn}' first",
  "goReminderCreated": "Reminder set",
  "goReminderUpdated": "Reminder updated",
  "goReminderDeleted": "Reminder deleted",
  "goReminderNotFound": "Reminder not found",
  "goExpenseAdded": "Expense of {amount} recorded",
  "goPollCreated": "Poll created",
  "goPollClosed": "This poll is closed",
  "goAlreadyVoted": "You've already voted on this option",
  "goVoteRecorded": "Your vote has been recorded",
  "goAllTasksComplete": "All tasks are complete! You're ready 🎉",
  "goOverdueTaskReminder": "Task '{title}' is overdue",
  "goSuggestionsGenerated": "Here are some ideas for your outing!",
  "goSuggestionsError": "Unable to generate suggestions. Please try again.",
  "goInvalidSuggestionInput": "Please provide at least group size and activity preferences",
  "goLocationSaved": "Location saved",
  "goLocationUpdated": "Location updated",
  "goLocationDeleted": "Location deleted",
  "goLocationNotFound": "Saved location not found",
  "goRecurrenceCreated": "Recurring event set up",
  "goRecurrenceUpdated": "Recurrence updated",
  "goRecurrenceDeleted": "Recurrence removed",
  "goEditThisOccurrence": "Edit this occurrence only",
  "goEditFutureOccurrences": "Edit this and future occurrences",
  "goEditAllOccurrences": "Edit all occurrences",
  "goNextOccurrence": "Next occurrence: {date}",
  "goOccurrenceSkipped": "This occurrence has been skipped",
  "goTasksRotated": "Tasks have been rotated for this occurrence"
}
```

---

## Testing Strategy

### Unit Tests

```
features/go/test/
├── domain/
│   └── entities/
│       ├── go_event_test.dart
│       ├── go_task_test.dart
│       └── go_reminder_test.dart
│
├── data/
│   └── repo/
│       ├── go_events_repo_test.dart
│       └── go_tasks_repo_test.dart
│
└── handlers/
    ├── events/
    │   ├── create_event_test.dart
    │   ├── rsvp_test.dart
    │   └── ...
    ├── tasks/
    │   ├── create_task_test.dart
    │   ├── complete_task_test.dart
    │   └── ...
    └── reminders/
        └── create_reminder_test.dart
```

### Route Tests

```
test/routes/go/
├── index_test.dart
├── feed_test.dart
└── id/
    ├── index_test.dart
    ├── rsvp_test.dart
    ├── tasks/
    │   └── ...
    └── polls/
        └── ...
```

---

## Dependencies

Add to `features/go/pubspec.yaml`:

```yaml
dependencies:
  common:
    path: ../../packages/common
  database:
    path: ../../packages/database
  dart_frog: ^1.0.0
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.0
  json_serializable: ^6.7.0
  mocktail: ^1.0.0
  test: ^1.24.0
```

---

## Notes

- All handlers follow the `IHandler<TRequest, TResponse>` pattern
- All responses use `HandlerResult<T>` (success/failed union)
- JWT authentication required for all endpoints
- Event creator has admin privileges (update, delete, manage participants)
- Tasks can only be managed by event participants
- Reminders are user-specific (each user sets their own)
