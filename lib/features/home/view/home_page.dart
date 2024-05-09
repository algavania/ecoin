import 'package:auto_route/auto_route.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/data/models/quiz/quiz_model.dart';
import 'package:ecoin/data/models/story/story_model.dart';
import 'package:ecoin/features/creature/bloc/creature_bloc.dart';
import 'package:ecoin/features/creature/data/repository/creature_repository.dart';
import 'package:ecoin/features/story/bloc/story_bloc.dart';
import 'package:ecoin/features/story/data/repository/story_repository.dart';
import 'package:ecoin/injector/injector.dart';
import 'package:ecoin/routes/router.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:ecoin/widgets/custom_card_widget.dart';
import 'package:ecoin/widgets/custom_creature_widget.dart';
import 'package:ecoin/widgets/custom_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _avatar = 'morning.png';
  var _greeting = '';
  final _dummyStoryList = <StoryModel>[];
  final _dummyCreatureList = <CreatureModel>[];
  final _dummyQuizList = <QuizModel>[];
  final _storyBloc =
  StoryBloc(repository: Injector.instance<StoryRepository>());
  final _creatureBloc =
  CreatureBloc(repository: Injector.instance<CreatureRepository>());

  @override
  void initState() {
    _dummyStoryList
        .addAll(List.generate(3, (index) => generateMockStoryModel()));
    _dummyCreatureList
        .addAll(List.generate(6, (index) => generateMockCreatureModel()));
    _dummyQuizList.addAll(List.generate(1, (index) => generateMockQuizModel()));
    _getAllData();
    super.initState();
  }

  Future<void> _getAllData() async {
    _storyBloc.add(const StoryEvent.getAllStories(limit: 3));
    _creatureBloc.add(const CreatureEvent.getAllCreatures(limit: 6));
  }

  @override
  Widget build(BuildContext context) {
    _getGreetingBasedOnTime();
    return MultiBlocListener(
      listeners: [
        BlocListener<StoryBloc, StoryState>(
          bloc: _storyBloc,
          listener: (context, state) {
            state.maybeMap(
              error: (s) {
                context.showSnackBar(message: s.error, isSuccess: false);
              },
              orElse: () {}
            );
          },
        ),
        BlocListener<CreatureBloc, CreatureState>(
          bloc: _creatureBloc,
          listener: (context, state) {
            state.maybeMap(
                error: (s) {
                  context.showSnackBar(message: s.error, isSuccess: false);
                },
                orElse: () {}
            );
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorValues.white,
          toolbarHeight: 0,
        ),
        body: RefreshIndicator(
          onRefresh: _getAllData,
          child: Stack(
            children: [
              ListView(physics: const AlwaysScrollableScrollPhysics(),),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    _buildTopBarWidget(),
                    const SizedBox(
                      height: Styles.bigSpacing,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: Styles.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildStorySection(),
                          const SizedBox(
                            height: Styles.bigSpacing,
                          ),
                          _buildCreatureSection(),
                          const SizedBox(
                            height: Styles.bigSpacing,
                          ),
                          _buildQuizSection(),
                          const SizedBox(
                            height: Styles.bigSpacing,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizSection() {
    final model = generateMockQuizModel();
    return CustomSectionWidget(
        title: 'Kuis Edukatif',
        rightText: 'Lihat Detail',
        rightOnTap: () {
          AutoRouter.of(context).navigate(const QuizRoute());
        },
        child: GestureDetector(
          onTap: () {
            AutoRouter.of(context).navigate(const QuizRoute());
          },
          child: CustomCardWidget(
            imageUrl: model.imageUrl,
            title: model.title,
            description: model.description,
          ),
        ));
  }

  Widget _buildCreatureSection() {
    return CustomSectionWidget(
        title: 'Kenali Makhluk Hidup',
        rightText: 'Lihat Semua',
        rightOnTap: () => AutoRouter.of(context).navigate(const CreatureRoute()),
        child: SizedBox(
          height: 35.h,
          child: BlocBuilder<CreatureBloc, CreatureState>(
            bloc: _creatureBloc,
            builder: (context, state) {
              return state.maybeMap(
                loaded: (s) => _buildCreatureList(s.list, false),
                orElse: () => _buildCreatureList(_dummyCreatureList, true),
              );
            },
          ),
        ));
  }

  Widget _buildCreatureList(List<CreatureModel> list, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, i) =>
              CustomCreatureWidget(
                creature: list[i],
                width: 38.w,
              ),
          separatorBuilder: (_, __) =>
          const SizedBox(
            width: Styles.defaultSpacing,
          ),
          itemCount: list.length),
    );
  }

  Widget _buildStorySection() {
    return CustomSectionWidget(
        title: 'Cerita Interaktif',
        rightText: 'Lihat Detail',
        rightOnTap: () => AutoRouter.of(context).navigate(const StoryRoute()),
        child: BlocBuilder<StoryBloc, StoryState>(
          bloc: _storyBloc,
          builder: (context, state) {
            return state.maybeMap(
              loaded: (s) => _buildStoryList(s.list, false),
              orElse: () => _buildStoryList(_dummyStoryList, true),
            );
          },
        ));
  }

  Widget _buildStoryList(List<StoryModel> list, bool isLoading) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, i) {
            final model = list[i];
            return GestureDetector(
              onTap: () {
                AutoRouter.of(context).push(StoryDetailRoute(storyModel: model));
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

  Widget _buildTopBarWidget() {
    return Container(
      padding: const EdgeInsets.all(Styles.defaultPadding),
      color: ColorValues.white,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$_greeting,'),
                Text(
                  'Kawan Eco.in!',
                  style: context.textTheme.titleLarge,
                )
              ],
            ),
          ),
          const SizedBox(
            width: Styles.defaultSpacing,
          ),
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/home/$_avatar'),
          )
        ],
      ),
    );
  }

  void _getGreetingBasedOnTime() {
    final date = DateTime.now();
    final hours = date.hour;
    _greeting = 'Selamat pagi';
    _avatar = 'morning.png';
    if (hours >= 1 && hours <= 11) {
      _greeting = 'Selamat pagi';
      _avatar = 'morning.png';
    } else if (hours >= 11 && hours <= 14) {
      _greeting = 'Selamat siang';
      _avatar = 'afternoon.png';
    } else if (hours >= 14 && hours <= 17) {
      _greeting = 'Selamat sore';
      _avatar = 'evening.png';
    } else if (hours >= 17 && hours <= 24) {
      _greeting = 'Selamat malam';
    }

    // additional conditional for night and dusk
    if (hours >= 18 || hours <= 4) {
      _avatar = 'night.png';
    }
  }
}
