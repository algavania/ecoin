import 'package:auto_route/auto_route.dart';

import 'package:ecoin/features/pages.dart';

part 'router.gr.dart';

// generate with dart run build_runner build
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: OnboardingRoute.page,
          path: '/onboarding',
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
