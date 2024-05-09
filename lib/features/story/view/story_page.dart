import 'package:auto_route/auto_route.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/story/story_model.dart';
import 'package:ecoin/features/story/bloc/story_bloc.dart';
import 'package:ecoin/features/story/data/repository/story_repository.dart';
import 'package:ecoin/injector/injector.dart';
import 'package:ecoin/routes/router.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:ecoin/widgets/custom_card_widget.dart';
import 'package:ecoin/widgets/custom_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final _bloc = StoryBloc(repository: Injector.instance<StoryRepository>());
  final _dummyList = <StoryModel>[];

  @override
  void initState() {
    _dummyList.addAll(List.generate(5, (index) => generateMockStoryModel()));
    _bloc.add(const StoryEvent.getAllStories());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoryBloc, StoryState>(
      bloc: _bloc,
      listener: (context, state) {
        state.maybeMap(
            error: (s) {
              context.showSnackBar(message: s.error, isSuccess: false);
            },
            orElse: () {}
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cerita Interaktif'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _bloc.add(const StoryEvent.getAllStories());
          },
          child: Stack(
            children: [
              ListView(physics: const AlwaysScrollableScrollPhysics(),),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(Styles.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pelajari dan temukan berbagai  ending dari pilihan yang kamu buat dalam cerita interaktif.',
                        style: context.textTheme.bodyMedium
                            .copyWith(color: ColorValues.grey50),
                      ),
                      const SizedBox(
                        height: Styles.bigSpacing,
                      ),
                      CustomSectionWidget(
                          title: 'Pilihan Cerita', child: _buildBody()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<StoryBloc, StoryState>(
      bloc: _bloc,
      builder: (context, state) {
        return state.maybeMap(
          orElse: () => _buildListWidget(_dummyList, true),
          loaded: (s) => _buildListWidget(s.list, false),
        );
      },
    );
  }

  Widget _buildListWidget(List<StoryModel> list, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, i) {
            final model = list[i];
            return GestureDetector(
              onTap: () {
                AutoRouter.of(context)
                    .push(StoryDetailRoute(storyModel: model,));
              },
              child: CustomCardWidget(
                  title: model.title,
                  description: model.subtitle,
                  imageUrl: model.imageUrl),
            );
          },
          separatorBuilder: (_, __) =>
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
          itemCount: list.length),
    );
  }
}
