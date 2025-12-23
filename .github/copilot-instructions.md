# GitHub Copilot Instructions for go_lazy_api

## Architecture Overview

**Dart Frog API** with **Melos monorepo**, using modular feature-based architecture:

- **`features/`**: Feature modules with 3-layer architecture (domain/data/handlers)
- **`packages/`**: Shared packages (`common`, `database`) for cross-cutting concerns
- **`routes/`**: Dart Frog route files that delegate to feature handlers via DI
- **`build/`**: Docker deployment configuration

### Three-Layer Feature Pattern

Each feature (e.g., `features/user/`, `features/go/`) has:
1. **Domain layer** (`user_domain.dart`): Interfaces (`IUsersRepo`) and entities (`User`)
2. **Data layer** (`user_data.dart`): Implementations (`UsersRepo`, transformers, middleware registration)
3. **Handlers layer** (`user_handlers.dart`): HTTP handlers extending `IHandler<TRequest, TResponse>`

### Handler Result Pattern

All handlers return `HandlerResult<T>` (success/failed union type):
```dart
class CreateUserHandler extends IHandler<CreateUserRequest, void> {
  Future<HandlerResult<void>> handle(CreateUserRequest request) async {
    try {
      // business logic
      return const HandlerResult.success(data: null);
    } on UniqueViolationException {
      return HandlerResult.failed(error: ConflictError(message: '...'));
    }
  }
}
```

Routes convert to HTTP responses: `result.toResponse(statusCode: 201)`

### Dependency Injection via Middleware Extensions

Routes compose middleware using feature extensions (see `routes/_middleware.dart`):
```dart
handler
  .use(localizationMiddleware())
  .registerUserDataMiddlewares()    // JWT auth + UsersRepo
  .use(provider<JwtService>(...))
  .registerDatabaseMiddlewares()    // DAOs + DB connection
  .registerGoDataMiddlewares()      // Go feature repos
  .registerGoHandlersMiddlewares()  // Go feature handlers
```

Each feature exports `Handler registerXXXMiddlewares()` for composability:
- Data layer: `features/<name>/lib/src/data/index.dart` → registers repos
- Handlers layer: `features/<name>/lib/src/handlers/go_handlers_middleware.dart` → registers handlers

## Database & ORM (Drift + PostgreSQL)

- **Tables**: `packages/database/lib/src/tables/*.dart`
- **DAOs**: Centralized in `packages/database/lib/src/daos/` (e.g., `GoDao`, `UsersDao`)
- **Enum columns**: Use `textEnum<EnumType>()` for string-backed enums (see `go_reminders_table.dart`)
- **Transformers**: Convert between Drift table data and domain entities (e.g., `GoReminderInputTransformer`)
- **Transactions**: Wrap in `TransactionManager.runInTransaction()` for atomicity
- **After schema changes**: Run `melos run build_runner:build` to regenerate `*.g.dart` files
- **Config**: `build.yaml` sets Drift to PostgreSQL dialect

### Enum Pattern
```dart
// Table definition
TextColumn get reminderType => textEnum<GoReminderType>()();

// Domain entity
enum GoReminderType { timeBeforeEvent, timeBeforeDeadline, specificTime }

// Transformer - no conversion needed, Drift handles it
GoRemindersTableCompanion(reminderType: Value(reminder.reminderType))
```

## Critical Workflows

### Development Commands
```bash
melos bootstrap                      # Install all package dependencies
melos run build_runner:build         # Generate Drift DAOs (*.g.dart)
melos run build_runner:watch         # Auto-regenerate on file changes
melos run start                      # Dev server (.env.dev + .env.local)
melos run start:prod                 # Prod server (.env.prod + .env.local)
melos run generate:translations      # Generate localization classes
melos run test                       # Run all tests
```

