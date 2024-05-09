import 'package:auto_route/auto_route.dart';
import 'package:ecoin/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        StoryRoute(),
        CreatureRoute(),
        QuizRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.home),
              label: 'Beranda',
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.book),
              label: 'Cerita',
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.tree),
              label: 'Makhluk',
            ),
            NavigationDestination(
              icon: Icon(IconsaxPlusBold.document_normal),
              label: 'Kuis',
            ),
          ],
        );
      },
    );
  }
}
