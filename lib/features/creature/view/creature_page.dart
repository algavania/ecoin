import 'package:auto_route/auto_route.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/database/db_helper.dart';
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
    return AutoTabsRouter.tabBar(
      routes: [
        CreatureTabItemRoute(type: DbHelper.typeAnimal),
        CreatureTabItemRoute(type: DbHelper.typePlant),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Makhluk'),
            bottom: TabBar(
              controller: controller,
              tabs: const [
                Tab(text: DbHelper.typeAnimal),
                Tab(text: DbHelper.typePlant),
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}
