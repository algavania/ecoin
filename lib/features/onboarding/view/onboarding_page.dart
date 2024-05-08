import 'package:ecoin/core/styles.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(Styles.defaultPadding),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              'assets/onboarding/onboarding.png',
              height: 35.h,
            ),
            const SizedBox(
              height: Styles.bigSpacing,
            ),
            Text(
              'Solusi Edukasi Ekologi',
              style: context.textTheme.titleLarge,
            ),
            const SizedBox(height: Styles.mediumSpacing,),
            const Text(
              'Bersama-sama, kita dapat menginspirasi perubahan dan menjaga keindahan planet Bumi.',
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            ElevatedButton(onPressed: () {}, child: const Text('Mulai Sekarang')),
            const SizedBox(height: Styles.mediumSpacing,),
          ],
        ),
      ),
    );
  }
}