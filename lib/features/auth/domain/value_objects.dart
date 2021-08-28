import 'package:dartz/dartz.dart';

import '../../core/domain/failures.dart';
import '../../core/domain/value_objects.dart';
import '../../core/domain/value_validators.dart';

class Email extends ValueObject<String> {
  factory Email(String input) {
    return Email._(
      validateEmail(input),
    );
  }

  const Email._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class Password extends ValueObject<String> {
  factory Password(String input) {
    return Password._(
      validatePassword(input),
    );
  }

  const Password._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}

class UserToken extends ValueObject<String> {
  factory UserToken(String input) {
    return UserToken._(
      validateStringNotEmpty(input),
    );
  }

  const UserToken._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
