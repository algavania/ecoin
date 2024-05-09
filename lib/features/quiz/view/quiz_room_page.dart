
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/quiz/quiz_item_model.dart';
import 'package:ecoin/routes/router.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class QuizRoomPage extends StatefulWidget {
  const QuizRoomPage({super.key, required this.list});
  final List<QuizItemModel> list;

  @override
  State<QuizRoomPage> createState() => _QuizRoomPageState();
}

class _QuizRoomPageState extends State<QuizRoomPage> {
  var _index = 0;
  late List<String> _answers;

  @override
  void initState() {
    _answers = List.generate(widget.list.length, (index) => '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _index == 0,
      onPopInvoked: (_) {
        if (_index > 0) {
          setState(() {
            _index--;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ruang Kuis'),
          actions: [
            Text(
              '${_index + 1}/${widget.list.length}',
              style: context.textTheme.titleMedium
                  .copyWith(color: ColorValues.primary70),
            ),
            const SizedBox(
              width: Styles.defaultPadding,
            ),
          ]
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuestionWidget(widget.list[_index].question),
              const SizedBox(height: Styles.bigPadding),
              _buildAnswerWidget(widget.list[_index]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionWidget(String question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Soal ${_index + 1}',
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
        if (_index < widget.list.length - 1) {
          _answers[_index] = choice;
          setState(() {
            _index++;
          });
        } else {
          var score = 0;
          for (var i = 0; i < widget.list.length; i++) {
            if (widget.list[i].answer == _answers[i]) {
              score++;
            }
          }
          AutoRouter.of(context).replace(QuizResultRoute(score: score));
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
                decoration: BoxDecoration(
                  color: _answers[_index] == choice
                      ? ColorValues.primary70
                      : ColorValues.grey40,
                  borderRadius: const BorderRadius.only(
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
