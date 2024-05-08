import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecoin/core/color_values.dart';
import 'package:ecoin/core/styles.dart';
import 'package:ecoin/data/models/creature/creature_model.dart';
import 'package:ecoin/routes/router.dart';
import 'package:ecoin/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

@RoutePage()
class CreatureDetailPage extends StatefulWidget {
  const CreatureDetailPage({super.key, required this.creature});

  final CreatureModel creature;

  @override
  State<CreatureDetailPage> createState() => _CreatureDetailPageState();
}

class _CreatureDetailPageState extends State<CreatureDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Stack(children: [
            _buildCreatureImage(),
            Column(children: [
              SizedBox(height: 32.h),
              _buildInfoCard(),
              _buildDetails(),
            ]),
          ]),
        ),
        bottomNavigationBar: widget.creature.modelUrl?.isNotEmpty ?? false
            ? _buildBottomWidget()
            : const SizedBox.shrink());
  }

  Widget _buildBottomWidget() {
    return Container(
      color: ColorValues.white,
      padding: const EdgeInsets.all(Styles.defaultPadding),
      child: ElevatedButton(
          onPressed: () {
            AutoRouter.of(context).push(ModelViewerRoute(
                name: widget.creature.name,
                url: widget.creature.modelUrl ?? ''));
          },
          child: const Text('Lihat dalam 3D')),
    );
  }

  Widget _buildCreatureImage() {
    return CachedNetworkImage(
        imageUrl: widget.creature.imageUrl,
        width: 100.w,
        height: 38.h,
        fit: BoxFit.cover);
  }

  Widget _buildInfoCard() {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.creature.name,
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 5.0),
          _buildMainInfo('Nama Ilmiah', widget.creature.scientificName),
          _buildMainInfo('Kelas', widget.creature.category),
          _buildMainInfo('Asal', widget.creature.origin),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailInfo('Deskripsi Singkat', widget.creature.description),
        ],
      ),
    );
  }

  Widget _buildDetailInfo(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: Styles.defaultSpacing),
        Text(description, textAlign: TextAlign.justify),
      ],
    );
  }

  Widget _buildMainInfo(String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Text(
              title,
            )),
        const SizedBox(width: 10.0),
        Expanded(
            flex: 3,
            child: Text(
              ': $description',
            )),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(
        widget.creature.name,
      ),
    );
  }
}
