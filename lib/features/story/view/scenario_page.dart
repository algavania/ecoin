import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/story/scenario_model.dart';
import 'package:ecoin/data/models/story/story_model.dart';
import 'package:ecoin/database/db_helper.dart';
import 'package:ecoin/features/story/bloc/story_bloc.dart';
import 'package:ecoin/features/story/data/repository/story_repository.dart';
import 'package:ecoin/injector/injector.dart';
import 'package:ecoin/routes/router.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:ecoin/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class ScenarioPage extends StatefulWidget {
  const ScenarioPage({super.key,
    required this.list,
    required this.answers,
    required this.index,
    required this.storyModel});

  final StoryModel storyModel;
  final List<ScenarioModel> list;
  final List<bool> answers;
  final int index;

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  late final ScenarioModel _scenarioModel;
  final _bloc = StoryBloc(repository: Injector.instance<StoryRepository>());
  bool? _isPositive;

  @override
  void initState() {
    _scenarioModel = widget.list[widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StoryBloc, StoryState>(
      bloc: _bloc,
      listener: (context, state) {
        state.maybeMap(
            overlayLoading: (_) {
              if (!context.loaderOverlay.visible) {
                context.loaderOverlay.show();
              }
            },
            endingsLoaded: (s) {
              context.loaderOverlay.hide();
              AutoRouter.of(context).push(ScenarioResultRoute(
                  storyModel: widget.storyModel, endingModel: s.list.first));
            },
            orElse: () {});
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.storyModel.title),
          actions: [
            Text(
              '${widget.index + 1}/${widget.list.length}',
              style: context.textTheme.titleMedium
                  .copyWith(color: ColorValues.primary70),
            ),
            const SizedBox(
              width: Styles.defaultPadding,
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          color: ColorValues.white,
          child: ElevatedButton(
            onPressed: _isPositive == null
                ? null
                : () {
              final answers = List<bool>.from(widget.answers);
              answers.add(_isPositive!);
              final isEnding = widget.index + 1 == widget.list.length;
              if (isEnding) {
                final positiveAnswers = answers.where((element) => element).length;
                final percentage = positiveAnswers/widget.list.length;
                logger.d('percentage $percentage');
                var endingType = DbHelper.negativeEnding;
                if (percentage >= 0.8) {
                  endingType = DbHelper.positiveEnding;
                } else if (percentage >= 0.5) {
                  endingType = DbHelper.neutralEnding;
                }
                _bloc.add(StoryEvent.getEndings(widget.storyModel.id!, endingType));
              } else {
                AutoRouter.of(context).push(ScenarioRoute(
                    list: widget.list,
                    answers: answers,
                    index: widget.index + 1,
                    storyModel: widget.storyModel));
              }
            },
            child: const Text('Lanjut'),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 35.h,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: ColorValues.primary10,
                child: CachedNetworkImage(
                  imageUrl: _scenarioModel.imageUrl,
                  height: 35.h,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 33.h),
                padding: const EdgeInsets.all(Styles.defaultPadding),
                decoration: const BoxDecoration(
                  color: ColorValues.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Styles.biggerBorder),
                    topRight: Radius.circular(Styles.biggerBorder),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _scenarioModel.title,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: Styles.defaultSpacing,
                    ),
                    Text(_scenarioModel.scene.replaceToNewLine()),
                    const SizedBox(
                      height: Styles.bigSpacing,
                    ),
                    Text(
                      _scenarioModel.question,
                      style: context.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: Styles.defaultSpacing,
                    ),
                    _buildAnswerWidget(_scenarioModel.options.positive, true),
                    const SizedBox(
                      height: Styles.defaultSpacing,
                    ),
                    _buildAnswerWidget(_scenarioModel.options.negative, false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerWidget(String answer, bool value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPositive = value;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: ColorValues.white,
          border: Border.all(
            color: ColorValues.grey10,
          ),
          borderRadius: BorderRadius.circular(Styles.defaultBorder),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(Styles.mediumPadding),
                decoration: BoxDecoration(
                  color: _isPositive == value
                      ? ColorValues.primary70
                      : ColorValues.grey40,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Styles.defaultBorder),
                    bottomLeft: Radius.circular(Styles.defaultBorder),
                  ),
                ),
                child: Center(
                  child: Text(
                    value ? 'A' : 'B',
                    style: context.textTheme.bodyMedium
                        .copyWith(color: ColorValues.white),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Styles.mediumPadding),
                    child: Text(answer),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
