import 'package:common/common.dart';
import 'package:database/database.dart';
import 'package:postgres/postgres.dart';
import 'package:user/user_domain.dart';
import 'package:user/user_handlers.dart';

class CreateUserHandler extends IHandler<CreateUserRequest, void> {
  CreateUserHandler({
    required IUsersRepo usersRepo,
    required TransactionManager transactionManager,
    required LocalizationService localization,
  })  : _usersRepo = usersRepo,
        _transactionManager = transactionManager,
        _localization = localization;

  final IUsersRepo _usersRepo;
  final TransactionManager _transactionManager;
  final LocalizationService _localization;

  @override
  Future<HandlerResult<void>> handle(CreateUserRequest request) async {
    try {
      await _transactionManager.runInTransaction(
        () async {
          final createdUser = await _usersRepo.createUser(
            User.create(
              email: request.email,
              firstName: request.firstName,
              lastName: request.lastName,
              phoneNumber: request.phoneNumber,
              photoUrl: request.photoUrl,
            ),
          );

          await _usersRepo.createUserOtp(
            UserOtp.create(
              userId: createdUser.id,
              type: UserOtpTypeEnum.email,
            ),
          );
        },
      );
    } on UniqueViolationException catch (_) {
      return HandlerResult.failed(
        error: ConflictError(
          message: _localization.translations.userAlreadyExists,
        ),
      );
    } catch (e) {
      return HandlerResult.failed(
        error: InternalServerError(),
      );
    }

    return const HandlerResult.success(data: null);
  }
}
