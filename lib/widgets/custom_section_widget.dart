import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';

class CustomSectionWidget extends StatelessWidget {
  const CustomSectionWidget(
      {super.key,
      required this.title,
      this.rightText,
      this.rightOnTap,
      required this.child});

  final String title;
  final String? rightText;
  final VoidCallback? rightOnTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              title,
              style: context.textTheme.titleLarge,
            )),
            if (rightText != null)
              const SizedBox(
                width: Styles.defaultSpacing,
              ),
            if (rightText != null)
              GestureDetector(
                onTap: rightOnTap,
                child: Text(
                  rightText!,
                  style: context.textTheme.bodyMedium
                      .copyWith(color: ColorValues.primary50),
                ),
              )
          ],
        ),
        const SizedBox(height: Styles.biggerSpacing,),
        child,
      ],
    );
  }
}
