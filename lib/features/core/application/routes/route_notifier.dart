import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../auth/application/auth/auth_notifier.dart';
import '../../../auth/presentation/sign_in_page.dart';
import '../../../auth/shared/providers.dart';
import '../../../home/core/presentation/home_page.dart';
import '../../../home/counter/presentation/counter_page.dart';
import '../../../splash/presentation/splash_page.dart';
import 'route_names.dart';

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authNotifierProvider,
      (_, __) => notifyListeners(),
    );
  }

  final Ref _ref;

  String? redirectLogic(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authNotifierProvider);

    final areWeSigningIn = state.location == RouteNames.signInRoute;

    return authState.maybeMap(
      authenticated: (_) => areWeSigningIn ? RouteNames.homeRoute : null,
      orElse: () => areWeSigningIn ? null : RouteNames.signInRoute,
    );
  }

  List<GoRoute> get routes {
    return [
      GoRoute(
        name: RouteNames.defaultNameRoute,
        path: RouteNames.defaultRoute,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: RouteNames.signInNameRoute,
        path: RouteNames.signInRoute,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        name: RouteNames.homeNameRoute,
        path: RouteNames.homeRoute,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            name: RouteNames.counterNameRoute,
            path: RouteNames.counterRoute,
            builder: (context, state) => const CounterPage(),
          ),
        ],
      ),
    ];
  }
}
