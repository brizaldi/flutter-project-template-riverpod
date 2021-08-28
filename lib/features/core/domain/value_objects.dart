import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'errors.dart';
import 'failures.dart';
import 'value_validators.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  Either<ValueFailure<dynamic>, Unit> get failureOrUnit {
    return value.fold(
      left,
      (r) => right(unit),
    );
  }

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

class UniqueId extends ValueObject<String> {
  factory UniqueId(String uniqueId) {
    return UniqueId._(
      validateStringNotEmpty(uniqueId),
    );
  }

  factory UniqueId.fromInteger(int uniqueId) {
    return UniqueId._(
      right(uniqueId.toString()),
    );
  }

  factory UniqueId.empty() => UniqueId('-');

  const UniqueId._(this.value);

  @override
  final Either<ValueFailure<String>, String> value;
}
