import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

@RoutePage()
class ModelViewerPage extends StatelessWidget {
  const ModelViewerPage({super.key, required this.name, required this.url});

  final String name;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: ModelViewer(
        src: url,
        alt: name,
        ar: true,
        disableZoom: true,
      ),
    );
  }
}
