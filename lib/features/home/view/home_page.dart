import 'package:auto_route/annotations.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/data/models/quiz/quiz_model.dart';
import 'package:ecoin/data/models/story/story_model.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:ecoin/widgets/custom_card_widget.dart';
import 'package:ecoin/widgets/custom_creature_widget.dart';
import 'package:ecoin/widgets/custom_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _avatar = 'morning.png';
  var _greeting = '';

  @override
  Widget build(BuildContext context) {
    _getGreetingBasedOnTime();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorValues.white,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
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
    );
  }

  Widget _buildQuizSection() {
    final model = generateMockQuizModel();
    return CustomSectionWidget(title: 'Kuis Edukatif',
        rightText: 'Lihat Detail',
        child: CustomCardWidget(
          imageUrl: model.imageUrl,
          title: model.title,
          description: model.description,
        ));
  }

  Widget _buildCreatureSection() {
    final model = generateMockCreatureModel();
    return CustomSectionWidget(
        title: 'Kenali Makhluk hidup',
        rightText: 'Lihat Semua',
        child: SizedBox(
          height: 35.h,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, __) => CustomCreatureWidget(
                    creature: model,
                  ),
              separatorBuilder: (_, __) => const SizedBox(
                    width: Styles.defaultSpacing,
                  ),
              itemCount: 5),
        ));
  }

  Widget _buildStorySection() {
    final model = generateMockStoryModel();
    return CustomSectionWidget(
      title: 'Cerita Interaktif',
      rightText: 'Lihat Detail',
      child: CustomCardWidget(
          title: model.title,
          description: model.description,
          imageUrl: model.imageUrl),
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
