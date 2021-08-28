import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/shared/providers.dart';
import '../application/auth/auth_notifier.dart';
import '../application/sign_in_form/sign_in_form_notifier.dart';
import '../application/sign_out/sign_out_notifier.dart';
import '../infrastructure/auth_interceptor.dart';
import '../infrastructure/auth_local_service.dart';
import '../infrastructure/auth_remote_service.dart';
import '../infrastructure/auth_repository.dart';

final authLocalServiceProvider = Provider<AuthLocalService>(
  (ref) => AuthLocalService(ref.watch(hiveProvider)),
);

final authRemoteServiceProvider = Provider(
  (ref) => AuthRemoteService(ref.watch(dioProvider)),
);

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    ref.watch(authLocalServiceProvider),
    ref.watch(authRemoteServiceProvider),
  ),
);

final authInterceptorProvider = Provider(
  (ref) => AuthInterceptor(ref.watch(authLocalServiceProvider)),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);

final signInFormNotifierProvider =
    StateNotifierProvider<SignInFormNotifier, SignInFormState>(
  (ref) => SignInFormNotifier(ref.watch(authRepositoryProvider)),
);

final signOutNotifierProvider =
    StateNotifierProvider<SignOutNotifier, SignOutState>(
  (ref) => SignOutNotifier(ref.watch(authRepositoryProvider)),
);
