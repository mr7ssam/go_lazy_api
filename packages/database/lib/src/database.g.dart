// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserTableTable extends UserTable
    with TableInfo<$UserTableTable, UserTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isEmailVerifiedMeta =
      const VerificationMeta('isEmailVerified');
  @override
  late final GeneratedColumn<bool> isEmailVerified = GeneratedColumn<bool>(
      'is_email_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT false',
      defaultValue: const CustomExpression('FALSE'));
  static const VerificationMeta _isPhoneVerifiedMeta =
      const VerificationMeta('isPhoneVerified');
  @override
  late final GeneratedColumn<bool> isPhoneVerified = GeneratedColumn<bool>(
      'is_phone_verified', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT false',
      defaultValue: const CustomExpression('FALSE'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        photoUrl,
        isEmailVerified,
        isPhoneVerified
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<UserTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('is_email_verified')) {
      context.handle(
          _isEmailVerifiedMeta,
          isEmailVerified.isAcceptableOrUnknown(
              data['is_email_verified']!, _isEmailVerifiedMeta));
    }
    if (data.containsKey('is_phone_verified')) {
      context.handle(
          _isPhoneVerifiedMeta,
          isPhoneVerified.isAcceptableOrUnknown(
              data['is_phone_verified']!, _isPhoneVerifiedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {email},
        {phoneNumber},
      ];
  @override
  UserTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number'])!,
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      isEmailVerified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_email_verified'])!,
      isPhoneVerified: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}is_phone_verified'])!,
    );
  }

  @override
  $UserTableTable createAlias(String alias) {
    return $UserTableTable(attachedDatabase, alias);
  }
}

class UserTableData extends DataClass implements Insertable<UserTableData> {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? photoUrl;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  const UserTableData(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      this.photoUrl,
      required this.isEmailVerified,
      required this.isPhoneVerified});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['is_email_verified'] = Variable<bool>(isEmailVerified);
    map['is_phone_verified'] = Variable<bool>(isPhoneVerified);
    return map;
  }

  UserTableCompanion toCompanion(bool nullToAbsent) {
    return UserTableCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phoneNumber: Value(phoneNumber),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      isEmailVerified: Value(isEmailVerified),
      isPhoneVerified: Value(isPhoneVerified),
    );
  }

  factory UserTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserTableData(
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      isEmailVerified: serializer.fromJson<bool>(json['isEmailVerified']),
      isPhoneVerified: serializer.fromJson<bool>(json['isPhoneVerified']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'isEmailVerified': serializer.toJson<bool>(isEmailVerified),
      'isPhoneVerified': serializer.toJson<bool>(isPhoneVerified),
    };
  }

  UserTableData copyWith(
          {String? id,
          String? firstName,
          String? lastName,
          String? email,
          String? phoneNumber,
          Value<String?> photoUrl = const Value.absent(),
          bool? isEmailVerified,
          bool? isPhoneVerified}) =>
      UserTableData(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
        isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      );
  UserTableData copyWithCompanion(UserTableCompanion data) {
    return UserTableData(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      isEmailVerified: data.isEmailVerified.present
          ? data.isEmailVerified.value
          : this.isEmailVerified,
      isPhoneVerified: data.isPhoneVerified.present
          ? data.isPhoneVerified.value
          : this.isPhoneVerified,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserTableData(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isEmailVerified: $isEmailVerified, ')
          ..write('isPhoneVerified: $isPhoneVerified')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, email, phoneNumber,
      photoUrl, isEmailVerified, isPhoneVerified);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserTableData &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.photoUrl == this.photoUrl &&
          other.isEmailVerified == this.isEmailVerified &&
          other.isPhoneVerified == this.isPhoneVerified);
}

