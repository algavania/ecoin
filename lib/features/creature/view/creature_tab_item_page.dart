import 'package:auto_route/annotations.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/features/creature/bloc/creature_bloc.dart';
import 'package:ecoin/features/creature/data/repository/creature_repository.dart';
import 'package:ecoin/injector/injector.dart';
import 'package:ecoin/widgets/custom_creature_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class CreatureTabItemPage extends StatefulWidget {
  const CreatureTabItemPage({super.key, required this.type,});
  final String type;

  @override
  State<CreatureTabItemPage> createState() => _CreatureTabItemPageState();
}

class _CreatureTabItemPageState extends State<CreatureTabItemPage> {
  final _bloc = CreatureBloc(
      repository: Injector.instance<CreatureRepository>());
  final _dummyList = <CreatureModel>[];

  @override
  void initState() {
    _dummyList.addAll(List.generate(6, (_) => generateMockCreatureModel()));
    _bloc.add(CreatureEvent.getCreaturesByType(widget.type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatureBloc, CreatureState>(
      bloc: _bloc,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(CreatureEvent.getCreaturesByType(widget.type));
          },
          child: Stack(
            children: [
              ListView(physics: const AlwaysScrollableScrollPhysics(),),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(Styles.defaultPadding),
                  child: state.maybeMap(
                    loaded: (s) => _buildList(s.list, false),
                    orElse: () => _buildList(_dummyList, true),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(List<CreatureModel> list, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
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
    );
  }
}
