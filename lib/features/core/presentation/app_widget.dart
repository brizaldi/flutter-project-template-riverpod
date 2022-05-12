import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../extra/config/configuration.dart';
import '../../../extra/routes/app_router.gr.dart';
import '../../../extra/style/style.dart';
import '../../auth/application/auth/auth_notifier.dart';
import '../../auth/shared/providers.dart';
import '../shared/providers.dart';
import 'widgets/alert_helper.dart';

final initializationProvider = FutureProvider<Unit>((ref) async {
  await ref.read(hiveProvider).init();
  ref.read(dioProvider)
    ..options = BaseOptions(
      connectTimeout: BuildConfig.get().connectTimeout,
      receiveTimeout: BuildConfig.get().receiveTimeout,
      validateStatus: (status) {
        return true;
      },
      baseUrl: BuildConfig.get().baseUrl,
    )
    ..interceptors.add(ref.read(authInterceptorProvider));

  if (BuildConfig.get().flavor != Flavor.release) {
    ref.read(dioProvider).interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ));
  }

  final authNotifier = ref.read(authNotifierProvider.notifier);
  await authNotifier.checkAndUpdateAuthStatus();

  return unit;
});

class AppWidget extends HookConsumerWidget {
  AppWidget({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(initializationProvider, (_, __) {})
      ..listen<AuthState>(authNotifierProvider, (_, state) {
        state.maybeMap(
          orElse: () {},
          authenticated: (_) => _appRouter.pushAndPopUntil(
            const HomeRouter(),
            predicate: (route) => false,
          ),
          unauthenticated: (_) => _appRouter.pushAndPopUntil(
            const SignInRoute(),
            predicate: (route) => false,
          ),
          failure: (failure) {
            AlertHelper.showSnackBar(
              context,
              message: AppLocalizations.of(context)!.signInStatusError,
            );
          },
        );
      });

    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: Themes.lightTheme(context),
      darkTheme: Themes.darkTheme(context),
      themeMode: ThemeMode.light,
    );
  }
}
