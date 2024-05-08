import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/routes/router.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCreatureWidget extends StatelessWidget {
  const CustomCreatureWidget(
      {super.key,
      required this.creature,
      this.width
      });

  final CreatureModel creature;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      height: 35.h,
      width: width,
      child: GestureDetector(
        onTap: () {
          AutoRouter.of(context).push(CreatureDetailRoute(creature: creature));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Styles.defaultBorder),
                topRight: Radius.circular(Styles.defaultBorder),
              ),
              child: CachedNetworkImage(imageUrl: 
                creature.imageUrl,
                fit: BoxFit.cover,
                height: 25.h,
                width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}