class UserTableCompanion extends UpdateCompanion<UserTableData> {
  final Value<String> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> phoneNumber;
  final Value<String?> photoUrl;
  final Value<bool> isEmailVerified;
  final Value<bool> isPhoneVerified;
  final Value<int> rowid;
  const UserTableCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.isEmailVerified = const Value.absent(),
    this.isPhoneVerified = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserTableCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    this.photoUrl = const Value.absent(),
    this.isEmailVerified = const Value.absent(),
    this.isPhoneVerified = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        email = Value(email),
        phoneNumber = Value(phoneNumber);
  static Insertable<UserTableData> custom({
    Expression<String>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phoneNumber,
    Expression<String>? photoUrl,
    Expression<bool>? isEmailVerified,
    Expression<bool>? isPhoneVerified,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (isEmailVerified != null) 'is_email_verified': isEmailVerified,
      if (isPhoneVerified != null) 'is_phone_verified': isPhoneVerified,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? email,
      Value<String>? phoneNumber,
      Value<String?>? photoUrl,
      Value<bool>? isEmailVerified,
      Value<bool>? isPhoneVerified,
      Value<int>? rowid}) {
    return UserTableCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (isEmailVerified.present) {
      map['is_email_verified'] = Variable<bool>(isEmailVerified.value);
    }
    if (isPhoneVerified.present) {
      map['is_phone_verified'] = Variable<bool>(isPhoneVerified.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserTableCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('isEmailVerified: $isEmailVerified, ')
          ..write('isPhoneVerified: $isPhoneVerified, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserOtpTableTable extends UserOtpTable
    with TableInfo<$UserOtpTableTable, UserOtpTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserOtpTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<UserOtpTypeEnum, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<UserOtpTypeEnum>($UserOtpTableTable.$convertertype);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, userId, code, type, expiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_otps';
  @override
  VerificationContext validateIntegrity(Insertable<UserOtpTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserOtpTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserOtpTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      type: $UserOtpTableTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $UserOtpTableTable createAlias(String alias) {
    return $UserOtpTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UserOtpTypeEnum, String, String> $convertertype =
      const EnumNameConverter<UserOtpTypeEnum>(UserOtpTypeEnum.values);
}

class UserOtpTableData extends DataClass
    implements Insertable<UserOtpTableData> {
  final String id;
  final String userId;
  final String code;
  final UserOtpTypeEnum type;
  final DateTime expiresAt;
  const UserOtpTableData(
      {required this.id,
      required this.userId,
      required this.code,
      required this.type,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['code'] = Variable<String>(code);
    {
      map['type'] =
          Variable<String>($UserOtpTableTable.$convertertype.toSql(type));
    }
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  UserOtpTableCompanion toCompanion(bool nullToAbsent) {
    return UserOtpTableCompanion(
      id: Value(id),
      userId: Value(userId),
      code: Value(code),
      type: Value(type),
      expiresAt: Value(expiresAt),
    );
  }

  factory UserOtpTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserOtpTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      code: serializer.fromJson<String>(json['code']),
      type: $UserOtpTableTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'code': serializer.toJson<String>(code),
      'type': serializer
          .toJson<String>($UserOtpTableTable.$convertertype.toJson(type)),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  UserOtpTableData copyWith(
          {String? id,
          String? userId,
          String? code,
          UserOtpTypeEnum? type,
          DateTime? expiresAt}) =>
      UserOtpTableData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        code: code ?? this.code,
        type: type ?? this.type,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  UserOtpTableData copyWithCompanion(UserOtpTableCompanion data) {
    return UserOtpTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      code: data.code.present ? data.code.value : this.code,
      type: data.type.present ? data.type.value : this.type,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserOtpTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('code: $code, ')
          ..write('type: $type, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, code, type, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserOtpTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.code == this.code &&
          other.type == this.type &&
          other.expiresAt == this.expiresAt);
}

class UserOtpTableCompanion extends UpdateCompanion<UserOtpTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> code;
  final Value<UserOtpTypeEnum> type;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const UserOtpTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.code = const Value.absent(),
    this.type = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserOtpTableCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String code,
    required UserOtpTypeEnum type,
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        code = Value(code),
        type = Value(type),
        expiresAt = Value(expiresAt);
  static Insertable<UserOtpTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? code,
    Expression<String>? type,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (code != null) 'code': code,
      if (type != null) 'type': type,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserOtpTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? code,
      Value<UserOtpTypeEnum>? type,
      Value<DateTime>? expiresAt,
      Value<int>? rowid}) {
    return UserOtpTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      code: code ?? this.code,
      type: type ?? this.type,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($UserOtpTableTable.$convertertype.toSql(type.value));
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserOtpTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('code: $code, ')
          ..write('type: $type, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupsTableTable extends GroupsTable
    with TableInfo<$GroupsTableTable, GroupsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT true',
      defaultValue: const CustomExpression('TRUE'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        imageUrl,
        createdBy,
        createdAt,
        updatedAt,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups';
  @override
  VerificationContext validateIntegrity(Insertable<GroupsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $GroupsTableTable createAlias(String alias) {
    return $GroupsTableTable(attachedDatabase, alias);
  }
}

class GroupsTableData extends DataClass implements Insertable<GroupsTableData> {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  const GroupsTableData(
      {required this.id,
      required this.name,
      this.description,
      this.imageUrl,
      required this.createdBy,
      required this.createdAt,
      this.updatedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GroupsTableCompanion toCompanion(bool nullToAbsent) {
    return GroupsTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isActive: Value(isActive),
    );
  }

  factory GroupsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GroupsTableData copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> imageUrl = const Value.absent(),
          String? createdBy,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          bool? isActive}) =>
      GroupsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        isActive: isActive ?? this.isActive,
      );
  GroupsTableData copyWithCompanion(GroupsTableCompanion data) {
    return GroupsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, imageUrl, createdBy,
      createdAt, updatedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isActive == this.isActive);
}

class GroupsTableCompanion extends UpdateCompanion<GroupsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> imageUrl;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const GroupsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        createdBy = Value(createdBy);
  static Insertable<GroupsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? imageUrl,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return GroupsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupMembersTableTable extends GroupMembersTable
    with TableInfo<$GroupMembersTableTable, GroupMembersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupMembersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "groups" (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<GroupMemberRoleEnum, String>
      role = GeneratedColumn<String>('role', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<GroupMemberRoleEnum>(
              $GroupMembersTableTable.$converterrole);
  static const VerificationMeta _joinedAtMeta =
      const VerificationMeta('joinedAt');
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
      'joined_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT true',
      defaultValue: const CustomExpression('TRUE'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, groupId, userId, role, joinedAt, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_members';
  @override
  VerificationContext validateIntegrity(
      Insertable<GroupMembersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(_joinedAtMeta,
          joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {groupId, userId},
      ];
  @override
  GroupMembersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupMembersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      role: $GroupMembersTableTable.$converterrole.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!),
      joinedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}joined_at'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $GroupMembersTableTable createAlias(String alias) {
    return $GroupMembersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GroupMemberRoleEnum, String, String>
      $converterrole =
      const EnumNameConverter<GroupMemberRoleEnum>(GroupMemberRoleEnum.values);
}

class GroupMembersTableData extends DataClass
    implements Insertable<GroupMembersTableData> {
  final String id;
  final String groupId;
  final String userId;
  final GroupMemberRoleEnum role;
  final DateTime joinedAt;
  final bool isActive;
  const GroupMembersTableData(
      {required this.id,
      required this.groupId,
      required this.userId,
      required this.role,
      required this.joinedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['user_id'] = Variable<String>(userId);
    {
      map['role'] =
          Variable<String>($GroupMembersTableTable.$converterrole.toSql(role));
    }
    map['joined_at'] = Variable<DateTime>(joinedAt);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GroupMembersTableCompanion toCompanion(bool nullToAbsent) {
    return GroupMembersTableCompanion(
      id: Value(id),
      groupId: Value(groupId),
      userId: Value(userId),
      role: Value(role),
      joinedAt: Value(joinedAt),
      isActive: Value(isActive),
    );
  }

  factory GroupMembersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupMembersTableData(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      userId: serializer.fromJson<String>(json['userId']),
      role: $GroupMembersTableTable.$converterrole
          .fromJson(serializer.fromJson<String>(json['role'])),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'userId': serializer.toJson<String>(userId),
      'role': serializer
          .toJson<String>($GroupMembersTableTable.$converterrole.toJson(role)),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GroupMembersTableData copyWith(
          {String? id,
          String? groupId,
          String? userId,
          GroupMemberRoleEnum? role,
          DateTime? joinedAt,
          bool? isActive}) =>
      GroupMembersTableData(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        userId: userId ?? this.userId,
        role: role ?? this.role,
        joinedAt: joinedAt ?? this.joinedAt,
        isActive: isActive ?? this.isActive,
      );
  GroupMembersTableData copyWithCompanion(GroupMembersTableCompanion data) {
    return GroupMembersTableData(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupMembersTableData(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, groupId, userId, role, joinedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupMembersTableData &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.joinedAt == this.joinedAt &&
          other.isActive == this.isActive);
}

class GroupMembersTableCompanion
    extends UpdateCompanion<GroupMembersTableData> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> userId;
  final Value<GroupMemberRoleEnum> role;
  final Value<DateTime> joinedAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const GroupMembersTableCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupMembersTableCompanion.insert({
    this.id = const Value.absent(),
    required String groupId,
    required String userId,
    required GroupMemberRoleEnum role,
    this.joinedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : groupId = Value(groupId),
        userId = Value(userId),
        role = Value(role);
  static Insertable<GroupMembersTableData> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<DateTime>? joinedAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupMembersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? userId,
      Value<GroupMemberRoleEnum>? role,
      Value<DateTime>? joinedAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return GroupMembersTableCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
          $GroupMembersTableTable.$converterrole.toSql(role.value));
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupMembersTableCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupInvitesTableTable extends GroupInvitesTable
    with TableInfo<$GroupInvitesTableTable, GroupInvitesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupInvitesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "groups" (id)'));
  static const VerificationMeta _invitedByMeta =
      const VerificationMeta('invitedBy');
  @override
  late final GeneratedColumn<String> invitedBy = GeneratedColumn<String>(
      'invited_by', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _invitedUserIdMeta =
      const VerificationMeta('invitedUserId');
  @override
  late final GeneratedColumn<String> invitedUserId = GeneratedColumn<String>(
      'invited_user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<InviteStatusEnum, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<InviteStatusEnum>(
              $GroupInvitesTableTable.$converterstatus);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  static const VerificationMeta _expiresAtMeta =
      const VerificationMeta('expiresAt');
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
      'expires_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, groupId, invitedBy, invitedUserId, status, createdAt, expiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'group_invites';
  @override
  VerificationContext validateIntegrity(
      Insertable<GroupInvitesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('invited_by')) {
      context.handle(_invitedByMeta,
          invitedBy.isAcceptableOrUnknown(data['invited_by']!, _invitedByMeta));
    } else if (isInserting) {
      context.missing(_invitedByMeta);
    }
    if (data.containsKey('invited_user_id')) {
      context.handle(
          _invitedUserIdMeta,
          invitedUserId.isAcceptableOrUnknown(
              data['invited_user_id']!, _invitedUserIdMeta));
    } else if (isInserting) {
      context.missing(_invitedUserIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('expires_at')) {
      context.handle(_expiresAtMeta,
          expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta));
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GroupInvitesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GroupInvitesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id'])!,
      invitedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invited_by'])!,
      invitedUserId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}invited_user_id'])!,
      status: $GroupInvitesTableTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      expiresAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expires_at'])!,
    );
  }

  @override
  $GroupInvitesTableTable createAlias(String alias) {
    return $GroupInvitesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InviteStatusEnum, String, String> $converterstatus =
      const EnumNameConverter<InviteStatusEnum>(InviteStatusEnum.values);
}

class GroupInvitesTableData extends DataClass
    implements Insertable<GroupInvitesTableData> {
  final String id;
  final String groupId;
  final String invitedBy;
  final String invitedUserId;
  final InviteStatusEnum status;
  final DateTime createdAt;
  final DateTime expiresAt;
  const GroupInvitesTableData(
      {required this.id,
      required this.groupId,
      required this.invitedBy,
      required this.invitedUserId,
      required this.status,
      required this.createdAt,
      required this.expiresAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['invited_by'] = Variable<String>(invitedBy);
    map['invited_user_id'] = Variable<String>(invitedUserId);
    {
      map['status'] = Variable<String>(
          $GroupInvitesTableTable.$converterstatus.toSql(status));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['expires_at'] = Variable<DateTime>(expiresAt);
    return map;
  }

  GroupInvitesTableCompanion toCompanion(bool nullToAbsent) {
    return GroupInvitesTableCompanion(
      id: Value(id),
      groupId: Value(groupId),
      invitedBy: Value(invitedBy),
      invitedUserId: Value(invitedUserId),
      status: Value(status),
      createdAt: Value(createdAt),
      expiresAt: Value(expiresAt),
    );
  }

  factory GroupInvitesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GroupInvitesTableData(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      invitedBy: serializer.fromJson<String>(json['invitedBy']),
      invitedUserId: serializer.fromJson<String>(json['invitedUserId']),
      status: $GroupInvitesTableTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      expiresAt: serializer.fromJson<DateTime>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'invitedBy': serializer.toJson<String>(invitedBy),
      'invitedUserId': serializer.toJson<String>(invitedUserId),
      'status': serializer.toJson<String>(
          $GroupInvitesTableTable.$converterstatus.toJson(status)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'expiresAt': serializer.toJson<DateTime>(expiresAt),
    };
  }

  GroupInvitesTableData copyWith(
          {String? id,
          String? groupId,
          String? invitedBy,
          String? invitedUserId,
          InviteStatusEnum? status,
          DateTime? createdAt,
          DateTime? expiresAt}) =>
      GroupInvitesTableData(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        invitedBy: invitedBy ?? this.invitedBy,
        invitedUserId: invitedUserId ?? this.invitedUserId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        expiresAt: expiresAt ?? this.expiresAt,
      );
  GroupInvitesTableData copyWithCompanion(GroupInvitesTableCompanion data) {
    return GroupInvitesTableData(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      invitedBy: data.invitedBy.present ? data.invitedBy.value : this.invitedBy,
      invitedUserId: data.invitedUserId.present
          ? data.invitedUserId.value
          : this.invitedUserId,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GroupInvitesTableData(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('invitedUserId: $invitedUserId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, groupId, invitedBy, invitedUserId, status, createdAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GroupInvitesTableData &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.invitedBy == this.invitedBy &&
          other.invitedUserId == this.invitedUserId &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.expiresAt == this.expiresAt);
}

class GroupInvitesTableCompanion
    extends UpdateCompanion<GroupInvitesTableData> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<String> invitedBy;
  final Value<String> invitedUserId;
  final Value<InviteStatusEnum> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> expiresAt;
  final Value<int> rowid;
  const GroupInvitesTableCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.invitedBy = const Value.absent(),
    this.invitedUserId = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupInvitesTableCompanion.insert({
    this.id = const Value.absent(),
    required String groupId,
    required String invitedBy,
    required String invitedUserId,
    required InviteStatusEnum status,
    this.createdAt = const Value.absent(),
    required DateTime expiresAt,
    this.rowid = const Value.absent(),
  })  : groupId = Value(groupId),
        invitedBy = Value(invitedBy),
        invitedUserId = Value(invitedUserId),
        status = Value(status),
        expiresAt = Value(expiresAt);
  static Insertable<GroupInvitesTableData> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<String>? invitedBy,
    Expression<String>? invitedUserId,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? expiresAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (invitedBy != null) 'invited_by': invitedBy,
      if (invitedUserId != null) 'invited_user_id': invitedUserId,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupInvitesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? groupId,
      Value<String>? invitedBy,
      Value<String>? invitedUserId,
      Value<InviteStatusEnum>? status,
      Value<DateTime>? createdAt,
      Value<DateTime>? expiresAt,
      Value<int>? rowid}) {
    return GroupInvitesTableCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      invitedBy: invitedBy ?? this.invitedBy,
      invitedUserId: invitedUserId ?? this.invitedUserId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      expiresAt: expiresAt ?? this.expiresAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (invitedBy.present) {
      map['invited_by'] = Variable<String>(invitedBy.value);
    }
    if (invitedUserId.present) {
      map['invited_user_id'] = Variable<String>(invitedUserId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $GroupInvitesTableTable.$converterstatus.toSql(status.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupInvitesTableCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('invitedUserId: $invitedUserId, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoLocationsTableTable extends GoLocationsTable
    with TableInfo<$GoLocationsTableTable, GoLocationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoLocationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _googleMapsUrlMeta =
      const VerificationMeta('googleMapsUrl');
  @override
  late final GeneratedColumn<String> googleMapsUrl = GeneratedColumn<String>(
      'google_maps_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT true',
      defaultValue: const CustomExpression('TRUE'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        address,
        latitude,
        longitude,
        googleMapsUrl,
        createdBy,
        createdAt,
        updatedAt,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'go_locations';
  @override
  VerificationContext validateIntegrity(
      Insertable<GoLocationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('google_maps_url')) {
      context.handle(
          _googleMapsUrlMeta,
          googleMapsUrl.isAcceptableOrUnknown(
              data['google_maps_url']!, _googleMapsUrlMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoLocationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoLocationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude']),
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude']),
      googleMapsUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}google_maps_url']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $GoLocationsTableTable createAlias(String alias) {
    return $GoLocationsTableTable(attachedDatabase, alias);
  }
}

class GoLocationsTableData extends DataClass
    implements Insertable<GoLocationsTableData> {
  final String id;
  final String name;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? googleMapsUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  const GoLocationsTableData(
      {required this.id,
      required this.name,
      this.address,
      this.latitude,
      this.longitude,
      this.googleMapsUrl,
      required this.createdBy,
      required this.createdAt,
      this.updatedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || googleMapsUrl != null) {
      map['google_maps_url'] = Variable<String>(googleMapsUrl);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GoLocationsTableCompanion toCompanion(bool nullToAbsent) {
    return GoLocationsTableCompanion(
      id: Value(id),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      googleMapsUrl: googleMapsUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(googleMapsUrl),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isActive: Value(isActive),
    );
  }

  factory GoLocationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoLocationsTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      googleMapsUrl: serializer.fromJson<String?>(json['googleMapsUrl']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'googleMapsUrl': serializer.toJson<String?>(googleMapsUrl),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GoLocationsTableData copyWith(
          {String? id,
          String? name,
          Value<String?> address = const Value.absent(),
          Value<double?> latitude = const Value.absent(),
          Value<double?> longitude = const Value.absent(),
          Value<String?> googleMapsUrl = const Value.absent(),
          String? createdBy,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          bool? isActive}) =>
      GoLocationsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address.present ? address.value : this.address,
        latitude: latitude.present ? latitude.value : this.latitude,
        longitude: longitude.present ? longitude.value : this.longitude,
        googleMapsUrl:
            googleMapsUrl.present ? googleMapsUrl.value : this.googleMapsUrl,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        isActive: isActive ?? this.isActive,
      );
  GoLocationsTableData copyWithCompanion(GoLocationsTableCompanion data) {
    return GoLocationsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      googleMapsUrl: data.googleMapsUrl.present
          ? data.googleMapsUrl.value
          : this.googleMapsUrl,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoLocationsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('googleMapsUrl: $googleMapsUrl, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, address, latitude, longitude,
      googleMapsUrl, createdBy, createdAt, updatedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoLocationsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.address == this.address &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.googleMapsUrl == this.googleMapsUrl &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isActive == this.isActive);
}

class GoLocationsTableCompanion extends UpdateCompanion<GoLocationsTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> address;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> googleMapsUrl;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const GoLocationsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.googleMapsUrl = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoLocationsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.googleMapsUrl = const Value.absent(),
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        createdBy = Value(createdBy);
  static Insertable<GoLocationsTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? address,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? googleMapsUrl,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (googleMapsUrl != null) 'google_maps_url': googleMapsUrl,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoLocationsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? address,
      Value<double?>? latitude,
      Value<double?>? longitude,
      Value<String?>? googleMapsUrl,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return GoLocationsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      googleMapsUrl: googleMapsUrl ?? this.googleMapsUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (googleMapsUrl.present) {
      map['google_maps_url'] = Variable<String>(googleMapsUrl.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoLocationsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('googleMapsUrl: $googleMapsUrl, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoEventsTableTable extends GoEventsTable
    with TableInfo<$GoEventsTableTable, GoEventsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoEventsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationIdMeta =
      const VerificationMeta('locationId');
  @override
  late final GeneratedColumn<String> locationId = GeneratedColumn<String>(
      'location_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES go_locations (id)'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _groupIdMeta =
      const VerificationMeta('groupId');
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
      'group_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES "groups" (id)'));
  static const VerificationMeta _coverImageUrlMeta =
      const VerificationMeta('coverImageUrl');
  @override
  late final GeneratedColumn<String> coverImageUrl = GeneratedColumn<String>(
      'cover_image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT true',
      defaultValue: const CustomExpression('TRUE'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        locationId,
        startDate,
        endDate,
        groupId,
        coverImageUrl,
        createdBy,
        createdAt,
        updatedAt,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'go_events';
  @override
  VerificationContext validateIntegrity(Insertable<GoEventsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('location_id')) {
      context.handle(
          _locationIdMeta,
          locationId.isAcceptableOrUnknown(
              data['location_id']!, _locationIdMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('group_id')) {
      context.handle(_groupIdMeta,
          groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta));
    }
    if (data.containsKey('cover_image_url')) {
      context.handle(
          _coverImageUrlMeta,
          coverImageUrl.isAcceptableOrUnknown(
              data['cover_image_url']!, _coverImageUrlMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoEventsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoEventsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      locationId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_id']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      groupId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_id']),
      coverImageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cover_image_url']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $GoEventsTableTable createAlias(String alias) {
    return $GoEventsTableTable(attachedDatabase, alias);
  }
}

class GoEventsTableData extends DataClass
    implements Insertable<GoEventsTableData> {
  final String id;
  final String title;
  final String? description;
  final String? locationId;
  final DateTime startDate;
  final DateTime? endDate;
  final String? groupId;
  final String? coverImageUrl;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  const GoEventsTableData(
      {required this.id,
      required this.title,
      this.description,
      this.locationId,
      required this.startDate,
      this.endDate,
      this.groupId,
      this.coverImageUrl,
      required this.createdBy,
      required this.createdAt,
      this.updatedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || locationId != null) {
      map['location_id'] = Variable<String>(locationId);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    if (!nullToAbsent || coverImageUrl != null) {
      map['cover_image_url'] = Variable<String>(coverImageUrl);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GoEventsTableCompanion toCompanion(bool nullToAbsent) {
    return GoEventsTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      locationId: locationId == null && nullToAbsent
          ? const Value.absent()
          : Value(locationId),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      coverImageUrl: coverImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverImageUrl),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isActive: Value(isActive),
    );
  }

  factory GoEventsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoEventsTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      locationId: serializer.fromJson<String?>(json['locationId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      coverImageUrl: serializer.fromJson<String?>(json['coverImageUrl']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'locationId': serializer.toJson<String?>(locationId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'groupId': serializer.toJson<String?>(groupId),
      'coverImageUrl': serializer.toJson<String?>(coverImageUrl),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GoEventsTableData copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<String?> locationId = const Value.absent(),
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          Value<String?> groupId = const Value.absent(),
          Value<String?> coverImageUrl = const Value.absent(),
          String? createdBy,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          bool? isActive}) =>
      GoEventsTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        locationId: locationId.present ? locationId.value : this.locationId,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        groupId: groupId.present ? groupId.value : this.groupId,
        coverImageUrl:
            coverImageUrl.present ? coverImageUrl.value : this.coverImageUrl,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        isActive: isActive ?? this.isActive,
      );
  GoEventsTableData copyWithCompanion(GoEventsTableCompanion data) {
    return GoEventsTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      locationId:
          data.locationId.present ? data.locationId.value : this.locationId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      coverImageUrl: data.coverImageUrl.present
          ? data.coverImageUrl.value
          : this.coverImageUrl,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoEventsTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('locationId: $locationId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('groupId: $groupId, ')
          ..write('coverImageUrl: $coverImageUrl, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      description,
      locationId,
      startDate,
      endDate,
      groupId,
      coverImageUrl,
      createdBy,
      createdAt,
      updatedAt,
      isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoEventsTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.locationId == this.locationId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.groupId == this.groupId &&
          other.coverImageUrl == this.coverImageUrl &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isActive == this.isActive);
}

class GoEventsTableCompanion extends UpdateCompanion<GoEventsTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> locationId;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> groupId;
  final Value<String?> coverImageUrl;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const GoEventsTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.locationId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.groupId = const Value.absent(),
    this.coverImageUrl = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoEventsTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.locationId = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.groupId = const Value.absent(),
    this.coverImageUrl = const Value.absent(),
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        startDate = Value(startDate),
        createdBy = Value(createdBy);
  static Insertable<GoEventsTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? locationId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? groupId,
    Expression<String>? coverImageUrl,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (locationId != null) 'location_id': locationId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (groupId != null) 'group_id': groupId,
      if (coverImageUrl != null) 'cover_image_url': coverImageUrl,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoEventsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<String?>? locationId,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<String?>? groupId,
      Value<String?>? coverImageUrl,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return GoEventsTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      locationId: locationId ?? this.locationId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      groupId: groupId ?? this.groupId,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (locationId.present) {
      map['location_id'] = Variable<String>(locationId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (coverImageUrl.present) {
      map['cover_image_url'] = Variable<String>(coverImageUrl.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoEventsTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('locationId: $locationId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('groupId: $groupId, ')
          ..write('coverImageUrl: $coverImageUrl, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoParticipantsTableTable extends GoParticipantsTable
    with TableInfo<$GoParticipantsTableTable, GoParticipantsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoParticipantsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _eventIdMeta =
      const VerificationMeta('eventId');
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
      'event_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES go_events (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<GoParticipantStatusEnum, String>
      status = GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<GoParticipantStatusEnum>(
              $GoParticipantsTableTable.$converterstatus);
  static const VerificationMeta _invitedByMeta =
      const VerificationMeta('invitedBy');
  @override
  late final GeneratedColumn<String> invitedBy = GeneratedColumn<String>(
      'invited_by', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _invitedAtMeta =
      const VerificationMeta('invitedAt');
  @override
  late final GeneratedColumn<DateTime> invitedAt = GeneratedColumn<DateTime>(
      'invited_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  static const VerificationMeta _respondedAtMeta =
      const VerificationMeta('respondedAt');
  @override
  late final GeneratedColumn<DateTime> respondedAt = GeneratedColumn<DateTime>(
      'responded_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT true',
      defaultValue: const CustomExpression('TRUE'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        eventId,
        userId,
        status,
        invitedBy,
        invitedAt,
        respondedAt,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'go_participants';
  @override
  VerificationContext validateIntegrity(
      Insertable<GoParticipantsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('invited_by')) {
      context.handle(_invitedByMeta,
          invitedBy.isAcceptableOrUnknown(data['invited_by']!, _invitedByMeta));
    } else if (isInserting) {
      context.missing(_invitedByMeta);
    }
    if (data.containsKey('invited_at')) {
      context.handle(_invitedAtMeta,
          invitedAt.isAcceptableOrUnknown(data['invited_at']!, _invitedAtMeta));
    }
    if (data.containsKey('responded_at')) {
      context.handle(
          _respondedAtMeta,
          respondedAt.isAcceptableOrUnknown(
              data['responded_at']!, _respondedAtMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {eventId, userId},
      ];
  @override
  GoParticipantsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoParticipantsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      eventId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      status: $GoParticipantsTableTable.$converterstatus.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      invitedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}invited_by'])!,
      invitedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}invited_at'])!,
      respondedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}responded_at']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $GoParticipantsTableTable createAlias(String alias) {
    return $GoParticipantsTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoParticipantStatusEnum, String, String>
      $converterstatus = const EnumNameConverter<GoParticipantStatusEnum>(
          GoParticipantStatusEnum.values);
}

class GoParticipantsTableData extends DataClass
    implements Insertable<GoParticipantsTableData> {
  final String id;
  final String eventId;
  final String userId;
  final GoParticipantStatusEnum status;
  final String invitedBy;
  final DateTime invitedAt;
  final DateTime? respondedAt;
  final bool isActive;
  const GoParticipantsTableData(
      {required this.id,
      required this.eventId,
      required this.userId,
      required this.status,
      required this.invitedBy,
      required this.invitedAt,
      this.respondedAt,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['user_id'] = Variable<String>(userId);
    {
      map['status'] = Variable<String>(
          $GoParticipantsTableTable.$converterstatus.toSql(status));
    }
    map['invited_by'] = Variable<String>(invitedBy);
    map['invited_at'] = Variable<DateTime>(invitedAt);
    if (!nullToAbsent || respondedAt != null) {
      map['responded_at'] = Variable<DateTime>(respondedAt);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GoParticipantsTableCompanion toCompanion(bool nullToAbsent) {
    return GoParticipantsTableCompanion(
      id: Value(id),
      eventId: Value(eventId),
      userId: Value(userId),
      status: Value(status),
      invitedBy: Value(invitedBy),
      invitedAt: Value(invitedAt),
      respondedAt: respondedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(respondedAt),
      isActive: Value(isActive),
    );
  }

  factory GoParticipantsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoParticipantsTableData(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      userId: serializer.fromJson<String>(json['userId']),
      status: $GoParticipantsTableTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      invitedBy: serializer.fromJson<String>(json['invitedBy']),
      invitedAt: serializer.fromJson<DateTime>(json['invitedAt']),
      respondedAt: serializer.fromJson<DateTime?>(json['respondedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'userId': serializer.toJson<String>(userId),
      'status': serializer.toJson<String>(
          $GoParticipantsTableTable.$converterstatus.toJson(status)),
      'invitedBy': serializer.toJson<String>(invitedBy),
      'invitedAt': serializer.toJson<DateTime>(invitedAt),
      'respondedAt': serializer.toJson<DateTime?>(respondedAt),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GoParticipantsTableData copyWith(
          {String? id,
          String? eventId,
          String? userId,
          GoParticipantStatusEnum? status,
          String? invitedBy,
          DateTime? invitedAt,
          Value<DateTime?> respondedAt = const Value.absent(),
          bool? isActive}) =>
      GoParticipantsTableData(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        userId: userId ?? this.userId,
        status: status ?? this.status,
        invitedBy: invitedBy ?? this.invitedBy,
        invitedAt: invitedAt ?? this.invitedAt,
        respondedAt: respondedAt.present ? respondedAt.value : this.respondedAt,
        isActive: isActive ?? this.isActive,
      );
  GoParticipantsTableData copyWithCompanion(GoParticipantsTableCompanion data) {
    return GoParticipantsTableData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      userId: data.userId.present ? data.userId.value : this.userId,
      status: data.status.present ? data.status.value : this.status,
      invitedBy: data.invitedBy.present ? data.invitedBy.value : this.invitedBy,
      invitedAt: data.invitedAt.present ? data.invitedAt.value : this.invitedAt,
      respondedAt:
          data.respondedAt.present ? data.respondedAt.value : this.respondedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoParticipantsTableData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('invitedAt: $invitedAt, ')
          ..write('respondedAt: $respondedAt, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, eventId, userId, status, invitedBy, invitedAt, respondedAt, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoParticipantsTableData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.userId == this.userId &&
          other.status == this.status &&
          other.invitedBy == this.invitedBy &&
          other.invitedAt == this.invitedAt &&
          other.respondedAt == this.respondedAt &&
          other.isActive == this.isActive);
}

class GoParticipantsTableCompanion
    extends UpdateCompanion<GoParticipantsTableData> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> userId;
  final Value<GoParticipantStatusEnum> status;
  final Value<String> invitedBy;
  final Value<DateTime> invitedAt;
  final Value<DateTime?> respondedAt;
  final Value<bool> isActive;
  final Value<int> rowid;
  const GoParticipantsTableCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.userId = const Value.absent(),
    this.status = const Value.absent(),
    this.invitedBy = const Value.absent(),
    this.invitedAt = const Value.absent(),
    this.respondedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoParticipantsTableCompanion.insert({
    this.id = const Value.absent(),
    required String eventId,
    required String userId,
    required GoParticipantStatusEnum status,
    required String invitedBy,
    this.invitedAt = const Value.absent(),
    this.respondedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : eventId = Value(eventId),
        userId = Value(userId),
        status = Value(status),
        invitedBy = Value(invitedBy);
  static Insertable<GoParticipantsTableData> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? userId,
    Expression<String>? status,
    Expression<String>? invitedBy,
    Expression<DateTime>? invitedAt,
    Expression<DateTime>? respondedAt,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (userId != null) 'user_id': userId,
      if (status != null) 'status': status,
      if (invitedBy != null) 'invited_by': invitedBy,
      if (invitedAt != null) 'invited_at': invitedAt,
      if (respondedAt != null) 'responded_at': respondedAt,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoParticipantsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? eventId,
      Value<String>? userId,
      Value<GoParticipantStatusEnum>? status,
      Value<String>? invitedBy,
      Value<DateTime>? invitedAt,
      Value<DateTime?>? respondedAt,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return GoParticipantsTableCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      invitedBy: invitedBy ?? this.invitedBy,
      invitedAt: invitedAt ?? this.invitedAt,
      respondedAt: respondedAt ?? this.respondedAt,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $GoParticipantsTableTable.$converterstatus.toSql(status.value));
    }
    if (invitedBy.present) {
      map['invited_by'] = Variable<String>(invitedBy.value);
    }
    if (invitedAt.present) {
      map['invited_at'] = Variable<DateTime>(invitedAt.value);
    }
    if (respondedAt.present) {
      map['responded_at'] = Variable<DateTime>(respondedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoParticipantsTableCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('userId: $userId, ')
          ..write('status: $status, ')
          ..write('invitedBy: $invitedBy, ')
          ..write('invitedAt: $invitedAt, ')
          ..write('respondedAt: $respondedAt, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoTasksTableTable extends GoTasksTable
    with TableInfo<$GoTasksTableTable, GoTasksTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoTasksTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _eventIdMeta =
      const VerificationMeta('eventId');
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
      'event_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES go_events (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
      'is_done', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT false',
      defaultValue: const CustomExpression('FALSE'));
  static const VerificationMeta _isPrivateMeta =
      const VerificationMeta('isPrivate');
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
      'is_private', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT false',
      defaultValue: const CustomExpression('FALSE'));
  static const VerificationMeta _completedByMeta =
      const VerificationMeta('completedBy');
  @override
  late final GeneratedColumn<String> completedBy = GeneratedColumn<String>(
      'completed_by', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _updatedByMeta =
      const VerificationMeta('updatedBy');
  @override
  late final GeneratedColumn<String> updatedBy = GeneratedColumn<String>(
      'updated_by', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        eventId,
        title,
        description,
        deadline,
        createdBy,
        createdAt,
        completedAt,
        updatedAt,
        isDone,
        isPrivate,
        completedBy,
        updatedBy
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'go_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<GoTasksTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    } else if (isInserting) {
      context.missing(_createdByMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_done')) {
      context.handle(_isDoneMeta,
          isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta));
    }
    if (data.containsKey('is_private')) {
      context.handle(_isPrivateMeta,
          isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta));
    }
    if (data.containsKey('completed_by')) {
      context.handle(
          _completedByMeta,
          completedBy.isAcceptableOrUnknown(
              data['completed_by']!, _completedByMeta));
    }
    if (data.containsKey('updated_by')) {
      context.handle(_updatedByMeta,
          updatedBy.isAcceptableOrUnknown(data['updated_by']!, _updatedByMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoTasksTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoTasksTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      eventId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      isDone: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_done'])!,
      isPrivate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_private'])!,
      completedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}completed_by']),
      updatedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}updated_by']),
    );
  }

  @override
  $GoTasksTableTable createAlias(String alias) {
    return $GoTasksTableTable(attachedDatabase, alias);
  }
}

class GoTasksTableData extends DataClass
    implements Insertable<GoTasksTableData> {
  final String id;
  final String eventId;
  final String title;
  final String? description;
  final DateTime? deadline;
  final String createdBy;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? updatedAt;
  final bool isDone;
  final bool isPrivate;
  final String? completedBy;
  final String? updatedBy;
  const GoTasksTableData(
      {required this.id,
      required this.eventId,
      required this.title,
      this.description,
      this.deadline,
      required this.createdBy,
      required this.createdAt,
      this.completedAt,
      this.updatedAt,
      required this.isDone,
      required this.isPrivate,
      this.completedBy,
      this.updatedBy});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['created_by'] = Variable<String>(createdBy);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_done'] = Variable<bool>(isDone);
    map['is_private'] = Variable<bool>(isPrivate);
    if (!nullToAbsent || completedBy != null) {
      map['completed_by'] = Variable<String>(completedBy);
    }
    if (!nullToAbsent || updatedBy != null) {
      map['updated_by'] = Variable<String>(updatedBy);
    }
    return map;
  }

  GoTasksTableCompanion toCompanion(bool nullToAbsent) {
    return GoTasksTableCompanion(
      id: Value(id),
      eventId: Value(eventId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      createdBy: Value(createdBy),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isDone: Value(isDone),
      isPrivate: Value(isPrivate),
      completedBy: completedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(completedBy),
      updatedBy: updatedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedBy),
    );
  }

  factory GoTasksTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoTasksTableData(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      createdBy: serializer.fromJson<String>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      completedBy: serializer.fromJson<String?>(json['completedBy']),
      updatedBy: serializer.fromJson<String?>(json['updatedBy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'createdBy': serializer.toJson<String>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isDone': serializer.toJson<bool>(isDone),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'completedBy': serializer.toJson<String?>(completedBy),
      'updatedBy': serializer.toJson<String?>(updatedBy),
    };
  }

  GoTasksTableData copyWith(
          {String? id,
          String? eventId,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> deadline = const Value.absent(),
          String? createdBy,
          DateTime? createdAt,
          Value<DateTime?> completedAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent(),
          bool? isDone,
          bool? isPrivate,
          Value<String?> completedBy = const Value.absent(),
          Value<String?> updatedBy = const Value.absent()}) =>
      GoTasksTableData(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        deadline: deadline.present ? deadline.value : this.deadline,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        isDone: isDone ?? this.isDone,
        isPrivate: isPrivate ?? this.isPrivate,
        completedBy: completedBy.present ? completedBy.value : this.completedBy,
        updatedBy: updatedBy.present ? updatedBy.value : this.updatedBy,
      );
  GoTasksTableData copyWithCompanion(GoTasksTableCompanion data) {
    return GoTasksTableData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      completedBy:
          data.completedBy.present ? data.completedBy.value : this.completedBy,
      updatedBy: data.updatedBy.present ? data.updatedBy.value : this.updatedBy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoTasksTableData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDone: $isDone, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('completedBy: $completedBy, ')
          ..write('updatedBy: $updatedBy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      eventId,
      title,
      description,
      deadline,
      createdBy,
      createdAt,
      completedAt,
      updatedAt,
      isDone,
      isPrivate,
      completedBy,
      updatedBy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoTasksTableData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.title == this.title &&
          other.description == this.description &&
          other.deadline == this.deadline &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt &&
          other.isDone == this.isDone &&
          other.isPrivate == this.isPrivate &&
          other.completedBy == this.completedBy &&
          other.updatedBy == this.updatedBy);
}

class GoTasksTableCompanion extends UpdateCompanion<GoTasksTableData> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> deadline;
  final Value<String> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isDone;
  final Value<bool> isPrivate;
  final Value<String?> completedBy;
  final Value<String?> updatedBy;
  final Value<int> rowid;
  const GoTasksTableCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.deadline = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDone = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.completedBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoTasksTableCompanion.insert({
    this.id = const Value.absent(),
    required String eventId,
    required String title,
    this.description = const Value.absent(),
    this.deadline = const Value.absent(),
    required String createdBy,
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDone = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.completedBy = const Value.absent(),
    this.updatedBy = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : eventId = Value(eventId),
        title = Value(title),
        createdBy = Value(createdBy);
  static Insertable<GoTasksTableData> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? deadline,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDone,
    Expression<bool>? isPrivate,
    Expression<String>? completedBy,
    Expression<String>? updatedBy,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (deadline != null) 'deadline': deadline,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDone != null) 'is_done': isDone,
      if (isPrivate != null) 'is_private': isPrivate,
      if (completedBy != null) 'completed_by': completedBy,
      if (updatedBy != null) 'updated_by': updatedBy,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoTasksTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? eventId,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime?>? deadline,
      Value<String>? createdBy,
      Value<DateTime>? createdAt,
      Value<DateTime?>? completedAt,
      Value<DateTime?>? updatedAt,
      Value<bool>? isDone,
      Value<bool>? isPrivate,
      Value<String?>? completedBy,
      Value<String?>? updatedBy,
      Value<int>? rowid}) {
    return GoTasksTableCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDone: isDone ?? this.isDone,
      isPrivate: isPrivate ?? this.isPrivate,
      completedBy: completedBy ?? this.completedBy,
      updatedBy: updatedBy ?? this.updatedBy,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (completedBy.present) {
      map['completed_by'] = Variable<String>(completedBy.value);
    }
    if (updatedBy.present) {
      map['updated_by'] = Variable<String>(updatedBy.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoTasksTableCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDone: $isDone, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('completedBy: $completedBy, ')
          ..write('updatedBy: $updatedBy, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoRemindersTableTable extends GoRemindersTable
    with TableInfo<$GoRemindersTableTable, GoRemindersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoRemindersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      clientDefault: const Uuid().v4);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES go_tasks (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<GoReminderType, String>
      reminderType = GeneratedColumn<String>(
              'reminder_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<GoReminderType>(
              $GoRemindersTableTable.$converterreminderType);
  static const VerificationMeta _remindAtMeta =
      const VerificationMeta('remindAt');
  @override
  late final GeneratedColumn<DateTime> remindAt = GeneratedColumn<DateTime>(
      'remind_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _minutesBeforeMeta =
      const VerificationMeta('minutesBefore');
  @override
  late final GeneratedColumn<int> minutesBefore = GeneratedColumn<int>(
      'minutes_before', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isSentMeta = const VerificationMeta('isSent');
  @override
  late final GeneratedColumn<bool> isSent = GeneratedColumn<bool>(
      'is_sent', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT false',
      defaultValue: const CustomExpression('FALSE'));
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
      'sent_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: DateTime.now().toUtc);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        taskId,
        userId,
        reminderType,
        remindAt,
        minutesBefore,
        isSent,
        sentAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'go_reminders';
  @override
  VerificationContext validateIntegrity(
      Insertable<GoRemindersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('remind_at')) {
      context.handle(_remindAtMeta,
          remindAt.isAcceptableOrUnknown(data['remind_at']!, _remindAtMeta));
    }
    if (data.containsKey('minutes_before')) {
      context.handle(
          _minutesBeforeMeta,
          minutesBefore.isAcceptableOrUnknown(
              data['minutes_before']!, _minutesBeforeMeta));
    }
    if (data.containsKey('is_sent')) {
      context.handle(_isSentMeta,
          isSent.isAcceptableOrUnknown(data['is_sent']!, _isSentMeta));
    }
    if (data.containsKey('sent_at')) {
      context.handle(_sentAtMeta,
          sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoRemindersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoRemindersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      reminderType: $GoRemindersTableTable.$converterreminderType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}reminder_type'])!),
      remindAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}remind_at']),
      minutesBefore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}minutes_before']),
      isSent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_sent'])!,
      sentAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sent_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $GoRemindersTableTable createAlias(String alias) {
    return $GoRemindersTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoReminderType, String, String>
      $converterreminderType =
      const EnumNameConverter<GoReminderType>(GoReminderType.values);
}

class GoRemindersTableData extends DataClass
    implements Insertable<GoRemindersTableData> {
  final String id;
  final String taskId;
  final String userId;
  final GoReminderType reminderType;
  final DateTime? remindAt;
  final int? minutesBefore;
  final bool isSent;
  final DateTime? sentAt;
  final DateTime createdAt;
  const GoRemindersTableData(
      {required this.id,
      required this.taskId,
      required this.userId,
      required this.reminderType,
      this.remindAt,
      this.minutesBefore,
      required this.isSent,
      this.sentAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['user_id'] = Variable<String>(userId);
    {
      map['reminder_type'] = Variable<String>(
          $GoRemindersTableTable.$converterreminderType.toSql(reminderType));
    }
    if (!nullToAbsent || remindAt != null) {
      map['remind_at'] = Variable<DateTime>(remindAt);
    }
    if (!nullToAbsent || minutesBefore != null) {
      map['minutes_before'] = Variable<int>(minutesBefore);
    }
    map['is_sent'] = Variable<bool>(isSent);
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoRemindersTableCompanion toCompanion(bool nullToAbsent) {
    return GoRemindersTableCompanion(
      id: Value(id),
      taskId: Value(taskId),
      userId: Value(userId),
      reminderType: Value(reminderType),
      remindAt: remindAt == null && nullToAbsent
          ? const Value.absent()
          : Value(remindAt),
      minutesBefore: minutesBefore == null && nullToAbsent
          ? const Value.absent()
          : Value(minutesBefore),
      isSent: Value(isSent),
      sentAt:
          sentAt == null && nullToAbsent ? const Value.absent() : Value(sentAt),
      createdAt: Value(createdAt),
    );
  }

  factory GoRemindersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoRemindersTableData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      userId: serializer.fromJson<String>(json['userId']),
      reminderType: $GoRemindersTableTable.$converterreminderType
          .fromJson(serializer.fromJson<String>(json['reminderType'])),
      remindAt: serializer.fromJson<DateTime?>(json['remindAt']),
      minutesBefore: serializer.fromJson<int?>(json['minutesBefore']),
      isSent: serializer.fromJson<bool>(json['isSent']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'userId': serializer.toJson<String>(userId),
      'reminderType': serializer.toJson<String>(
          $GoRemindersTableTable.$converterreminderType.toJson(reminderType)),
      'remindAt': serializer.toJson<DateTime?>(remindAt),
      'minutesBefore': serializer.toJson<int?>(minutesBefore),
      'isSent': serializer.toJson<bool>(isSent),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GoRemindersTableData copyWith(
          {String? id,
          String? taskId,
          String? userId,
          GoReminderType? reminderType,
          Value<DateTime?> remindAt = const Value.absent(),
          Value<int?> minutesBefore = const Value.absent(),
          bool? isSent,
          Value<DateTime?> sentAt = const Value.absent(),
          DateTime? createdAt}) =>
      GoRemindersTableData(
        id: id ?? this.id,
        taskId: taskId ?? this.taskId,
        userId: userId ?? this.userId,
        reminderType: reminderType ?? this.reminderType,
        remindAt: remindAt.present ? remindAt.value : this.remindAt,
        minutesBefore:
            minutesBefore.present ? minutesBefore.value : this.minutesBefore,
        isSent: isSent ?? this.isSent,
        sentAt: sentAt.present ? sentAt.value : this.sentAt,
        createdAt: createdAt ?? this.createdAt,
      );
  GoRemindersTableData copyWithCompanion(GoRemindersTableCompanion data) {
    return GoRemindersTableData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      userId: data.userId.present ? data.userId.value : this.userId,
      reminderType: data.reminderType.present
          ? data.reminderType.value
          : this.reminderType,
      remindAt: data.remindAt.present ? data.remindAt.value : this.remindAt,
      minutesBefore: data.minutesBefore.present
          ? data.minutesBefore.value
          : this.minutesBefore,
      isSent: data.isSent.present ? data.isSent.value : this.isSent,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoRemindersTableData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('userId: $userId, ')
          ..write('reminderType: $reminderType, ')
          ..write('remindAt: $remindAt, ')
          ..write('minutesBefore: $minutesBefore, ')
          ..write('isSent: $isSent, ')
          ..write('sentAt: $sentAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, userId, reminderType, remindAt,
      minutesBefore, isSent, sentAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoRemindersTableData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.userId == this.userId &&
          other.reminderType == this.reminderType &&
          other.remindAt == this.remindAt &&
          other.minutesBefore == this.minutesBefore &&
          other.isSent == this.isSent &&
          other.sentAt == this.sentAt &&
          other.createdAt == this.createdAt);
}

class GoRemindersTableCompanion extends UpdateCompanion<GoRemindersTableData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> userId;
  final Value<GoReminderType> reminderType;
  final Value<DateTime?> remindAt;
  final Value<int?> minutesBefore;
  final Value<bool> isSent;
  final Value<DateTime?> sentAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GoRemindersTableCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.userId = const Value.absent(),
    this.reminderType = const Value.absent(),
    this.remindAt = const Value.absent(),
    this.minutesBefore = const Value.absent(),
    this.isSent = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoRemindersTableCompanion.insert({
    this.id = const Value.absent(),
    required String taskId,
    required String userId,
    required GoReminderType reminderType,
    this.remindAt = const Value.absent(),
    this.minutesBefore = const Value.absent(),
    this.isSent = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : taskId = Value(taskId),
        userId = Value(userId),
        reminderType = Value(reminderType);
  static Insertable<GoRemindersTableData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? userId,
    Expression<String>? reminderType,
    Expression<DateTime>? remindAt,
    Expression<int>? minutesBefore,
    Expression<bool>? isSent,
    Expression<DateTime>? sentAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (userId != null) 'user_id': userId,
      if (reminderType != null) 'reminder_type': reminderType,
      if (remindAt != null) 'remind_at': remindAt,
      if (minutesBefore != null) 'minutes_before': minutesBefore,
      if (isSent != null) 'is_sent': isSent,
      if (sentAt != null) 'sent_at': sentAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoRemindersTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? taskId,
      Value<String>? userId,
      Value<GoReminderType>? reminderType,
      Value<DateTime?>? remindAt,
      Value<int?>? minutesBefore,
      Value<bool>? isSent,
      Value<DateTime?>? sentAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return GoRemindersTableCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      reminderType: reminderType ?? this.reminderType,
      remindAt: remindAt ?? this.remindAt,
      minutesBefore: minutesBefore ?? this.minutesBefore,
      isSent: isSent ?? this.isSent,
      sentAt: sentAt ?? this.sentAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (reminderType.present) {
      map['reminder_type'] = Variable<String>($GoRemindersTableTable
          .$converterreminderType
          .toSql(reminderType.value));
    }
    if (remindAt.present) {
      map['remind_at'] = Variable<DateTime>(remindAt.value);
    }
    if (minutesBefore.present) {
      map['minutes_before'] = Variable<int>(minutesBefore.value);
    }
    if (isSent.present) {
      map['is_sent'] = Variable<bool>(isSent.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoRemindersTableCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('userId: $userId, ')
          ..write('reminderType: $reminderType, ')
          ..write('remindAt: $remindAt, ')
          ..write('minutesBefore: $minutesBefore, ')
          ..write('isSent: $isSent, ')
          ..write('sentAt: $sentAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $UserTableTable userTable = $UserTableTable(this);
  late final $UserOtpTableTable userOtpTable = $UserOtpTableTable(this);
  late final $GroupsTableTable groupsTable = $GroupsTableTable(this);
  late final $GroupMembersTableTable groupMembersTable =
      $GroupMembersTableTable(this);
  late final $GroupInvitesTableTable groupInvitesTable =
      $GroupInvitesTableTable(this);
  late final $GoLocationsTableTable goLocationsTable =
      $GoLocationsTableTable(this);
  late final $GoEventsTableTable goEventsTable = $GoEventsTableTable(this);
  late final $GoParticipantsTableTable goParticipantsTable =
      $GoParticipantsTableTable(this);
  late final $GoTasksTableTable goTasksTable = $GoTasksTableTable(this);
  late final $GoRemindersTableTable goRemindersTable =
      $GoRemindersTableTable(this);
  late final Index idxGoParticipantsLookup = Index('idx_go_participants_lookup',
      'CREATE INDEX idx_go_participants_lookup ON go_participants (event_id, user_id)');
  late final Index idxGoRemindersTask = Index('idx_go_reminders_task',
      'CREATE INDEX idx_go_reminders_task ON go_reminders (task_id)');
  late final Index idxGoRemindersUser = Index('idx_go_reminders_user',
      'CREATE INDEX idx_go_reminders_user ON go_reminders (user_id)');
  late final Index idxGoRemindersRemindAt = Index('idx_go_reminders_remind_at',
      'CREATE INDEX idx_go_reminders_remind_at ON go_reminders (remind_at)');
  late final Index idxGoTasksEventPrivacy = Index('idx_go_tasks_event_privacy',
      'CREATE INDEX idx_go_tasks_event_privacy ON go_tasks (event_id, is_private)');
  late final UsersDao usersDao = UsersDao(this as Database);
  late final GroupsDao groupsDao = GroupsDao(this as Database);
  late final GoDao goDao = GoDao(this as Database);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userTable,
        userOtpTable,
        groupsTable,
        groupMembersTable,
        groupInvitesTable,
        goLocationsTable,
        goEventsTable,
        goParticipantsTable,
        goTasksTable,
        goRemindersTable,
        idxGoParticipantsLookup,
        idxGoRemindersTask,
        idxGoRemindersUser,
        idxGoRemindersRemindAt,
        idxGoTasksEventPrivacy
      ];
}

typedef $$UserTableTableCreateCompanionBuilder = UserTableCompanion Function({
  Value<String> id,
  required String firstName,
  required String lastName,
  required String email,
  required String phoneNumber,
  Value<String?> photoUrl,
  Value<bool> isEmailVerified,
  Value<bool> isPhoneVerified,
  Value<int> rowid,
});
typedef $$UserTableTableUpdateCompanionBuilder = UserTableCompanion Function({
  Value<String> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> email,
  Value<String> phoneNumber,
  Value<String?> photoUrl,
  Value<bool> isEmailVerified,
  Value<bool> isPhoneVerified,
  Value<int> rowid,
});

final class $$UserTableTableReferences
    extends BaseReferences<_$Database, $UserTableTable, UserTableData> {
  $$UserTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserOtpTableTable, List<UserOtpTableData>>
      _userOtpTableRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
          db.userOtpTable,
          aliasName:
              $_aliasNameGenerator(db.userTable.id, db.userOtpTable.userId));

  $$UserOtpTableTableProcessedTableManager get userOtpTableRefs {
    final manager = $$UserOtpTableTableTableManager($_db, $_db.userOtpTable)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userOtpTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GroupsTableTable, List<GroupsTableData>>
      _groupsTableRefsTable(_$Database db) => MultiTypedResultKey.fromTable(
          db.groupsTable,
          aliasName:
              $_aliasNameGenerator(db.userTable.id, db.groupsTable.createdBy));

  $$GroupsTableTableProcessedTableManager get groupsTableRefs {
    final manager = $$GroupsTableTableTableManager($_db, $_db.groupsTable)
        .filter((f) => f.createdBy.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_groupsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GroupMembersTableTable,
      List<GroupMembersTableData>> _groupMembersTableRefsTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.groupMembersTable,
          aliasName: $_aliasNameGenerator(
              db.userTable.id, db.groupMembersTable.userId));

  $$GroupMembersTableTableProcessedTableManager get groupMembersTableRefs {
    final manager =
        $$GroupMembersTableTableTableManager($_db, $_db.groupMembersTable)
            .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_groupMembersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoLocationsTableTable, List<GoLocationsTableData>>
      _goLocationsTableRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.goLocationsTable,
              aliasName: $_aliasNameGenerator(
                  db.userTable.id, db.goLocationsTable.createdBy));

  $$GoLocationsTableTableProcessedTableManager get goLocationsTableRefs {
    final manager = $$GoLocationsTableTableTableManager(
            $_db, $_db.goLocationsTable)
        .filter((f) => f.createdBy.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_goLocationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoEventsTableTable, List<GoEventsTableData>>
      _goEventsTableRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.goEventsTable,
              aliasName: $_aliasNameGenerator(
                  db.userTable.id, db.goEventsTable.createdBy));

  $$GoEventsTableTableProcessedTableManager get goEventsTableRefs {
    final manager = $$GoEventsTableTableTableManager($_db, $_db.goEventsTable)
        .filter((f) => f.createdBy.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goEventsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoRemindersTableTable, List<GoRemindersTableData>>
      _goRemindersTableRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.goRemindersTable,
              aliasName: $_aliasNameGenerator(
                  db.userTable.id, db.goRemindersTable.userId));

  $$GoRemindersTableTableProcessedTableManager get goRemindersTableRefs {
    final manager =
        $$GoRemindersTableTableTableManager($_db, $_db.goRemindersTable)
            .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_goRemindersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UserTableTableFilterComposer
    extends Composer<_$Database, $UserTableTable> {
  $$UserTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isEmailVerified => $composableBuilder(
      column: $table.isEmailVerified,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPhoneVerified => $composableBuilder(
      column: $table.isPhoneVerified,
      builder: (column) => ColumnFilters(column));

  Expression<bool> userOtpTableRefs(
      Expression<bool> Function($$UserOtpTableTableFilterComposer f) f) {
    final $$UserOtpTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userOtpTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserOtpTableTableFilterComposer(
              $db: $db,
              $table: $db.userOtpTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> groupsTableRefs(
      Expression<bool> Function($$GroupsTableTableFilterComposer f) f) {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableFilterComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> groupMembersTableRefs(
      Expression<bool> Function($$GroupMembersTableTableFilterComposer f) f) {
    final $$GroupMembersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupMembersTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupMembersTableTableFilterComposer(
              $db: $db,
              $table: $db.groupMembersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goLocationsTableRefs(
      Expression<bool> Function($$GoLocationsTableTableFilterComposer f) f) {
    final $$GoLocationsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goLocationsTable,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoLocationsTableTableFilterComposer(
              $db: $db,
              $table: $db.goLocationsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goEventsTableRefs(
      Expression<bool> Function($$GoEventsTableTableFilterComposer f) f) {
    final $$GoEventsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableFilterComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goRemindersTableRefs(
      Expression<bool> Function($$GoRemindersTableTableFilterComposer f) f) {
    final $$GoRemindersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goRemindersTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoRemindersTableTableFilterComposer(
              $db: $db,
              $table: $db.goRemindersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableOrderingComposer
    extends Composer<_$Database, $UserTableTable> {
  $$UserTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEmailVerified => $composableBuilder(
      column: $table.isEmailVerified,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPhoneVerified => $composableBuilder(
      column: $table.isPhoneVerified,
      builder: (column) => ColumnOrderings(column));
}

class $$UserTableTableAnnotationComposer
    extends Composer<_$Database, $UserTableTable> {
  $$UserTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<bool> get isEmailVerified => $composableBuilder(
      column: $table.isEmailVerified, builder: (column) => column);

  GeneratedColumn<bool> get isPhoneVerified => $composableBuilder(
      column: $table.isPhoneVerified, builder: (column) => column);

  Expression<T> userOtpTableRefs<T extends Object>(
      Expression<T> Function($$UserOtpTableTableAnnotationComposer a) f) {
    final $$UserOtpTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.userOtpTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserOtpTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userOtpTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> groupsTableRefs<T extends Object>(
      Expression<T> Function($$GroupsTableTableAnnotationComposer a) f) {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> groupMembersTableRefs<T extends Object>(
      Expression<T> Function($$GroupMembersTableTableAnnotationComposer a) f) {
    final $$GroupMembersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.groupMembersTable,
            getReferencedColumn: (t) => t.userId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GroupMembersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.groupMembersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> goLocationsTableRefs<T extends Object>(
      Expression<T> Function($$GoLocationsTableTableAnnotationComposer a) f) {
    final $$GoLocationsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goLocationsTable,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoLocationsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goLocationsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> goEventsTableRefs<T extends Object>(
      Expression<T> Function($$GoEventsTableTableAnnotationComposer a) f) {
    final $$GoEventsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.createdBy,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> goRemindersTableRefs<T extends Object>(
      Expression<T> Function($$GoRemindersTableTableAnnotationComposer a) f) {
    final $$GoRemindersTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goRemindersTable,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoRemindersTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goRemindersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UserTableTableTableManager extends RootTableManager<
    _$Database,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (UserTableData, $$UserTableTableReferences),
    UserTableData,
    PrefetchHooks Function(
        {bool userOtpTableRefs,
        bool groupsTableRefs,
        bool groupMembersTableRefs,
        bool goLocationsTableRefs,
        bool goEventsTableRefs,
        bool goRemindersTableRefs})> {
  $$UserTableTableTableManager(_$Database db, $UserTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> phoneNumber = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<bool> isEmailVerified = const Value.absent(),
            Value<bool> isPhoneVerified = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserTableCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            photoUrl: photoUrl,
            isEmailVerified: isEmailVerified,
            isPhoneVerified: isPhoneVerified,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String firstName,
            required String lastName,
            required String email,
            required String phoneNumber,
            Value<String?> photoUrl = const Value.absent(),
            Value<bool> isEmailVerified = const Value.absent(),
            Value<bool> isPhoneVerified = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserTableCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            photoUrl: photoUrl,
            isEmailVerified: isEmailVerified,
            isPhoneVerified: isPhoneVerified,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {userOtpTableRefs = false,
              groupsTableRefs = false,
              groupMembersTableRefs = false,
              goLocationsTableRefs = false,
              goEventsTableRefs = false,
              goRemindersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userOtpTableRefs) db.userOtpTable,
                if (groupsTableRefs) db.groupsTable,
                if (groupMembersTableRefs) db.groupMembersTable,
                if (goLocationsTableRefs) db.goLocationsTable,
                if (goEventsTableRefs) db.goEventsTable,
                if (goRemindersTableRefs) db.goRemindersTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userOtpTableRefs)
                    await $_getPrefetchedData<UserTableData, $UserTableTable,
                            UserOtpTableData>(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._userOtpTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .userOtpTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (groupsTableRefs)
                    await $_getPrefetchedData<UserTableData, $UserTableTable,
                            GroupsTableData>(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._groupsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .groupsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.createdBy == item.id),
                        typedResults: items),
                  if (groupMembersTableRefs)
                    await $_getPrefetchedData<UserTableData, $UserTableTable,
                            GroupMembersTableData>(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._groupMembersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .groupMembersTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (goLocationsTableRefs)
                    await $_getPrefetchedData<UserTableData, $UserTableTable,
                            GoLocationsTableData>(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._goLocationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .goLocationsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.createdBy == item.id),
                        typedResults: items),
                  if (goEventsTableRefs)
                    await $_getPrefetchedData<UserTableData, $UserTableTable,
                            GoEventsTableData>(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._goEventsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .goEventsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.createdBy == item.id),
                        typedResults: items),
                  if (goRemindersTableRefs)
                    await $_getPrefetchedData<UserTableData, $UserTableTable,
                            GoRemindersTableData>(
                        currentTable: table,
                        referencedTable: $$UserTableTableReferences
                            ._goRemindersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UserTableTableReferences(db, table, p0)
                                .goRemindersTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UserTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $UserTableTable,
    UserTableData,
    $$UserTableTableFilterComposer,
    $$UserTableTableOrderingComposer,
    $$UserTableTableAnnotationComposer,
    $$UserTableTableCreateCompanionBuilder,
    $$UserTableTableUpdateCompanionBuilder,
    (UserTableData, $$UserTableTableReferences),
    UserTableData,
    PrefetchHooks Function(
        {bool userOtpTableRefs,
        bool groupsTableRefs,
        bool groupMembersTableRefs,
        bool goLocationsTableRefs,
        bool goEventsTableRefs,
        bool goRemindersTableRefs})>;
typedef $$UserOtpTableTableCreateCompanionBuilder = UserOtpTableCompanion
    Function({
  Value<String> id,
  required String userId,
  required String code,
  required UserOtpTypeEnum type,
  required DateTime expiresAt,
  Value<int> rowid,
});
typedef $$UserOtpTableTableUpdateCompanionBuilder = UserOtpTableCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> code,
  Value<UserOtpTypeEnum> type,
  Value<DateTime> expiresAt,
  Value<int> rowid,
});

final class $$UserOtpTableTableReferences
    extends BaseReferences<_$Database, $UserOtpTableTable, UserOtpTableData> {
  $$UserOtpTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTableTable _userIdTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.userOtpTable.userId, db.userTable.id));

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UserOtpTableTableFilterComposer
    extends Composer<_$Database, $UserOtpTableTable> {
  $$UserOtpTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<UserOtpTypeEnum, UserOtpTypeEnum, String>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserOtpTableTableOrderingComposer
    extends Composer<_$Database, $UserOtpTableTable> {
  $$UserOtpTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserOtpTableTableAnnotationComposer
    extends Composer<_$Database, $UserOtpTableTable> {
  $$UserOtpTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumnWithTypeConverter<UserOtpTypeEnum, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UserOtpTableTableTableManager extends RootTableManager<
    _$Database,
    $UserOtpTableTable,
    UserOtpTableData,
    $$UserOtpTableTableFilterComposer,
    $$UserOtpTableTableOrderingComposer,
    $$UserOtpTableTableAnnotationComposer,
    $$UserOtpTableTableCreateCompanionBuilder,
    $$UserOtpTableTableUpdateCompanionBuilder,
    (UserOtpTableData, $$UserOtpTableTableReferences),
    UserOtpTableData,
    PrefetchHooks Function({bool userId})> {
  $$UserOtpTableTableTableManager(_$Database db, $UserOtpTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserOtpTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserOtpTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserOtpTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<UserOtpTypeEnum> type = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserOtpTableCompanion(
            id: id,
            userId: userId,
            code: code,
            type: type,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String userId,
            required String code,
            required UserOtpTypeEnum type,
            required DateTime expiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserOtpTableCompanion.insert(
            id: id,
            userId: userId,
            code: code,
            type: type,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UserOtpTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$UserOtpTableTableReferences._userIdTable(db),
                    referencedColumn:
                        $$UserOtpTableTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$UserOtpTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $UserOtpTableTable,
    UserOtpTableData,
    $$UserOtpTableTableFilterComposer,
    $$UserOtpTableTableOrderingComposer,
    $$UserOtpTableTableAnnotationComposer,
    $$UserOtpTableTableCreateCompanionBuilder,
    $$UserOtpTableTableUpdateCompanionBuilder,
    (UserOtpTableData, $$UserOtpTableTableReferences),
    UserOtpTableData,
    PrefetchHooks Function({bool userId})>;
typedef $$GroupsTableTableCreateCompanionBuilder = GroupsTableCompanion
    Function({
  Value<String> id,
  required String name,
  Value<String?> description,
  Value<String?> imageUrl,
  required String createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$GroupsTableTableUpdateCompanionBuilder = GroupsTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> imageUrl,
  Value<String> createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$GroupsTableTableReferences
    extends BaseReferences<_$Database, $GroupsTableTable, GroupsTableData> {
  $$GroupsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTableTable _createdByTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.groupsTable.createdBy, db.userTable.id));

  $$UserTableTableProcessedTableManager get createdBy {
    final $_column = $_itemColumn<String>('created_by')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GroupMembersTableTable,
      List<GroupMembersTableData>> _groupMembersTableRefsTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.groupMembersTable,
          aliasName: $_aliasNameGenerator(
              db.groupsTable.id, db.groupMembersTable.groupId));

  $$GroupMembersTableTableProcessedTableManager get groupMembersTableRefs {
    final manager =
        $$GroupMembersTableTableTableManager($_db, $_db.groupMembersTable)
            .filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_groupMembersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GroupInvitesTableTable,
      List<GroupInvitesTableData>> _groupInvitesTableRefsTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.groupInvitesTable,
          aliasName: $_aliasNameGenerator(
              db.groupsTable.id, db.groupInvitesTable.groupId));

  $$GroupInvitesTableTableProcessedTableManager get groupInvitesTableRefs {
    final manager =
        $$GroupInvitesTableTableTableManager($_db, $_db.groupInvitesTable)
            .filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_groupInvitesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoEventsTableTable, List<GoEventsTableData>>
      _goEventsTableRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.goEventsTable,
              aliasName: $_aliasNameGenerator(
                  db.groupsTable.id, db.goEventsTable.groupId));

  $$GoEventsTableTableProcessedTableManager get goEventsTableRefs {
    final manager = $$GoEventsTableTableTableManager($_db, $_db.goEventsTable)
        .filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goEventsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GroupsTableTableFilterComposer
    extends Composer<_$Database, $GroupsTableTable> {
  $$GroupsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$UserTableTableFilterComposer get createdBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> groupMembersTableRefs(
      Expression<bool> Function($$GroupMembersTableTableFilterComposer f) f) {
    final $$GroupMembersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupMembersTable,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupMembersTableTableFilterComposer(
              $db: $db,
              $table: $db.groupMembersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> groupInvitesTableRefs(
      Expression<bool> Function($$GroupInvitesTableTableFilterComposer f) f) {
    final $$GroupInvitesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.groupInvitesTable,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupInvitesTableTableFilterComposer(
              $db: $db,
              $table: $db.groupInvitesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goEventsTableRefs(
      Expression<bool> Function($$GoEventsTableTableFilterComposer f) f) {
    final $$GoEventsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableFilterComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GroupsTableTableOrderingComposer
    extends Composer<_$Database, $GroupsTableTable> {
  $$GroupsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$UserTableTableOrderingComposer get createdBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupsTableTableAnnotationComposer
    extends Composer<_$Database, $GroupsTableTable> {
  $$GroupsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$UserTableTableAnnotationComposer get createdBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> groupMembersTableRefs<T extends Object>(
      Expression<T> Function($$GroupMembersTableTableAnnotationComposer a) f) {
    final $$GroupMembersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.groupMembersTable,
            getReferencedColumn: (t) => t.groupId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GroupMembersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.groupMembersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> groupInvitesTableRefs<T extends Object>(
      Expression<T> Function($$GroupInvitesTableTableAnnotationComposer a) f) {
    final $$GroupInvitesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.groupInvitesTable,
            getReferencedColumn: (t) => t.groupId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GroupInvitesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.groupInvitesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> goEventsTableRefs<T extends Object>(
      Expression<T> Function($$GoEventsTableTableAnnotationComposer a) f) {
    final $$GoEventsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.groupId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GroupsTableTableTableManager extends RootTableManager<
    _$Database,
    $GroupsTableTable,
    GroupsTableData,
    $$GroupsTableTableFilterComposer,
    $$GroupsTableTableOrderingComposer,
    $$GroupsTableTableAnnotationComposer,
    $$GroupsTableTableCreateCompanionBuilder,
    $$GroupsTableTableUpdateCompanionBuilder,
    (GroupsTableData, $$GroupsTableTableReferences),
    GroupsTableData,
    PrefetchHooks Function(
        {bool createdBy,
        bool groupMembersTableRefs,
        bool groupInvitesTableRefs,
        bool goEventsTableRefs})> {
  $$GroupsTableTableTableManager(_$Database db, $GroupsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<String> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupsTableCompanion(
            id: id,
            name: name,
            description: description,
            imageUrl: imageUrl,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            required String createdBy,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupsTableCompanion.insert(
            id: id,
            name: name,
            description: description,
            imageUrl: imageUrl,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GroupsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {createdBy = false,
              groupMembersTableRefs = false,
              groupInvitesTableRefs = false,
              goEventsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (groupMembersTableRefs) db.groupMembersTable,
                if (groupInvitesTableRefs) db.groupInvitesTable,
                if (goEventsTableRefs) db.goEventsTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (createdBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.createdBy,
                    referencedTable:
                        $$GroupsTableTableReferences._createdByTable(db),
                    referencedColumn:
                        $$GroupsTableTableReferences._createdByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (groupMembersTableRefs)
                    await $_getPrefetchedData<GroupsTableData,
                            $GroupsTableTable, GroupMembersTableData>(
                        currentTable: table,
                        referencedTable: $$GroupsTableTableReferences
                            ._groupMembersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupsTableTableReferences(db, table, p0)
                                .groupMembersTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items),
                  if (groupInvitesTableRefs)
                    await $_getPrefetchedData<GroupsTableData,
                            $GroupsTableTable, GroupInvitesTableData>(
                        currentTable: table,
                        referencedTable: $$GroupsTableTableReferences
                            ._groupInvitesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupsTableTableReferences(db, table, p0)
                                .groupInvitesTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items),
                  if (goEventsTableRefs)
                    await $_getPrefetchedData<GroupsTableData,
                            $GroupsTableTable, GoEventsTableData>(
                        currentTable: table,
                        referencedTable: $$GroupsTableTableReferences
                            ._goEventsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GroupsTableTableReferences(db, table, p0)
                                .goEventsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.groupId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GroupsTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GroupsTableTable,
    GroupsTableData,
    $$GroupsTableTableFilterComposer,
    $$GroupsTableTableOrderingComposer,
    $$GroupsTableTableAnnotationComposer,
    $$GroupsTableTableCreateCompanionBuilder,
    $$GroupsTableTableUpdateCompanionBuilder,
    (GroupsTableData, $$GroupsTableTableReferences),
    GroupsTableData,
    PrefetchHooks Function(
        {bool createdBy,
        bool groupMembersTableRefs,
        bool groupInvitesTableRefs,
        bool goEventsTableRefs})>;
typedef $$GroupMembersTableTableCreateCompanionBuilder
    = GroupMembersTableCompanion Function({
  Value<String> id,
  required String groupId,
  required String userId,
  required GroupMemberRoleEnum role,
  Value<DateTime> joinedAt,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$GroupMembersTableTableUpdateCompanionBuilder
    = GroupMembersTableCompanion Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> userId,
  Value<GroupMemberRoleEnum> role,
  Value<DateTime> joinedAt,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$GroupMembersTableTableReferences extends BaseReferences<
    _$Database, $GroupMembersTableTable, GroupMembersTableData> {
  $$GroupMembersTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTableTable _groupIdTable(_$Database db) =>
      db.groupsTable.createAlias($_aliasNameGenerator(
          db.groupMembersTable.groupId, db.groupsTable.id));

  $$GroupsTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$GroupsTableTableTableManager($_db, $_db.groupsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _userIdTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.groupMembersTable.userId, db.userTable.id));

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GroupMembersTableTableFilterComposer
    extends Composer<_$Database, $GroupMembersTableTable> {
  $$GroupMembersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<GroupMemberRoleEnum, GroupMemberRoleEnum,
          String>
      get role => $composableBuilder(
          column: $table.role,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
      column: $table.joinedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$GroupsTableTableFilterComposer get groupId {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableFilterComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupMembersTableTableOrderingComposer
    extends Composer<_$Database, $GroupMembersTableTable> {
  $$GroupMembersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
      column: $table.joinedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$GroupsTableTableOrderingComposer get groupId {
    final $$GroupsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableOrderingComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupMembersTableTableAnnotationComposer
    extends Composer<_$Database, $GroupMembersTableTable> {
  $$GroupMembersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GroupMemberRoleEnum, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$GroupsTableTableAnnotationComposer get groupId {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupMembersTableTableTableManager extends RootTableManager<
    _$Database,
    $GroupMembersTableTable,
    GroupMembersTableData,
    $$GroupMembersTableTableFilterComposer,
    $$GroupMembersTableTableOrderingComposer,
    $$GroupMembersTableTableAnnotationComposer,
    $$GroupMembersTableTableCreateCompanionBuilder,
    $$GroupMembersTableTableUpdateCompanionBuilder,
    (GroupMembersTableData, $$GroupMembersTableTableReferences),
    GroupMembersTableData,
    PrefetchHooks Function({bool groupId, bool userId})> {
  $$GroupMembersTableTableTableManager(
      _$Database db, $GroupMembersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupMembersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupMembersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupMembersTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<GroupMemberRoleEnum> role = const Value.absent(),
            Value<DateTime> joinedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupMembersTableCompanion(
            id: id,
            groupId: groupId,
            userId: userId,
            role: role,
            joinedAt: joinedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String groupId,
            required String userId,
            required GroupMemberRoleEnum role,
            Value<DateTime> joinedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupMembersTableCompanion.insert(
            id: id,
            groupId: groupId,
            userId: userId,
            role: role,
            joinedAt: joinedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GroupMembersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({groupId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$GroupMembersTableTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$GroupMembersTableTableReferences._groupIdTable(db).id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$GroupMembersTableTableReferences._userIdTable(db),
                    referencedColumn:
                        $$GroupMembersTableTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GroupMembersTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GroupMembersTableTable,
    GroupMembersTableData,
    $$GroupMembersTableTableFilterComposer,
    $$GroupMembersTableTableOrderingComposer,
    $$GroupMembersTableTableAnnotationComposer,
    $$GroupMembersTableTableCreateCompanionBuilder,
    $$GroupMembersTableTableUpdateCompanionBuilder,
    (GroupMembersTableData, $$GroupMembersTableTableReferences),
    GroupMembersTableData,
    PrefetchHooks Function({bool groupId, bool userId})>;
typedef $$GroupInvitesTableTableCreateCompanionBuilder
    = GroupInvitesTableCompanion Function({
  Value<String> id,
  required String groupId,
  required String invitedBy,
  required String invitedUserId,
  required InviteStatusEnum status,
  Value<DateTime> createdAt,
  required DateTime expiresAt,
  Value<int> rowid,
});
typedef $$GroupInvitesTableTableUpdateCompanionBuilder
    = GroupInvitesTableCompanion Function({
  Value<String> id,
  Value<String> groupId,
  Value<String> invitedBy,
  Value<String> invitedUserId,
  Value<InviteStatusEnum> status,
  Value<DateTime> createdAt,
  Value<DateTime> expiresAt,
  Value<int> rowid,
});

final class $$GroupInvitesTableTableReferences extends BaseReferences<
    _$Database, $GroupInvitesTableTable, GroupInvitesTableData> {
  $$GroupInvitesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GroupsTableTable _groupIdTable(_$Database db) =>
      db.groupsTable.createAlias($_aliasNameGenerator(
          db.groupInvitesTable.groupId, db.groupsTable.id));

  $$GroupsTableTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$GroupsTableTableTableManager($_db, $_db.groupsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _invitedByTable(_$Database db) =>
      db.userTable.createAlias($_aliasNameGenerator(
          db.groupInvitesTable.invitedBy, db.userTable.id));

  $$UserTableTableProcessedTableManager get invitedBy {
    final $_column = $_itemColumn<String>('invited_by')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invitedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _invitedUserIdTable(_$Database db) =>
      db.userTable.createAlias($_aliasNameGenerator(
          db.groupInvitesTable.invitedUserId, db.userTable.id));

  $$UserTableTableProcessedTableManager get invitedUserId {
    final $_column = $_itemColumn<String>('invited_user_id')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invitedUserIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GroupInvitesTableTableFilterComposer
    extends Composer<_$Database, $GroupInvitesTableTable> {
  $$GroupInvitesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<InviteStatusEnum, InviteStatusEnum, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnFilters(column));

  $$GroupsTableTableFilterComposer get groupId {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableFilterComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get invitedBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get invitedUserId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedUserId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupInvitesTableTableOrderingComposer
    extends Composer<_$Database, $GroupInvitesTableTable> {
  $$GroupInvitesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
      column: $table.expiresAt, builder: (column) => ColumnOrderings(column));

  $$GroupsTableTableOrderingComposer get groupId {
    final $$GroupsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableOrderingComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get invitedBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get invitedUserId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedUserId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupInvitesTableTableAnnotationComposer
    extends Composer<_$Database, $GroupInvitesTableTable> {
  $$GroupInvitesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InviteStatusEnum, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  $$GroupsTableTableAnnotationComposer get groupId {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get invitedBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get invitedUserId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedUserId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GroupInvitesTableTableTableManager extends RootTableManager<
    _$Database,
    $GroupInvitesTableTable,
    GroupInvitesTableData,
    $$GroupInvitesTableTableFilterComposer,
    $$GroupInvitesTableTableOrderingComposer,
    $$GroupInvitesTableTableAnnotationComposer,
    $$GroupInvitesTableTableCreateCompanionBuilder,
    $$GroupInvitesTableTableUpdateCompanionBuilder,
    (GroupInvitesTableData, $$GroupInvitesTableTableReferences),
    GroupInvitesTableData,
    PrefetchHooks Function(
        {bool groupId, bool invitedBy, bool invitedUserId})> {
  $$GroupInvitesTableTableTableManager(
      _$Database db, $GroupInvitesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupInvitesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupInvitesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupInvitesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> groupId = const Value.absent(),
            Value<String> invitedBy = const Value.absent(),
            Value<String> invitedUserId = const Value.absent(),
            Value<InviteStatusEnum> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> expiresAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupInvitesTableCompanion(
            id: id,
            groupId: groupId,
            invitedBy: invitedBy,
            invitedUserId: invitedUserId,
            status: status,
            createdAt: createdAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String groupId,
            required String invitedBy,
            required String invitedUserId,
            required InviteStatusEnum status,
            Value<DateTime> createdAt = const Value.absent(),
            required DateTime expiresAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              GroupInvitesTableCompanion.insert(
            id: id,
            groupId: groupId,
            invitedBy: invitedBy,
            invitedUserId: invitedUserId,
            status: status,
            createdAt: createdAt,
            expiresAt: expiresAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GroupInvitesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {groupId = false, invitedBy = false, invitedUserId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$GroupInvitesTableTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$GroupInvitesTableTableReferences._groupIdTable(db).id,
                  ) as T;
                }
                if (invitedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invitedBy,
                    referencedTable:
                        $$GroupInvitesTableTableReferences._invitedByTable(db),
                    referencedColumn: $$GroupInvitesTableTableReferences
                        ._invitedByTable(db)
                        .id,
                  ) as T;
                }
                if (invitedUserId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invitedUserId,
                    referencedTable: $$GroupInvitesTableTableReferences
                        ._invitedUserIdTable(db),
                    referencedColumn: $$GroupInvitesTableTableReferences
                        ._invitedUserIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GroupInvitesTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GroupInvitesTableTable,
    GroupInvitesTableData,
    $$GroupInvitesTableTableFilterComposer,
    $$GroupInvitesTableTableOrderingComposer,
    $$GroupInvitesTableTableAnnotationComposer,
    $$GroupInvitesTableTableCreateCompanionBuilder,
    $$GroupInvitesTableTableUpdateCompanionBuilder,
    (GroupInvitesTableData, $$GroupInvitesTableTableReferences),
    GroupInvitesTableData,
    PrefetchHooks Function({bool groupId, bool invitedBy, bool invitedUserId})>;
typedef $$GoLocationsTableTableCreateCompanionBuilder
    = GoLocationsTableCompanion Function({
  Value<String> id,
  required String name,
  Value<String?> address,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> googleMapsUrl,
  required String createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$GoLocationsTableTableUpdateCompanionBuilder
    = GoLocationsTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> address,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<String?> googleMapsUrl,
  Value<String> createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$GoLocationsTableTableReferences extends BaseReferences<_$Database,
    $GoLocationsTableTable, GoLocationsTableData> {
  $$GoLocationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $UserTableTable _createdByTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.goLocationsTable.createdBy, db.userTable.id));

  $$UserTableTableProcessedTableManager get createdBy {
    final $_column = $_itemColumn<String>('created_by')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GoEventsTableTable, List<GoEventsTableData>>
      _goEventsTableRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.goEventsTable,
              aliasName: $_aliasNameGenerator(
                  db.goLocationsTable.id, db.goEventsTable.locationId));

  $$GoEventsTableTableProcessedTableManager get goEventsTableRefs {
    final manager = $$GoEventsTableTableTableManager($_db, $_db.goEventsTable)
        .filter((f) => f.locationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goEventsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GoLocationsTableTableFilterComposer
    extends Composer<_$Database, $GoLocationsTableTable> {
  $$GoLocationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get googleMapsUrl => $composableBuilder(
      column: $table.googleMapsUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$UserTableTableFilterComposer get createdBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> goEventsTableRefs(
      Expression<bool> Function($$GoEventsTableTableFilterComposer f) f) {
    final $$GoEventsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.locationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableFilterComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoLocationsTableTableOrderingComposer
    extends Composer<_$Database, $GoLocationsTableTable> {
  $$GoLocationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get googleMapsUrl => $composableBuilder(
      column: $table.googleMapsUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$UserTableTableOrderingComposer get createdBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoLocationsTableTableAnnotationComposer
    extends Composer<_$Database, $GoLocationsTableTable> {
  $$GoLocationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get googleMapsUrl => $composableBuilder(
      column: $table.googleMapsUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$UserTableTableAnnotationComposer get createdBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> goEventsTableRefs<T extends Object>(
      Expression<T> Function($$GoEventsTableTableAnnotationComposer a) f) {
    final $$GoEventsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.locationId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoLocationsTableTableTableManager extends RootTableManager<
    _$Database,
    $GoLocationsTableTable,
    GoLocationsTableData,
    $$GoLocationsTableTableFilterComposer,
    $$GoLocationsTableTableOrderingComposer,
    $$GoLocationsTableTableAnnotationComposer,
    $$GoLocationsTableTableCreateCompanionBuilder,
    $$GoLocationsTableTableUpdateCompanionBuilder,
    (GoLocationsTableData, $$GoLocationsTableTableReferences),
    GoLocationsTableData,
    PrefetchHooks Function({bool createdBy, bool goEventsTableRefs})> {
  $$GoLocationsTableTableTableManager(
      _$Database db, $GoLocationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoLocationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoLocationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoLocationsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> googleMapsUrl = const Value.absent(),
            Value<String> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoLocationsTableCompanion(
            id: id,
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude,
            googleMapsUrl: googleMapsUrl,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String name,
            Value<String?> address = const Value.absent(),
            Value<double?> latitude = const Value.absent(),
            Value<double?> longitude = const Value.absent(),
            Value<String?> googleMapsUrl = const Value.absent(),
            required String createdBy,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoLocationsTableCompanion.insert(
            id: id,
            name: name,
            address: address,
            latitude: latitude,
            longitude: longitude,
            googleMapsUrl: googleMapsUrl,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GoLocationsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {createdBy = false, goEventsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (goEventsTableRefs) db.goEventsTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (createdBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.createdBy,
                    referencedTable:
                        $$GoLocationsTableTableReferences._createdByTable(db),
                    referencedColumn: $$GoLocationsTableTableReferences
                        ._createdByTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (goEventsTableRefs)
                    await $_getPrefetchedData<GoLocationsTableData,
                            $GoLocationsTableTable, GoEventsTableData>(
                        currentTable: table,
                        referencedTable: $$GoLocationsTableTableReferences
                            ._goEventsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoLocationsTableTableReferences(db, table, p0)
                                .goEventsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.locationId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GoLocationsTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GoLocationsTableTable,
    GoLocationsTableData,
    $$GoLocationsTableTableFilterComposer,
    $$GoLocationsTableTableOrderingComposer,
    $$GoLocationsTableTableAnnotationComposer,
    $$GoLocationsTableTableCreateCompanionBuilder,
    $$GoLocationsTableTableUpdateCompanionBuilder,
    (GoLocationsTableData, $$GoLocationsTableTableReferences),
    GoLocationsTableData,
    PrefetchHooks Function({bool createdBy, bool goEventsTableRefs})>;
typedef $$GoEventsTableTableCreateCompanionBuilder = GoEventsTableCompanion
    Function({
  Value<String> id,
  required String title,
  Value<String?> description,
  Value<String?> locationId,
  required DateTime startDate,
  Value<DateTime?> endDate,
  Value<String?> groupId,
  Value<String?> coverImageUrl,
  required String createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$GoEventsTableTableUpdateCompanionBuilder = GoEventsTableCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<String?> locationId,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<String?> groupId,
  Value<String?> coverImageUrl,
  Value<String> createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$GoEventsTableTableReferences
    extends BaseReferences<_$Database, $GoEventsTableTable, GoEventsTableData> {
  $$GoEventsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GoLocationsTableTable _locationIdTable(_$Database db) =>
      db.goLocationsTable.createAlias($_aliasNameGenerator(
          db.goEventsTable.locationId, db.goLocationsTable.id));

  $$GoLocationsTableTableProcessedTableManager? get locationId {
    final $_column = $_itemColumn<String>('location_id');
    if ($_column == null) return null;
    final manager =
        $$GoLocationsTableTableTableManager($_db, $_db.goLocationsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_locationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $GroupsTableTable _groupIdTable(_$Database db) =>
      db.groupsTable.createAlias(
          $_aliasNameGenerator(db.goEventsTable.groupId, db.groupsTable.id));

  $$GroupsTableTableProcessedTableManager? get groupId {
    final $_column = $_itemColumn<String>('group_id');
    if ($_column == null) return null;
    final manager = $$GroupsTableTableTableManager($_db, $_db.groupsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _createdByTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.goEventsTable.createdBy, db.userTable.id));

  $$UserTableTableProcessedTableManager get createdBy {
    final $_column = $_itemColumn<String>('created_by')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GoParticipantsTableTable,
      List<GoParticipantsTableData>> _goParticipantsTableRefsTable(
          _$Database db) =>
      MultiTypedResultKey.fromTable(db.goParticipantsTable,
          aliasName: $_aliasNameGenerator(
              db.goEventsTable.id, db.goParticipantsTable.eventId));

  $$GoParticipantsTableTableProcessedTableManager get goParticipantsTableRefs {
    final manager =
        $$GoParticipantsTableTableTableManager($_db, $_db.goParticipantsTable)
            .filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_goParticipantsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$GoTasksTableTable, List<GoTasksTableData>>
      _goTasksTableRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.goTasksTable,
              aliasName: $_aliasNameGenerator(
                  db.goEventsTable.id, db.goTasksTable.eventId));

  $$GoTasksTableTableProcessedTableManager get goTasksTableRefs {
    final manager = $$GoTasksTableTableTableManager($_db, $_db.goTasksTable)
        .filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goTasksTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GoEventsTableTableFilterComposer
    extends Composer<_$Database, $GoEventsTableTable> {
  $$GoEventsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get coverImageUrl => $composableBuilder(
      column: $table.coverImageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$GoLocationsTableTableFilterComposer get locationId {
    final $$GoLocationsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.goLocationsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoLocationsTableTableFilterComposer(
              $db: $db,
              $table: $db.goLocationsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupsTableTableFilterComposer get groupId {
    final $$GroupsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableFilterComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get createdBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> goParticipantsTableRefs(
      Expression<bool> Function($$GoParticipantsTableTableFilterComposer f) f) {
    final $$GoParticipantsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goParticipantsTable,
        getReferencedColumn: (t) => t.eventId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoParticipantsTableTableFilterComposer(
              $db: $db,
              $table: $db.goParticipantsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> goTasksTableRefs(
      Expression<bool> Function($$GoTasksTableTableFilterComposer f) f) {
    final $$GoTasksTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goTasksTable,
        getReferencedColumn: (t) => t.eventId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoTasksTableTableFilterComposer(
              $db: $db,
              $table: $db.goTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoEventsTableTableOrderingComposer
    extends Composer<_$Database, $GoEventsTableTable> {
  $$GoEventsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get coverImageUrl => $composableBuilder(
      column: $table.coverImageUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$GoLocationsTableTableOrderingComposer get locationId {
    final $$GoLocationsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.goLocationsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoLocationsTableTableOrderingComposer(
              $db: $db,
              $table: $db.goLocationsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupsTableTableOrderingComposer get groupId {
    final $$GroupsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableOrderingComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get createdBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoEventsTableTableAnnotationComposer
    extends Composer<_$Database, $GoEventsTableTable> {
  $$GoEventsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get coverImageUrl => $composableBuilder(
      column: $table.coverImageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$GoLocationsTableTableAnnotationComposer get locationId {
    final $$GoLocationsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.locationId,
        referencedTable: $db.goLocationsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoLocationsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goLocationsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$GroupsTableTableAnnotationComposer get groupId {
    final $$GroupsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.groupId,
        referencedTable: $db.groupsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GroupsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.groupsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get createdBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> goParticipantsTableRefs<T extends Object>(
      Expression<T> Function($$GoParticipantsTableTableAnnotationComposer a)
          f) {
    final $$GoParticipantsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.goParticipantsTable,
            getReferencedColumn: (t) => t.eventId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$GoParticipantsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.goParticipantsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> goTasksTableRefs<T extends Object>(
      Expression<T> Function($$GoTasksTableTableAnnotationComposer a) f) {
    final $$GoTasksTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goTasksTable,
        getReferencedColumn: (t) => t.eventId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoTasksTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoEventsTableTableTableManager extends RootTableManager<
    _$Database,
    $GoEventsTableTable,
    GoEventsTableData,
    $$GoEventsTableTableFilterComposer,
    $$GoEventsTableTableOrderingComposer,
    $$GoEventsTableTableAnnotationComposer,
    $$GoEventsTableTableCreateCompanionBuilder,
    $$GoEventsTableTableUpdateCompanionBuilder,
    (GoEventsTableData, $$GoEventsTableTableReferences),
    GoEventsTableData,
    PrefetchHooks Function(
        {bool locationId,
        bool groupId,
        bool createdBy,
        bool goParticipantsTableRefs,
        bool goTasksTableRefs})> {
  $$GoEventsTableTableTableManager(_$Database db, $GoEventsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoEventsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoEventsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoEventsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> locationId = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> groupId = const Value.absent(),
            Value<String?> coverImageUrl = const Value.absent(),
            Value<String> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoEventsTableCompanion(
            id: id,
            title: title,
            description: description,
            locationId: locationId,
            startDate: startDate,
            endDate: endDate,
            groupId: groupId,
            coverImageUrl: coverImageUrl,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            Value<String?> locationId = const Value.absent(),
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> groupId = const Value.absent(),
            Value<String?> coverImageUrl = const Value.absent(),
            required String createdBy,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoEventsTableCompanion.insert(
            id: id,
            title: title,
            description: description,
            locationId: locationId,
            startDate: startDate,
            endDate: endDate,
            groupId: groupId,
            coverImageUrl: coverImageUrl,
            createdBy: createdBy,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GoEventsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {locationId = false,
              groupId = false,
              createdBy = false,
              goParticipantsTableRefs = false,
              goTasksTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (goParticipantsTableRefs) db.goParticipantsTable,
                if (goTasksTableRefs) db.goTasksTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (locationId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.locationId,
                    referencedTable:
                        $$GoEventsTableTableReferences._locationIdTable(db),
                    referencedColumn:
                        $$GoEventsTableTableReferences._locationIdTable(db).id,
                  ) as T;
                }
                if (groupId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.groupId,
                    referencedTable:
                        $$GoEventsTableTableReferences._groupIdTable(db),
                    referencedColumn:
                        $$GoEventsTableTableReferences._groupIdTable(db).id,
                  ) as T;
                }
                if (createdBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.createdBy,
                    referencedTable:
                        $$GoEventsTableTableReferences._createdByTable(db),
                    referencedColumn:
                        $$GoEventsTableTableReferences._createdByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (goParticipantsTableRefs)
                    await $_getPrefetchedData<GoEventsTableData,
                            $GoEventsTableTable, GoParticipantsTableData>(
                        currentTable: table,
                        referencedTable: $$GoEventsTableTableReferences
                            ._goParticipantsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoEventsTableTableReferences(db, table, p0)
                                .goParticipantsTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.eventId == item.id),
                        typedResults: items),
                  if (goTasksTableRefs)
                    await $_getPrefetchedData<GoEventsTableData,
                            $GoEventsTableTable, GoTasksTableData>(
                        currentTable: table,
                        referencedTable: $$GoEventsTableTableReferences
                            ._goTasksTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoEventsTableTableReferences(db, table, p0)
                                .goTasksTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.eventId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GoEventsTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GoEventsTableTable,
    GoEventsTableData,
    $$GoEventsTableTableFilterComposer,
    $$GoEventsTableTableOrderingComposer,
    $$GoEventsTableTableAnnotationComposer,
    $$GoEventsTableTableCreateCompanionBuilder,
    $$GoEventsTableTableUpdateCompanionBuilder,
    (GoEventsTableData, $$GoEventsTableTableReferences),
    GoEventsTableData,
    PrefetchHooks Function(
        {bool locationId,
        bool groupId,
        bool createdBy,
        bool goParticipantsTableRefs,
        bool goTasksTableRefs})>;
typedef $$GoParticipantsTableTableCreateCompanionBuilder
    = GoParticipantsTableCompanion Function({
  Value<String> id,
  required String eventId,
  required String userId,
  required GoParticipantStatusEnum status,
  required String invitedBy,
  Value<DateTime> invitedAt,
  Value<DateTime?> respondedAt,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$GoParticipantsTableTableUpdateCompanionBuilder
    = GoParticipantsTableCompanion Function({
  Value<String> id,
  Value<String> eventId,
  Value<String> userId,
  Value<GoParticipantStatusEnum> status,
  Value<String> invitedBy,
  Value<DateTime> invitedAt,
  Value<DateTime?> respondedAt,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$GoParticipantsTableTableReferences extends BaseReferences<
    _$Database, $GoParticipantsTableTable, GoParticipantsTableData> {
  $$GoParticipantsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GoEventsTableTable _eventIdTable(_$Database db) =>
      db.goEventsTable.createAlias($_aliasNameGenerator(
          db.goParticipantsTable.eventId, db.goEventsTable.id));

  $$GoEventsTableTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$GoEventsTableTableTableManager($_db, $_db.goEventsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _userIdTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.goParticipantsTable.userId, db.userTable.id));

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _invitedByTable(_$Database db) =>
      db.userTable.createAlias($_aliasNameGenerator(
          db.goParticipantsTable.invitedBy, db.userTable.id));

  $$UserTableTableProcessedTableManager get invitedBy {
    final $_column = $_itemColumn<String>('invited_by')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invitedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GoParticipantsTableTableFilterComposer
    extends Composer<_$Database, $GoParticipantsTableTable> {
  $$GoParticipantsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<GoParticipantStatusEnum,
          GoParticipantStatusEnum, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get invitedAt => $composableBuilder(
      column: $table.invitedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get respondedAt => $composableBuilder(
      column: $table.respondedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$GoEventsTableTableFilterComposer get eventId {
    final $$GoEventsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableFilterComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get invitedBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoParticipantsTableTableOrderingComposer
    extends Composer<_$Database, $GoParticipantsTableTable> {
  $$GoParticipantsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get invitedAt => $composableBuilder(
      column: $table.invitedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get respondedAt => $composableBuilder(
      column: $table.respondedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$GoEventsTableTableOrderingComposer get eventId {
    final $$GoEventsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableOrderingComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get invitedBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoParticipantsTableTableAnnotationComposer
    extends Composer<_$Database, $GoParticipantsTableTable> {
  $$GoParticipantsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoParticipantStatusEnum, String>
      get status => $composableBuilder(
          column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get invitedAt =>
      $composableBuilder(column: $table.invitedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get respondedAt => $composableBuilder(
      column: $table.respondedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$GoEventsTableTableAnnotationComposer get eventId {
    final $$GoEventsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get invitedBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.invitedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoParticipantsTableTableTableManager extends RootTableManager<
    _$Database,
    $GoParticipantsTableTable,
    GoParticipantsTableData,
    $$GoParticipantsTableTableFilterComposer,
    $$GoParticipantsTableTableOrderingComposer,
    $$GoParticipantsTableTableAnnotationComposer,
    $$GoParticipantsTableTableCreateCompanionBuilder,
    $$GoParticipantsTableTableUpdateCompanionBuilder,
    (GoParticipantsTableData, $$GoParticipantsTableTableReferences),
    GoParticipantsTableData,
    PrefetchHooks Function({bool eventId, bool userId, bool invitedBy})> {
  $$GoParticipantsTableTableTableManager(
      _$Database db, $GoParticipantsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoParticipantsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoParticipantsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoParticipantsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> eventId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<GoParticipantStatusEnum> status = const Value.absent(),
            Value<String> invitedBy = const Value.absent(),
            Value<DateTime> invitedAt = const Value.absent(),
            Value<DateTime?> respondedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoParticipantsTableCompanion(
            id: id,
            eventId: eventId,
            userId: userId,
            status: status,
            invitedBy: invitedBy,
            invitedAt: invitedAt,
            respondedAt: respondedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String eventId,
            required String userId,
            required GoParticipantStatusEnum status,
            required String invitedBy,
            Value<DateTime> invitedAt = const Value.absent(),
            Value<DateTime?> respondedAt = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoParticipantsTableCompanion.insert(
            id: id,
            eventId: eventId,
            userId: userId,
            status: status,
            invitedBy: invitedBy,
            invitedAt: invitedAt,
            respondedAt: respondedAt,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GoParticipantsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {eventId = false, userId = false, invitedBy = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (eventId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.eventId,
                    referencedTable:
                        $$GoParticipantsTableTableReferences._eventIdTable(db),
                    referencedColumn: $$GoParticipantsTableTableReferences
                        ._eventIdTable(db)
                        .id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$GoParticipantsTableTableReferences._userIdTable(db),
                    referencedColumn: $$GoParticipantsTableTableReferences
                        ._userIdTable(db)
                        .id,
                  ) as T;
                }
                if (invitedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.invitedBy,
                    referencedTable: $$GoParticipantsTableTableReferences
                        ._invitedByTable(db),
                    referencedColumn: $$GoParticipantsTableTableReferences
                        ._invitedByTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GoParticipantsTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GoParticipantsTableTable,
    GoParticipantsTableData,
    $$GoParticipantsTableTableFilterComposer,
    $$GoParticipantsTableTableOrderingComposer,
    $$GoParticipantsTableTableAnnotationComposer,
    $$GoParticipantsTableTableCreateCompanionBuilder,
    $$GoParticipantsTableTableUpdateCompanionBuilder,
    (GoParticipantsTableData, $$GoParticipantsTableTableReferences),
    GoParticipantsTableData,
    PrefetchHooks Function({bool eventId, bool userId, bool invitedBy})>;
typedef $$GoTasksTableTableCreateCompanionBuilder = GoTasksTableCompanion
    Function({
  Value<String> id,
  required String eventId,
  required String title,
  Value<String?> description,
  Value<DateTime?> deadline,
  required String createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
  Value<DateTime?> updatedAt,
  Value<bool> isDone,
  Value<bool> isPrivate,
  Value<String?> completedBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});
typedef $$GoTasksTableTableUpdateCompanionBuilder = GoTasksTableCompanion
    Function({
  Value<String> id,
  Value<String> eventId,
  Value<String> title,
  Value<String?> description,
  Value<DateTime?> deadline,
  Value<String> createdBy,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
  Value<DateTime?> updatedAt,
  Value<bool> isDone,
  Value<bool> isPrivate,
  Value<String?> completedBy,
  Value<String?> updatedBy,
  Value<int> rowid,
});

final class $$GoTasksTableTableReferences
    extends BaseReferences<_$Database, $GoTasksTableTable, GoTasksTableData> {
  $$GoTasksTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoEventsTableTable _eventIdTable(_$Database db) =>
      db.goEventsTable.createAlias(
          $_aliasNameGenerator(db.goTasksTable.eventId, db.goEventsTable.id));

  $$GoEventsTableTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$GoEventsTableTableTableManager($_db, $_db.goEventsTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _createdByTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.goTasksTable.createdBy, db.userTable.id));

  $$UserTableTableProcessedTableManager get createdBy {
    final $_column = $_itemColumn<String>('created_by')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_createdByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _completedByTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.goTasksTable.completedBy, db.userTable.id));

  $$UserTableTableProcessedTableManager? get completedBy {
    final $_column = $_itemColumn<String>('completed_by');
    if ($_column == null) return null;
    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_completedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _updatedByTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.goTasksTable.updatedBy, db.userTable.id));

  $$UserTableTableProcessedTableManager? get updatedBy {
    final $_column = $_itemColumn<String>('updated_by');
    if ($_column == null) return null;
    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_updatedByTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$GoRemindersTableTable, List<GoRemindersTableData>>
      _goRemindersTableRefsTable(_$Database db) =>
          MultiTypedResultKey.fromTable(db.goRemindersTable,
              aliasName: $_aliasNameGenerator(
                  db.goTasksTable.id, db.goRemindersTable.taskId));

  $$GoRemindersTableTableProcessedTableManager get goRemindersTableRefs {
    final manager =
        $$GoRemindersTableTableTableManager($_db, $_db.goRemindersTable)
            .filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_goRemindersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$GoTasksTableTableFilterComposer
    extends Composer<_$Database, $GoTasksTableTable> {
  $$GoTasksTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnFilters(column));

  $$GoEventsTableTableFilterComposer get eventId {
    final $$GoEventsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableFilterComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get createdBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get completedBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.completedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get updatedBy {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.updatedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> goRemindersTableRefs(
      Expression<bool> Function($$GoRemindersTableTableFilterComposer f) f) {
    final $$GoRemindersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goRemindersTable,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoRemindersTableTableFilterComposer(
              $db: $db,
              $table: $db.goRemindersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoTasksTableTableOrderingComposer
    extends Composer<_$Database, $GoTasksTableTable> {
  $$GoTasksTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDone => $composableBuilder(
      column: $table.isDone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
      column: $table.isPrivate, builder: (column) => ColumnOrderings(column));

  $$GoEventsTableTableOrderingComposer get eventId {
    final $$GoEventsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableOrderingComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get createdBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get completedBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.completedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get updatedBy {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.updatedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoTasksTableTableAnnotationComposer
    extends Composer<_$Database, $GoTasksTableTable> {
  $$GoTasksTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  $$GoEventsTableTableAnnotationComposer get eventId {
    final $$GoEventsTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.goEventsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoEventsTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get createdBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.createdBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get completedBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.completedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get updatedBy {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.updatedBy,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> goRemindersTableRefs<T extends Object>(
      Expression<T> Function($$GoRemindersTableTableAnnotationComposer a) f) {
    final $$GoRemindersTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.goRemindersTable,
        getReferencedColumn: (t) => t.taskId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoRemindersTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goRemindersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$GoTasksTableTableTableManager extends RootTableManager<
    _$Database,
    $GoTasksTableTable,
    GoTasksTableData,
    $$GoTasksTableTableFilterComposer,
    $$GoTasksTableTableOrderingComposer,
    $$GoTasksTableTableAnnotationComposer,
    $$GoTasksTableTableCreateCompanionBuilder,
    $$GoTasksTableTableUpdateCompanionBuilder,
    (GoTasksTableData, $$GoTasksTableTableReferences),
    GoTasksTableData,
    PrefetchHooks Function(
        {bool eventId,
        bool createdBy,
        bool completedBy,
        bool updatedBy,
        bool goRemindersTableRefs})> {
  $$GoTasksTableTableTableManager(_$Database db, $GoTasksTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoTasksTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoTasksTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoTasksTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> eventId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String> createdBy = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<bool> isPrivate = const Value.absent(),
            Value<String?> completedBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoTasksTableCompanion(
            id: id,
            eventId: eventId,
            title: title,
            description: description,
            deadline: deadline,
            createdBy: createdBy,
            createdAt: createdAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            isDone: isDone,
            isPrivate: isPrivate,
            completedBy: completedBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String eventId,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            required String createdBy,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isDone = const Value.absent(),
            Value<bool> isPrivate = const Value.absent(),
            Value<String?> completedBy = const Value.absent(),
            Value<String?> updatedBy = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoTasksTableCompanion.insert(
            id: id,
            eventId: eventId,
            title: title,
            description: description,
            deadline: deadline,
            createdBy: createdBy,
            createdAt: createdAt,
            completedAt: completedAt,
            updatedAt: updatedAt,
            isDone: isDone,
            isPrivate: isPrivate,
            completedBy: completedBy,
            updatedBy: updatedBy,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GoTasksTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {eventId = false,
              createdBy = false,
              completedBy = false,
              updatedBy = false,
              goRemindersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (goRemindersTableRefs) db.goRemindersTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (eventId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.eventId,
                    referencedTable:
                        $$GoTasksTableTableReferences._eventIdTable(db),
                    referencedColumn:
                        $$GoTasksTableTableReferences._eventIdTable(db).id,
                  ) as T;
                }
                if (createdBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.createdBy,
                    referencedTable:
                        $$GoTasksTableTableReferences._createdByTable(db),
                    referencedColumn:
                        $$GoTasksTableTableReferences._createdByTable(db).id,
                  ) as T;
                }
                if (completedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.completedBy,
                    referencedTable:
                        $$GoTasksTableTableReferences._completedByTable(db),
                    referencedColumn:
                        $$GoTasksTableTableReferences._completedByTable(db).id,
                  ) as T;
                }
                if (updatedBy) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.updatedBy,
                    referencedTable:
                        $$GoTasksTableTableReferences._updatedByTable(db),
                    referencedColumn:
                        $$GoTasksTableTableReferences._updatedByTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (goRemindersTableRefs)
                    await $_getPrefetchedData<GoTasksTableData,
                            $GoTasksTableTable, GoRemindersTableData>(
                        currentTable: table,
                        referencedTable: $$GoTasksTableTableReferences
                            ._goRemindersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$GoTasksTableTableReferences(db, table, p0)
                                .goRemindersTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.taskId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$GoTasksTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GoTasksTableTable,
    GoTasksTableData,
    $$GoTasksTableTableFilterComposer,
    $$GoTasksTableTableOrderingComposer,
    $$GoTasksTableTableAnnotationComposer,
    $$GoTasksTableTableCreateCompanionBuilder,
    $$GoTasksTableTableUpdateCompanionBuilder,
    (GoTasksTableData, $$GoTasksTableTableReferences),
    GoTasksTableData,
    PrefetchHooks Function(
        {bool eventId,
        bool createdBy,
        bool completedBy,
        bool updatedBy,
        bool goRemindersTableRefs})>;
typedef $$GoRemindersTableTableCreateCompanionBuilder
    = GoRemindersTableCompanion Function({
  Value<String> id,
  required String taskId,
  required String userId,
  required GoReminderType reminderType,
  Value<DateTime?> remindAt,
  Value<int?> minutesBefore,
  Value<bool> isSent,
  Value<DateTime?> sentAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$GoRemindersTableTableUpdateCompanionBuilder
    = GoRemindersTableCompanion Function({
  Value<String> id,
  Value<String> taskId,
  Value<String> userId,
  Value<GoReminderType> reminderType,
  Value<DateTime?> remindAt,
  Value<int?> minutesBefore,
  Value<bool> isSent,
  Value<DateTime?> sentAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$GoRemindersTableTableReferences extends BaseReferences<_$Database,
    $GoRemindersTableTable, GoRemindersTableData> {
  $$GoRemindersTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $GoTasksTableTable _taskIdTable(_$Database db) =>
      db.goTasksTable.createAlias(
          $_aliasNameGenerator(db.goRemindersTable.taskId, db.goTasksTable.id));

  $$GoTasksTableTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager = $$GoTasksTableTableTableManager($_db, $_db.goTasksTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UserTableTable _userIdTable(_$Database db) =>
      db.userTable.createAlias(
          $_aliasNameGenerator(db.goRemindersTable.userId, db.userTable.id));

  $$UserTableTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UserTableTableTableManager($_db, $_db.userTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$GoRemindersTableTableFilterComposer
    extends Composer<_$Database, $GoRemindersTableTable> {
  $$GoRemindersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<GoReminderType, GoReminderType, String>
      get reminderType => $composableBuilder(
          column: $table.reminderType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get remindAt => $composableBuilder(
      column: $table.remindAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minutesBefore => $composableBuilder(
      column: $table.minutesBefore, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSent => $composableBuilder(
      column: $table.isSent, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
      column: $table.sentAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$GoTasksTableTableFilterComposer get taskId {
    final $$GoTasksTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.goTasksTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoTasksTableTableFilterComposer(
              $db: $db,
              $table: $db.goTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableFilterComposer get userId {
    final $$UserTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableFilterComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoRemindersTableTableOrderingComposer
    extends Composer<_$Database, $GoRemindersTableTable> {
  $$GoRemindersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminderType => $composableBuilder(
      column: $table.reminderType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get remindAt => $composableBuilder(
      column: $table.remindAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minutesBefore => $composableBuilder(
      column: $table.minutesBefore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSent => $composableBuilder(
      column: $table.isSent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
      column: $table.sentAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$GoTasksTableTableOrderingComposer get taskId {
    final $$GoTasksTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.goTasksTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoTasksTableTableOrderingComposer(
              $db: $db,
              $table: $db.goTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableOrderingComposer get userId {
    final $$UserTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableOrderingComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoRemindersTableTableAnnotationComposer
    extends Composer<_$Database, $GoRemindersTableTable> {
  $$GoRemindersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoReminderType, String> get reminderType =>
      $composableBuilder(
          column: $table.reminderType, builder: (column) => column);

  GeneratedColumn<DateTime> get remindAt =>
      $composableBuilder(column: $table.remindAt, builder: (column) => column);

  GeneratedColumn<int> get minutesBefore => $composableBuilder(
      column: $table.minutesBefore, builder: (column) => column);

  GeneratedColumn<bool> get isSent =>
      $composableBuilder(column: $table.isSent, builder: (column) => column);

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GoTasksTableTableAnnotationComposer get taskId {
    final $$GoTasksTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.taskId,
        referencedTable: $db.goTasksTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$GoTasksTableTableAnnotationComposer(
              $db: $db,
              $table: $db.goTasksTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UserTableTableAnnotationComposer get userId {
    final $$UserTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.userTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UserTableTableAnnotationComposer(
              $db: $db,
              $table: $db.userTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$GoRemindersTableTableTableManager extends RootTableManager<
    _$Database,
    $GoRemindersTableTable,
    GoRemindersTableData,
    $$GoRemindersTableTableFilterComposer,
    $$GoRemindersTableTableOrderingComposer,
    $$GoRemindersTableTableAnnotationComposer,
    $$GoRemindersTableTableCreateCompanionBuilder,
    $$GoRemindersTableTableUpdateCompanionBuilder,
    (GoRemindersTableData, $$GoRemindersTableTableReferences),
    GoRemindersTableData,
    PrefetchHooks Function({bool taskId, bool userId})> {
  $$GoRemindersTableTableTableManager(
      _$Database db, $GoRemindersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoRemindersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoRemindersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoRemindersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> taskId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<GoReminderType> reminderType = const Value.absent(),
            Value<DateTime?> remindAt = const Value.absent(),
            Value<int?> minutesBefore = const Value.absent(),
            Value<bool> isSent = const Value.absent(),
            Value<DateTime?> sentAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoRemindersTableCompanion(
            id: id,
            taskId: taskId,
            userId: userId,
            reminderType: reminderType,
            remindAt: remindAt,
            minutesBefore: minutesBefore,
            isSent: isSent,
            sentAt: sentAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String> id = const Value.absent(),
            required String taskId,
            required String userId,
            required GoReminderType reminderType,
            Value<DateTime?> remindAt = const Value.absent(),
            Value<int?> minutesBefore = const Value.absent(),
            Value<bool> isSent = const Value.absent(),
            Value<DateTime?> sentAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GoRemindersTableCompanion.insert(
            id: id,
            taskId: taskId,
            userId: userId,
            reminderType: reminderType,
            remindAt: remindAt,
            minutesBefore: minutesBefore,
            isSent: isSent,
            sentAt: sentAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$GoRemindersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({taskId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (taskId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.taskId,
                    referencedTable:
                        $$GoRemindersTableTableReferences._taskIdTable(db),
                    referencedColumn:
                        $$GoRemindersTableTableReferences._taskIdTable(db).id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$GoRemindersTableTableReferences._userIdTable(db),
                    referencedColumn:
                        $$GoRemindersTableTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$GoRemindersTableTableProcessedTableManager = ProcessedTableManager<
    _$Database,
    $GoRemindersTableTable,
    GoRemindersTableData,
    $$GoRemindersTableTableFilterComposer,
    $$GoRemindersTableTableOrderingComposer,
    $$GoRemindersTableTableAnnotationComposer,
    $$GoRemindersTableTableCreateCompanionBuilder,
    $$GoRemindersTableTableUpdateCompanionBuilder,
    (GoRemindersTableData, $$GoRemindersTableTableReferences),
    GoRemindersTableData,
    PrefetchHooks Function({bool taskId, bool userId})>;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$UserTableTableTableManager get userTable =>
      $$UserTableTableTableManager(_db, _db.userTable);
  $$UserOtpTableTableTableManager get userOtpTable =>
      $$UserOtpTableTableTableManager(_db, _db.userOtpTable);
  $$GroupsTableTableTableManager get groupsTable =>
      $$GroupsTableTableTableManager(_db, _db.groupsTable);
  $$GroupMembersTableTableTableManager get groupMembersTable =>
      $$GroupMembersTableTableTableManager(_db, _db.groupMembersTable);
  $$GroupInvitesTableTableTableManager get groupInvitesTable =>
      $$GroupInvitesTableTableTableManager(_db, _db.groupInvitesTable);
  $$GoLocationsTableTableTableManager get goLocationsTable =>
      $$GoLocationsTableTableTableManager(_db, _db.goLocationsTable);
  $$GoEventsTableTableTableManager get goEventsTable =>
      $$GoEventsTableTableTableManager(_db, _db.goEventsTable);
  $$GoParticipantsTableTableTableManager get goParticipantsTable =>
      $$GoParticipantsTableTableTableManager(_db, _db.goParticipantsTable);
  $$GoTasksTableTableTableManager get goTasksTable =>
      $$GoTasksTableTableTableManager(_db, _db.goTasksTable);
  $$GoRemindersTableTableTableManager get goRemindersTable =>
      $$GoRemindersTableTableTableManager(_db, _db.goRemindersTable);
}
