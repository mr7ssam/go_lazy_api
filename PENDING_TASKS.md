# Go Feature - Pending Implementation Tasks

**Last Updated:** December 24, 2025

---

## Completed Phases ✅

- ✅ **Phase 1:** Core Events & Participants
- ✅ **Phase 2:** Task Management (CRUD operations complete)
- ✅ **Phase 3:** Reminders System (routes and handlers complete)
- ✅ **Phase 4:** Progress Tracking
- ✅ **Phase 6:** Discovery & Feed (public events only)
- ✅ **Phase 7:** Saved Locations (moved to `features/location` module)
- ✅ **Phase 8:** Recurring Events (CRUD operations complete)

---

## Pending Phases

### Phase 5: Polls & Voting 🗳️ (HIGH PRIORITY)
**Status:** Not Started  
**Priority:** High - Democratic event planning

#### Database Schema Needed:
- [ ] Create `go_polls` table
- [ ] Create `go_poll_options` table
- [ ] Create `go_poll_votes` table

#### Domain Layer:
- [ ] Create `GoPoll` entity
- [ ] Create `GoPollOption` entity
- [ ] Create `GoPollVote` entity
- [ ] Create `IGoPolsRepo` interface

#### Data Layer:
- [ ] Implement `GoPollsRepo`
- [ ] Create transformers for polls/options/votes

#### Handlers:
- [ ] `CreatePollHandler` (date/venue polls)
- [ ] `GetEventPollsHandler` (list all polls for event)
- [ ] `VotePollHandler` (cast/change vote)
- [ ] `ClosePollHandler` (finalize poll results)

#### Routes:
- [ ] POST `/events/[eventId]/polls` - Create poll
- [ ] GET `/events/[eventId]/polls` - List polls
- [ ] GET `/events/[eventId]/polls/[pollId]` - Get poll details
- [ ] POST `/events/[eventId]/polls/[pollId]/vote` - Vote
- [ ] POST `/events/[eventId]/polls/[pollId]/close` - Close poll
- [ ] DELETE `/events/[eventId]/polls/[pollId]` - Delete poll

#### Additional Features:
- [ ] Write unit tests
- [ ] Add localization keys
- [ ] Support multiple choice vs single choice polls
- [ ] Anonymous vs named voting
- [ ] Poll deadline/expiry

---

### Phase 8: Recurring Events - Advanced Features 🔄 (MEDIUM PRIORITY)
**Status:** CRUD Complete, Advanced Features Pending  
**Priority:** Medium

#### Completed:
- ✅ Database table and schema
- ✅ CRUD handlers (Create, Read, Update, Delete)
- ✅ Routes for `/events/[eventId]/recurrence`
- ✅ Enums: GoFrequency, GoEndType, GoTaskMode

#### Remaining Tasks:
- [ ] **Occurrence Generation Logic**
  - [ ] Calculate next occurrence date based on frequency
  - [ ] Generate occurrence list up to end date/count
  - [ ] Handle monthly patterns (first Monday, last Friday, etc.)
  - [ ] Handle leap years and month-end edge cases
  
- [ ] **Next Occurrence Handler**
  - [ ] `GetNextOccurrenceHandler` - Calculate upcoming occurrence
  - [ ] Route: GET `/events/[eventId]/recurrence/next`
  
- [ ] **Edit Recurring Event Handler**
  - [ ] `EditRecurringEventHandler` with edit modes:
    - [ ] Edit single occurrence only
    - [ ] Edit this and future occurrences
    - [ ] Edit all occurrences
  - [ ] Route: PATCH `/events/[eventId]/occurrences/[date]`
  
- [ ] **Task Rotation**
  - [ ] Implement task rotation logic (cycle assignments)
  - [ ] Copy vs rotate mode implementation
  
- [ ] **Occurrence Storage**
  - [ ] Decide: Generate on-the-fly vs store occurrences
  - [ ] If storing: Create `go_event_occurrences` table
  
- [ ] Write unit tests
- [ ] Add localization keys

**Technical Considerations:**
- Occurrence generation algorithm complexity
- Timezone handling for date calculations
- Performance: generate vs store occurrences
- Exception handling for skipped occurrences

---

### Phase 9: Advanced Features 🚀 (LOW PRIORITY)
**Status:** Not Started  
**Priority:** Low - Enhancement features

#### Check-in System:
- [ ] Create `CheckInHandler`
- [ ] Verify user location against event location
- [ ] Track check-in time
- [ ] Optional: QR code check-in
- [ ] Route: POST `/events/[eventId]/checkin`

#### Task Dependencies:
- [ ] Add `dependsOnTaskId` field to `go_tasks` table
- [ ] Validation: prevent completing task before dependency
- [ ] Display dependency chain in task list
- [ ] Circular dependency detection

#### Task Suggestions:
- [ ] Template tasks by event type (beach, BBQ, hiking, etc.)
- [ ] Pre-populate common tasks based on event category
- [ ] AI-powered task suggestions (future integration)

