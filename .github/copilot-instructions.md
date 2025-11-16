# GitHub Copilot Instructions for go_lazy_api

## Architecture Overview

**Dart Frog API** with **Melos monorepo**, using modular feature-based architecture:

- **`features/`**: Feature modules with 3-layer architecture (domain/data/handlers)
- **`packages/`**: Shared packages (`common`, `database`) for cross-cutting concerns
- **`routes/`**: Dart Frog route files that delegate to feature handlers via DI
- **`build/`**: Docker deployment configuration

### Three-Layer Feature Pattern

Each feature (e.g., `features/user/`) has:
1. **Domain layer** (`user_domain.dart`): Interfaces (`IUsersRepo`) and entities (`User`)
2. **Data layer** (`user_data.dart`): Implementations (`UsersRepo`, JWT middleware)
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
```

Each feature exports `Handler registerXXXMiddlewares()` for composability (see `features/user/lib/src/data/index.dart`).

## Database & ORM (Drift + PostgreSQL)

- **Tables**: `packages/database/lib/src/tables/users_table.dart`
- **DAOs**: `packages/database/lib/src/daos/user_dao.dart`
- **Transactions**: Wrap in `TransactionManager.runInTransaction()` for atomicity
- **After schema changes**: Run `melos run build_runner:build` to regenerate `*.g.dart` files
- **Config**: `build.yaml` sets Drift to PostgreSQL dialect

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

1. **Request/Response DTOs**: Co-located with handlers in `*_exchange.dart` (e.g., `create_user_exchange.dart`)

2. **Error Handling**: Use typed errors from `packages/common/lib/src/error/`:
   - `NotFoundError` (404), `UnauthorizedError` (401), `ConflictError` (409)
   - `BadRequestError` (400), `InternalServerError` (500), `ValidationError` (422)

3. **JWT Auth**: Applied via `jwtAuthMiddleware()` with path exclusions:
   ```dart
   const _notAppliedTo = ['user/login', 'user/create', 'user/otp', 'user/refresh_token'];
   ```
   Access authenticated user: `context.read<User>()` or `context.user`

4. **Localization**: Translations in `packages/common/assets/translations/{en,ar}.json`
   - Access: `context.read<LocalizationService>().translations.userAlreadyExists`

5. **Environment Variables**: Required in `.env.dev`/`.env.prod` + `.env.local`:
   - `DATABASE_HOST`, `DATABASE_NAME`, `DATABASE_USER`, `DATABASE_PASSWORD`
   - `JWT_ACCESS_SECRET`, `JWT_REFRESH_SECRET`
   - `CLOUDINARY_URL` (for file uploads)

## Adding New Features

1. Create `features/<name>/` with 3 layers (domain/data/handlers)
2. Export middleware extension: `Handler registerXXXMiddlewares()` in `data/index.dart`
3. Create route files in `routes/<name>/` that read handlers from context
4. Register in `routes/_middleware.dart` and root `pubspec.yaml`

## Common Pitfalls

- **Missing `*.g.dart` files**: Run `melos run build_runner:build` after Drift schema changes
- **Middleware order**: Database providers must register before DAOs that use them
- **Handler test mocks**: Must return `HandlerResult<T>`, not `Response` directly
- **Singleton services**: `JwtService.fromEnvironment()` and `Database` cache instances—don't recreate
- **Transaction scope**: DAOs automatically inherit transaction context inside `runInTransaction()`
- **Import paths**: Use barrel exports (`user_handlers.dart`) not internal paths
 