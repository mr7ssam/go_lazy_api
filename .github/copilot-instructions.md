# GitHub Copilot Instructions for go_lazy_api

## Architecture Overview

This is a **Dart Frog** API with a monorepo managed by **Melos**. The codebase uses a modular, feature-based architecture:

- **`features/`**: Feature modules (e.g., `user/`) with domain, data, and handlers layers
- **`packages/`**: Shared packages (`common`, `database`) used across features
- **`routes/`**: Dart Frog route files that delegate to feature handlers
- **`build/`**: Docker deployment configuration

### Key Design Patterns

**Three-Layer Feature Architecture** (see `features/user/`):
- **Domain layer** (`user_domain.dart`): Interfaces and entities (e.g., `IUsersRepo`, `User`)
- **Data layer** (`user_data.dart`): Implementations (e.g., `UsersRepo`, JWT middleware)
- **Handlers layer** (`user_handlers.dart`): HTTP request handlers with request/response DTOs

**Dependency Injection via Middleware Chain**:
Routes compose middleware using extension methods that register providers. See `routes/_middleware.dart`:
```dart
handler
  .use(localizationMiddleware())
  .registerUserDataMiddlewares()  // Registers JWT auth + repos
  .use(provider<JwtService>(...))
  .registerDatabaseMiddlewares()  // Registers DAOs + DB connection
```

Each feature exports `registerXXXMiddlewares()` extensions for composability.

## Database & ORM

Uses **Drift** (type-safe SQL for Dart) with PostgreSQL:
- Tables defined in `packages/database/lib/src/tables/` (e.g., `users_table.dart`)
- DAOs in `packages/database/lib/src/daos/` (e.g., `user_dao.dart`)
- Run `melos run build_runner:build` after schema changes to generate `*.g.dart` files
- `build.yaml` configures Drift for PostgreSQL dialect

**Transaction Management**: Use `TransactionManager.runInTransaction()` for atomic operations (see `create_user_handler.dart`).

## Essential Developer Workflows

### Build & Run
```bash
# Install dependencies for all packages
melos bootstrap

# Generate Drift DAO code (*.g.dart files)
melos run build_runner:build

# Watch mode for auto-regeneration
melos run build_runner:watch

# Start dev server (uses .env.dev + .env.local)
melos run start

# Start prod server (uses .env.prod + .env.local)
melos run start:prod
```

### Localization
- Translations: `packages/common/assets/translations/{en,ar}.json`
- Generate type-safe classes: `melos run generate:translations`
- Access in handlers: `context.read<LocalizationService>().translations.keyName`

### Testing
API testing documented in `POSTMAN_GUIDE.md`. Import `postman_collection.json` for pre-configured requests.

## Project-Specific Conventions

1. **Handler Pattern**: Route files call handlers via dependency injection:
   ```dart
   // routes/user/create.dart
   final handler = context.read<CreateUserHandler>();
   return handler.handle(CreateUserRequest.fromJson(json));
   ```

2. **Request/Response DTOs**: Co-located with handlers in `exchange.dart` files (e.g., `create_user_exchange.dart`)

3. **Barrel Exports**: Features use layered exports via `index.dart` files:
   - `user_domain.dart` exports domain interfaces
   - `user_data.dart` exports data implementations  
   - `user_handlers.dart` exports handlers

4. **JWT Authentication**: Applied via `jwtAuthMiddleware()` with path exclusions:
   ```dart
   const _notAppliedTo = ['user/login', 'user/create', 'user/otp', 'user/refresh_token'];
   ```
   Protected routes get `User` via `context.user` extension.

5. **Environment Variables**: Required vars (see `JwtService.fromEnvironment()`, `Database._openConnection()`):
   - `DATABASE_HOST`, `DATABASE_NAME`, `DATABASE_USER`, `DATABASE_PASSWORD`
   - `JWT_ACCESS_SECRET`, `JWT_REFRESH_SECRET`
   - Optional: `JWT_ACCESS_EXPIRATION_MINUTES`, `JWT_REFRESH_EXPIRATION_DAYS`

## Adding New Features

1. Create feature package in `features/<name>` with 3 layers (domain/data/handlers)
2. Add middleware registration extension: `Handler registerXXXMiddlewares()`
3. Define route in `routes/<name>/` that reads handler from context
4. Register feature in root `pubspec.yaml` workspace and `routes/_middleware.dart`

## Common Pitfalls

- **Forgot to run build_runner**: Missing `*.g.dart` files cause import errors
- **Middleware order matters**: Database providers must be registered before DAOs
- **Singleton services**: `JwtService` and `Database` use cached instances—call `.fromEnvironment()` or `middlewareProvider()` only
- **Transaction scope**: DAOs inherit transaction context automatically when inside `runInTransaction()`
 