#### Event Chat Integration:
- [ ] Link events to group chat feature
- [ ] Task comments/discussions
- [ ] @mention notifications

#### Routes:
- [ ] POST `/events/[eventId]/checkin`
- [ ] GET `/tasks/[taskId]/dependencies`

#### Additional:
- [ ] Write unit tests
- [ ] Add localization keys

---

### Phase 10: AI Suggestions 🤖 (FUTURE)
**Status:** Not Started  
**Priority:** Future - AI-powered recommendations

#### Domain Entities:
- [ ] Create `GoSuggestionInput` entity
- [ ] Create `GoSuggestion` entity
- [ ] Create preference enums (GoActivityType, GoMood, GoBudgetRange)

#### Handler:
- [ ] `GetAiSuggestionsHandler`
- [ ] Build structured prompt from input
- [ ] Integrate with AI service (OpenAI/Claude/Gemini)
- [ ] Parse AI response into structured format

#### Input Fields:
- [ ] Group size
- [ ] Budget range (per person)
- [ ] Date/time preferences (morning/afternoon/evening)
- [ ] Activity type (outdoor/indoor/food/adventure/relaxing)
- [ ] Max distance willing to travel
- [ ] Preferences (kid-friendly, pet-friendly, accessibility)
- [ ] Mood/vibe (adventurous, romantic, social, active)
- [ ] User's current location (optional)
- [ ] Free-text notes

#### Output:
- [ ] Ranked list of venue/activity suggestions
- [ ] Each suggestion includes:
  - [ ] Name and description
  - [ ] Estimated cost per person
  - [ ] Location details (address, distance)
  - [ ] Why it's recommended (reasoning)
  - [ ] Links to book/reserve (optional)

#### Routes:
- [ ] POST `/go/suggestions` - Get AI suggestions

#### Additional:
- [ ] API key management
- [ ] Rate limiting
- [ ] Cost tracking for AI calls
- [ ] Cache common suggestions
- [ ] Fallback to non-AI suggestions
- [ ] Write unit tests

**Technical Considerations:**
- Choose AI provider (OpenAI, Anthropic, Gemini)
- Prompt engineering for quality suggestions
- Handle AI service errors gracefully
- Cost optimization and caching strategy

---

## Testing Requirements (All Phases)

### Unit Tests Needed:
- [ ] Phase 2: Task management handlers
- [ ] Phase 3: Reminder handlers (already implemented, tests pending)
- [ ] Phase 4: Progress tracking handler
- [ ] Phase 5: Poll handlers
- [ ] Phase 6: Event feed handler
- [ ] Phase 8: Recurrence handlers
- [ ] Phase 9: Advanced feature handlers
- [ ] Phase 10: AI suggestion handler

### Integration Tests:
- [ ] End-to-end event creation flow
- [ ] Task assignment and completion flow
- [ ] Reminder scheduling and retrieval
- [ ] Poll creation and voting flow
- [ ] Recurring event generation
- [ ] Location-based features

### Repository Tests:
- [ ] Test each repo implementation
- [ ] Test transaction handling
- [ ] Test error scenarios

---

## Documentation Updates Needed

- [ ] Update API documentation with all endpoints
- [ ] Create Postman collection for all routes
- [ ] Document recurrence pattern examples
- [ ] Document task dependency rules
- [ ] Document poll voting rules
- [ ] Add AI suggestion examples
- [ ] Update GO_FEATURE.md completion status

---

## Priority Recommendations

### Immediate (Next Steps):
1. **Testing for Phases 1-8** - Validate existing implementations
2. **Phase 5: Polls & Voting** - Add democratic planning features

### Short-term:
1. **Phase 8: Advanced Recurrence Features** - Complete occurrence generation
2. **Phase 9: Check-in and Task Dependencies** - Enhance user experience

### Medium-term:
1. **Phase 9: Additional Advanced Features** - Task suggestions, chat integration
2. **Comprehensive Testing** - Full test coverage

### Long-term:
1. **Phase 10: AI Suggestions** - Future enhancement requiring AI integration

---

## Estimated Effort

| Phase | Status | Estimated Effort | Priority |
|-------|--------|------------------|----------|
| Phase 5: Polls & Voting | Not Started | 6-8 hours | HIGH |
| Phase 8: Advanced Recurrence | Partial | 4-5 hours | MEDIUM |
| Phase 9: Advanced Features | Not Started | 8-10 hours | LOW |
| Phase 10: AI Suggestions | Not Started | 6-8 hours | FUTURE |
| **Unit Tests (All Phases)** | Not Started | 10-15 hours | HIGH |
| **Integration Tests** | Not Started | 8-10 hours | MEDIUM |

**Total Estimated Effort:** 42-56 hours

---

## Notes

- Phase 2 (Task Management) is COMPLETE with all CRUD operations ✅
- Phase 7 (Saved Locations) was extracted to separate `features/location` module for better modularity
- Phase 8 (Recurring Events) CRUD is complete; advanced features (occurrence generation) pending
- Consider implementing tests incrementally alongside feature development
- AI suggestions (Phase 10) require external service integration and cost consideration

