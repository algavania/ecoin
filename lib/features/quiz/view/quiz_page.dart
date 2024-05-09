import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoin/data/models/quiz/quiz_model.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sizer/sizer.dart';

import '../../../core/styles.dart';

@RoutePage()
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late QuizModel _quizModel;

  @override
  void initState() {
    _quizModel = generateMockQuizPageModel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Edukatif'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: _quizModel.imageUrl,
              fit: BoxFit.cover,
              height: 35.h,
            ),
            const SizedBox(
              height: Styles.bigSpacing,
            ),
            Text(
              _quizModel.title,
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(
              height: Styles.mediumSpacing,
            ),
            Text(
              _quizModel.description,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                },
                child: const Text('Mulai Kuis')),
            const SizedBox(
              height: Styles.mediumSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