### Testing
- **Route tests**: Use `mocktail` to mock `RequestContext` and handlers
- **Mock handler responses**: Return `HandlerResult.success(data: ...)` not `Response`
- **Run feature tests**: `cd features/user && dart test test/handlers/`
- **Run route tests**: `dart test test/routes/`
- **API testing**: Import `postman_collection.json` (see `POSTMAN_GUIDE.md`)

Example route test pattern:
```dart
when(() => handler.handle(any())).thenAnswer(
  (_) async => HandlerResult<LoginResponse>.success(
    data: LoginResponse(accessToken: '...', refreshToken: '...'),
  ),
);
```

## Project-Specific Conventions

1. **Request/Response DTOs**: Co-located with handlers in `*_exchange.dart` (e.g., `create_reminder_exchange.dart`)
   - Use plain Dart classes **without** code generation annotations (`@JsonSerializable`, `@freezed`)
   - Implement manual `toJson()` methods for responses
   - Parse requests manually from `Map<String, dynamic>` in handlers

2. **Error Handling**: Use typed errors from `packages/common/lib/src/error/`:
   - `NotFoundError` (404), `UnauthorizedError` (401), `ConflictError` (409)
   - `BadRequestError` (400), `InternalServerError` (500), `ValidationError` (422)

3. **JWT Auth**: Applied via `jwtAuthMiddleware()` with path exclusions:
   ```dart
   const _notAppliedTo = ['user/login', 'user/create', 'user/otp', 'user/refresh_token'];
   ```
   Access authenticated user: `context.read<User>()` or `context.user`

4. **Localization**: Translations in `packages/common/assets/translations/{en,ar}.json`
   - Access: `context.read<LocalizationService>().translations.goReminderCreated`
   - After adding keys, run `melos run generate:translations`

5. **Environment Variables**: Required in `.env.dev`/`.env.prod` + `.env.local`:
   - `DATABASE_HOST`, `DATABASE_NAME`, `DATABASE_USER`, `DATABASE_PASSWORD`
   - `JWT_ACCESS_SECRET`, `JWT_REFRESH_SECRET`
   - `CLOUDINARY_URL` (for file uploads)

## Adding New Features

1. Create `features/<name>/` with 3 layers (domain/data/handlers)
2. Define tables in `packages/database/lib/src/tables/<name>_table.dart`
3. Add tables to `packages/database/lib/src/database.dart` @DriftDatabase annotation
4. Create DAO or extend existing (e.g., `GoDao` handles all Go-related tables)
5. Export middleware extensions:
   - `Handler registerXXXDataMiddlewares()` in `data/index.dart` (repos)
   - `Handler registerXXXHandlersMiddlewares()` in `handlers/<name>_handlers_middleware.dart` (handlers)
6. Create route files in `routes/<name>/` that read handlers from context
7. Register in `routes/_middleware.dart` and root `pubspec.yaml`
8. Run `melos run build_runner:build` to generate Drift code

## Common Pitfalls

- **Missing `*.g.dart` files**: Run `melos run build_runner:build` after Drift schema changes
- **Middleware order**: Database providers → DAOs → Repos → Handlers (dependency order matters)
- **Handler test mocks**: Must return `HandlerResult<T>`, not `Response` directly
- **Singleton services**: `JwtService.fromEnvironment()` and `Database` cache instances—don't recreate
- **Transaction scope**: DAOs automatically inherit transaction context inside `runInTransaction()`
- **Import paths**: Use barrel exports (`user_handlers.dart`) not internal paths
- **Enum storage**: Prefer `textEnum<T>()` over manual string conversion for better type safety
- **ArgumentError**: Use `e.toString()` not `e.message` when catching ArgumentError
- **Unused imports**: Remove unused `TransactionManager` in read-only handlers
- **Trailing commas**: Always add trailing commas to function arguments, parameters, and collections to avoid Dart Frog linter issues
- **No code generation for DTOs**: Never use `@JsonSerializable()`, `@freezed`, or similar annotations on request/response classes. Use plain Dart classes with manual `toJson()` methods only
