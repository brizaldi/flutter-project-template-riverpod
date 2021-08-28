part of 'sign_out_notifier.dart';

@freezed
class SignOutState with _$SignOutState {
  const factory SignOutState.initial() = _Initial;
  const factory SignOutState.inProgress() = _InProgress;
  const factory SignOutState.success() = _Success;
  const factory SignOutState.failure(AuthFailure failure) = _Failure;
}
