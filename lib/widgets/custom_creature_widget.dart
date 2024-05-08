import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCreatureWidget extends StatelessWidget {
  const CustomCreatureWidget(
      {super.key,
      required this.creature,});

  final CreatureModel creature;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      height: 35.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Styles.defaultBorder),
              topRight: Radius.circular(Styles.defaultBorder),
            ),
            child: Image.network(
              creature.imageUrl,
              fit: BoxFit.cover,
              height: 25.h,
              width: 38.w,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(Styles.mediumSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creature.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMediumBold,
                ),
                Text(
                  creature.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall
                      .copyWith(color: ColorValues.grey50),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
