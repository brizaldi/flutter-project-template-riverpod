import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/domain/value_objects.dart';
import 'value_objects.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required UniqueId id,
    required Email email,
    required UserToken userToken,
  }) = _User;
}
