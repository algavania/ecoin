import 'package:auto_route/auto_route.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/routes/router.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreaturePage extends StatefulWidget {
  const CreaturePage({super.key});

  @override
  State<CreaturePage> createState() => _CreaturePageState();
}

class _CreaturePageState extends State<CreaturePage> {
  @override
  Widget build(BuildContext context) {
    final list = List.generate(10, (_) => generateMockCreatureModel());
    return AutoTabsRouter.tabBar(
      routes: [
        CreatureTabItemRoute(list: list),
        CreatureTabItemRoute(list: list),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Makhluk'),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: 'Hewan'),
                Tab(text: 'Tumbuhan'),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
