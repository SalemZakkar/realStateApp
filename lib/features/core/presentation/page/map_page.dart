import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/widget/map_cluster_widget.dart';
import 'package:real_state/features/core/presentation/widget/map_widget.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class MapPage extends StatefulWidget {
  static String path = '/map_page';
  final LatLng latLng;

  const MapPage({super.key, required this.latLng});

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
          child: MapWidget(
            withBackButton: true,
            withExpand: false,
            latLng: widget.latLng,
            icon: MarkerData.fromWidget(
              child: Assets.icons.mapMarker.svg(width: 40, height: 40),
              size: Size(40, 40),
            ),
          ),
        ),
      ),
    );
  }
}
