import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({super.key,
    required this.title,
    required this.description,
    required this.imageUrl});

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      decoration: BoxDecoration(
        color: ColorValues.white,
        borderRadius: BorderRadius.circular(Styles.defaultBorder),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              const SizedBox(width: Styles.defaultPadding,),
              Expanded(child: _buildBody(context)),
              const SizedBox(width: Styles.mediumSpacing,),
              SizedBox(width: 40.w,),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(Styles.defaultBorder),
                  bottomRight: Radius.circular(Styles.defaultBorder),
                ),
                child: CachedNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover, height: 20.h, )),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: Styles.defaultPadding,),
        Text(title, style: context.textTheme.bodyMediumBold),
        const SizedBox(height: Styles.mediumSpacing,),
        Expanded(
          child: Text(description, style: context.textTheme.bodySmall.copyWith(
              color: ColorValues.grey50),),
        ),
        const SizedBox(height: Styles.defaultPadding,),
      ],
    );
  }
}
