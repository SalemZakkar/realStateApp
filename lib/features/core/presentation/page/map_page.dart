import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/widget/main_map_page.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class MapPage extends StatefulWidget {
  static String path = '/map_page';
  final MainMapWidget Function() build;

  const MapPage({super.key, required this.build});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: widget.build(),
        ),
      ),
    );
  }
}
