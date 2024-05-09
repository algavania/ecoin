import 'package:auto_route/auto_route.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';

import 'package:ecoin/features/pages.dart';
import 'package:flutter/material.dart';

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
        CustomRoute(
            page: DashboardRoute.page,
            path: '/dashboard',
            transitionsBuilder: TransitionsBuilders.fadeIn,
            children: [
              CustomRoute(
                page: HomeRoute.page,
                path: 'home',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
              CustomRoute(
                  page: CreatureRoute.page,
                  path: 'creature',
                  transitionsBuilder: TransitionsBuilders.fadeIn,
                  children: [
                    CustomRoute(
                      page: CreatureTabItemRoute.page,
                      path: 'item',
                      transitionsBuilder: TransitionsBuilders.fadeIn,
                    )
                  ]),
              CustomRoute(
                page: QuizRoute.page,
                path: 'quiz',
                transitionsBuilder: TransitionsBuilders.fadeIn,
              ),
            ]),
        CustomRoute(
          page: CreatureDetailRoute.page,
          path: '/creature-detail',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: ModelViewerRoute.page,
          path: '/viewer',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: QuizRoomRoute.page,
          path: '/quiz-room',
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
