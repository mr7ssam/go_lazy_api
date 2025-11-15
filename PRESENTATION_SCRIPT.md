# Dart Frog API

## **Introduction**

REST API built with **Dart Frog** - a minimalistic backend framework for Dart.

1. **Dart Frog** for building APIs
2. **Clean Architecture** with three layers
3. **Melos** for monorepo management

---

## **Monorepo Structure**

The project is organized as a monorepo using **Melos**:

```
features/user/          # User feature module
packages/common/        # Shared utilities
packages/database/      # Database layer
routes/                 # API endpoints
```

**Melos Scripts**:

```bash
melos bootstrap              # Install all dependencies
melos run build_runner:build # Generate code
melos run start              # Start the server
```

---

## **Three-Layer Architecture**

**three-layer pattern**.

**Layer 1: Domain** - Business rules
```dart
class User { ... }                    // Entities
abstract class IUsersRepo { ... }    // Contracts
```

**Layer 2: Data** - Implementation
```dart
class UsersRepo implements IUsersRepo { ... }  // Database logic
class JwtAuthMiddleware { ... }                // JWT auth
```

**Layer 3: Handlers** - HTTP logic
```dart
class CreateUserHandler {
  Future<HandlerResult> handle(CreateUserRequest request) { ... }
}
```

**Why three layers?**
- Easy to test each part separately
- Can swap implementations
- Business logic stays clean"

---

## **Dart Frog in Action**

Dependency injection via middleware:

```dart
// routes/_middleware.dart
handler
  .use(localizationMiddleware())
  .registerUserDataMiddlewares()
  .registerDatabaseMiddlewares()
```

Route files:

```dart
// routes/user/create.dart
Future<Response> onRequest(RequestContext context) async {
  final handler = context.read<CreateUserHandler>();
  return handler.handle(request).toResponse();
}
```

---

## **Database with Drift**

For the database, I use **Drift** - type-safe SQL for Dart:

```dart
// Define tables as Dart classes
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  // ...
}
```

Drift generates type-safe DAOs automatically. Transactions are simple:

```dart
await transactionManager.runInTransaction(() async {
  await usersRepo.createUser(user);
  await usersRepo.createUserOtp(otp);
});
```

---

## **Wrap Up**

Summary:

✅ **Dart Frog** - Fast, simple backend framework
✅ **Clean Architecture** - Testable, maintainable code
✅ **Melos** - Easy monorepo management
✅ **Drift** - Type-safe database operations
