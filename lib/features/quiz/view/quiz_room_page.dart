import 'dart:ffi';

import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/quiz/quiz_item_model.dart';
import 'package:ecoin/routes/router.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class QuizRoomPage extends StatefulWidget {
  const QuizRoomPage({super.key});

  @override
  State<QuizRoomPage> createState() => _QuizRoomPageState();
}

class _QuizRoomPageState extends State<QuizRoomPage> {
  final ValueNotifier<int> _index = ValueNotifier(0);
  List<QuizItemModel> _quizItems = [];
  int _score = 0;

  @override
  void initState() {
    _quizItems = [
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now()),
      QuizItemModel(question: 'Apa yang dimaksud dengan ekosistem?', answer: 'A', choices: {'A': 'Ini adalah pilihan A.', 'B': 'Ini adalah pilihan B.', 'C': 'Ini adalah pilihan C.', 'D': 'Ini adalah pilihan D.'}, createdAt: DateTime.now())
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruang Kuis'),
        actions: [
          ValueListenableBuilder(
            valueListenable: _index,
            builder: (context, _, __) {
              return Text(
              '${_index.value + 1}/${_quizItems.length}',
                style: context.textTheme.titleMedium
                    .copyWith(color: ColorValues.primary70),
              );
            }
          ),
          const SizedBox(
            width: Styles.defaultPadding,
          ),
        ]
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: ValueListenableBuilder(
          valueListenable: _index,
          builder: (context, _, __) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionWidget(_quizItems[_index.value].question),
                const SizedBox(height: Styles.bigPadding),
                _buildAnswerWidget(_quizItems[_index.value]),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Soal ${_index.value + 1}',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: Styles.defaultSpacing),
        Text(
          question,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildAnswerWidget(QuizItemModel quizItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opsi Jawaban',
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: Styles.defaultSpacing),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quizItem.choices.length,
          itemBuilder: (context, index) {
            final key = quizItem.choices.keys.elementAt(index);
            final value = quizItem.choices.values.elementAt(index);
            return _buildChoiceWidget(key, value, quizItem.answer);
          },
          separatorBuilder: (context, index) => const SizedBox(height: Styles.defaultSpacing),
        ),
      ],
    );
  }

  Widget _buildChoiceWidget(String choice, String description, String correctAnswer) {
    return GestureDetector(
      onTap: () {
        if (choice.toLowerCase() == correctAnswer.toLowerCase()) {
          _score++;
        }

        if (_index.value < _quizItems.length - 1) {
          _index.value++;
        } else {
          AutoRouter.of(context).replace(QuizResultRoute(score: _score));
        }
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
                decoration: const BoxDecoration(
                  color: ColorValues.primary70,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Styles.defaultBorder),
                    bottomLeft: Radius.circular(Styles.defaultBorder),
                  ),
                ),
                child: Center(
                  child: Text(
                    choice,
                    style: context.textTheme.bodyMedium
                        .copyWith(color: ColorValues.white),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Styles.mediumPadding),
                    child: Text(description),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
