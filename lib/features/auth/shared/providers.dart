import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/shared/providers.dart';
import '../application/auth/auth_notifier.dart';
import '../application/sign_in_form/sign_in_form_notifier.dart';
import '../application/sign_out/sign_out_notifier.dart';
import '../infrastructure/auth_interceptor.dart';
import '../infrastructure/auth_remote_service.dart';
import '../infrastructure/auth_repository.dart';
import '../infrastructure/credentials_storage/credentials_storage.dart';
import '../infrastructure/credentials_storage/secure_credentials_storage.dart';

final flutterSecureStorageProvider = Provider(
  (ref) => const FlutterSecureStorage(),
);

final credentialsStorageProvider = Provider<CredentialsStorage>(
  (ref) => SecureCredentialsStorage(ref.watch(flutterSecureStorageProvider)),
);

final authRemoteServiceProvider = Provider(
  (ref) => AuthRemoteService(ref.watch(dioProvider)),
);

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    ref.watch(credentialsStorageProvider),
    ref.watch(authRemoteServiceProvider),
  ),
);

final authInterceptorProvider = Provider(
  (ref) => AuthInterceptor(ref.watch(authRepositoryProvider)),
);

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref.watch(authRepositoryProvider)),
);

final signInFormNotifierProvider =
    StateNotifierProvider.autoDispose<SignInFormNotifier, SignInFormState>(
  (ref) => SignInFormNotifier(ref.watch(authRepositoryProvider)),
);

final signOutNotifierProvider =
    StateNotifierProvider<SignOutNotifier, SignOutState>(
  (ref) => SignOutNotifier(ref.watch(authRepositoryProvider)),
);
