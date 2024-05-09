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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

@RoutePage()
class StoryDetailPage extends StatefulWidget {
  const StoryDetailPage(
      {super.key, required this.storyModel,});

  final StoryModel storyModel;

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  final _bloc = StoryBloc(repository: Injector.instance<StoryRepository>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Cerita'),
      ),
      bottomNavigationBar: Container(
        color: ColorValues.white,
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: ElevatedButton(
          onPressed: () {
            _bloc.add(StoryEvent.getScenarios(widget.storyModel.id!));
          },
          child: const Text('Mulai Cerita'),
        ),
      ),
      body: BlocListener<StoryBloc, StoryState>(
        bloc: _bloc,
        listener: (context, state) {
          state.maybeMap(
              overlayLoading: (_) {
                if (!context.loaderOverlay.visible) {
                  context.loaderOverlay.show();
                }
              },
              scenariosLoaded: (s) {
                context.loaderOverlay.hide();
                AutoRouter.of(context).push(ScenarioRoute(
                    storyModel: widget.storyModel,
                    list: s.list,
                    answers: const [],
                    index: 0));
              },
              orElse: () {});
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Styles.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStoryCard(),
                const SizedBox(
                  height: Styles.bigSpacing,
                ),
                _buildDescriptionWidget(),
                const SizedBox(
                  height: Styles.bigSpacing,
                ),
                _buildRequirementsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ketentuan',
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: _buildRequirementCard(
              'Beragam Ending',
              RichText(
                text: TextSpan(
                    text: 'Ada ',
                    style: context.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: '3 ending',
                          style: context.textTheme.titleMedium
                              .copyWith(color: ColorValues.grey50)),
                      const TextSpan(text: ' berbeda untuk  didapatkan.'),
                    ]),
              ),
            )),
            const SizedBox(
              width: Styles.defaultSpacing,
            ),
            Expanded(
                child: _buildRequirementCard(
              'Tentukan Aksimu',
              RichText(
                text: TextSpan(
                    text: 'Ending ditentukan dari keputusan ',
                    style: context.textTheme.bodyMedium,
                    children: [
                      TextSpan(
                          text: 'pilihanmu',
                          style: context.textTheme.titleMedium
                              .copyWith(color: ColorValues.grey50)),
                      const TextSpan(text: '.'),
                    ]),
              ),
            )),
          ],
        )
      ],
    );
  }

  Widget _buildRequirementCard(String title, RichText content) {
    return Container(
      padding: const EdgeInsets.all(Styles.defaultSpacing),
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(
            height: Styles.mediumSpacing,
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildDescriptionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi',
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        Text(widget.storyModel.description),
      ],
    );
  }

  Widget _buildStoryCard() {
    return CustomCardWidget(
        title: widget.storyModel.title,
        description: widget.storyModel.subtitle,
        imageUrl: widget.storyModel.imageUrl);
  }
}
