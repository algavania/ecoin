import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/story/ending_model.dart';
import 'package:ecoin/data/models/story/story_model.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class ScenarioResultPage extends StatelessWidget {
  const ScenarioResultPage({
    super.key,
    required this.storyModel,
    required this.endingModel,
  });

  final StoryModel storyModel;
  final EndingModel endingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(storyModel.title),
        actions: [
          Text(
            'Ending',
            style: context.textTheme.titleMedium
                .copyWith(color: ColorValues.primary70),
          ),
          const SizedBox(
            width: Styles.defaultPadding,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: ColorValues.white,
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: ElevatedButton(
          onPressed: () {
            AutoRouter.of(context).popUntilRoot();
          },
          child: const Text('Selesai'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: endingModel.imageUrl,
                width: MediaQuery.of(context).size.width,
                height: 35.h,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: Styles.bigSpacing,),
              Text(endingModel.type, style: context.textTheme.bodySmall.copyWith(color: ColorValues.primary50),),
              const SizedBox(height: Styles.defaultSpacing,),
              Text(endingModel.title, style: context.textTheme.titleLarge,),
              const SizedBox(height: Styles.defaultSpacing,),
              Text(endingModel.description.replaceToNewLine()),
            ],
          ),
        ),
      ),
    );
  }
}
