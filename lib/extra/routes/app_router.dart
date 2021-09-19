import 'package:auto_route/auto_route.dart';

import '../../features/auth/presentation/sign_in_page.dart';
import '../../features/home/core/presentation/home_page.dart';
import '../../features/home/counter/presentation/counter_page.dart';
import '../../features/splash/presentation/splash_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute<dynamic>(page: SplashPage, initial: true),
    AutoRoute<dynamic>(
      name: 'HomeRouter',
      page: EmptyRouterPage,
      children: <AutoRoute<dynamic>>[
        AutoRoute<dynamic>(path: '', page: HomePage),
        AutoRoute<dynamic>(path: 'counter', page: CounterPage),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    AutoRoute<dynamic>(page: SignInPage),
  ],
)
class $AppRouter {}
