import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class QuizResultPage extends StatefulWidget {
  final int score;

  const QuizResultPage({super.key, required this.score});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  late String resultDesc;

  @override
  void initState() {
    if (widget.score * 10 >= 80) {
      resultDesc = 'Selamat! Kamu telah menyelesaikan kuis dengan skor yang sangat baik. Pertahankan prestasimu selalu ya!';
    } else if (widget.score * 10 >= 60) {
      resultDesc = 'Kamu telah menyelesaikan kuis dengan baik. Tapi masih bisa ditingkatkan lagi nih, terus semangat dalam belajar ya!';
    } else {
      resultDesc = 'Sepertinya masih ada banyak hal yang dapat dipelajari. Tapi tidak apa-apa, terus belajar dan jangan menyerah ya!';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: Column(
          children: [
            Text(
              'Skor Akhir',
              style: context.textTheme.titleLarge,
            ),
            CachedNetworkImage(
              imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ecoin-extend.appspot.com/o/Quiz%20Result.png?alt=media&token=26763f21-39fe-45f3-9a8d-01a8e9b36e04',
              fit: BoxFit.cover,
              height: 35.h,
            ),
            const SizedBox(
              height: Styles.bigSpacing,
            ),
            RichText(
              text: TextSpan(
                text: '${widget.score * 10}',
                style: context.textTheme.titleLarger.copyWith(
                  color: ColorValues.primary70,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: ' / 100',
                    style: context.textTheme.bodyMedium.copyWith(
                      color: ColorValues.grey50,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: Styles.mediumSpacing,
            ),
            Text(
              resultDesc,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium,
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).popUntilRoot();
                },
                child: const Text('Kembali ke Beranda')),
            const SizedBox(
              height: Styles.mediumSpacing,
            ),
          ],
        ),
      ),
    );
  }
}
