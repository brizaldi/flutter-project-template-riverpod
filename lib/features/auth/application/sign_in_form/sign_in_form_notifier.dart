import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/auth_failure.dart';
import '../../domain/value_objects.dart';
import '../../infrastructure/auth_repository.dart';

part 'sign_in_form_notifier.freezed.dart';
part 'sign_in_form_state.dart';

class SignInFormNotifier extends StateNotifier<SignInFormState> {
  SignInFormNotifier(this._repository) : super(SignInFormState.initial());

  final AuthRepository _repository;

  void changeEmail(String emailStr) {
    state = state.copyWith(
      email: Email(emailStr),
      failureOrSuccessOption: none(),
    );
  }

  void changePassword(String passwordStr) {
    state = state.copyWith(
      password: Password(passwordStr),
      failureOrSuccessOption: none(),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    Either<AuthFailure, Unit>? signInFailureOrSuccess;

    final isEmailValid = state.email.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      state = state.copyWith(
        isSubmitting: true,
        failureOrSuccessOption: none(),
      );

      signInFailureOrSuccess = await _repository.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
    }

    state = state.copyWith(
      isSubmitting: false,
      showErrorMessages: true,
      failureOrSuccessOption: optionOf(signInFailureOrSuccess),
    );
  }
}
