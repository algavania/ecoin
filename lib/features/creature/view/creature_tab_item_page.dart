import 'package:auto_route/annotations.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/widgets/custom_creature_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

@RoutePage()
class CreatureTabItemPage extends StatelessWidget {
  const CreatureTabItemPage({super.key, required this.list});
  final List<CreatureModel> list;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: AlignedGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: Styles.defaultPadding,
          crossAxisSpacing: Styles.defaultPadding,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return CustomCreatureWidget(creature: list[index]);
          },
        ),
      ),
    );
  }
}
