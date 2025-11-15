import 'package:dart_frog/dart_frog.dart';
import 'package:database/database.dart';

class TransactionManager {
  TransactionManager(this._database);

  final Database _database;

  Future<void> runInTransaction(Future<void> Function() action) async {
    await _database.transaction(action);
  }

  static TransactionManager? _transactionManager;

  static Middleware middlewareProvider() {
    return provider<TransactionManager>(
      (context) => _transactionManager ??= TransactionManager(
        context.read<Database>(),
      ),
    );
  }
}
