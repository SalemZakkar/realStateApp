import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/utils/map_utils.dart';
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

  Marker? marker;

  String? darkStyle;

  Future<void> _loadStyles() async {
    darkStyle = await rootBundle.loadString('assets/maps/map_dark_style.json');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.map)),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: GoogleMap(
          tiltGesturesEnabled: false,

          style: Theme.of(context).brightness == Brightness.light
              ? null
              : darkStyle,
          markers: marker == null ? {} : {marker!},
          initialCameraPosition: CameraPosition(
            target: widget.latLng,
            zoom: 16,
          ),
          onMapCreated: (c) async {
            await _loadStyles();

            marker = Marker(
              markerId: const MarkerId('1'),
              position: widget.latLng,
              icon: await MapUtils.createMarkerFromWidget(
                child: Assets.icons.mapMarker.svg(width: 40, height: 40),
                size: Size(40, 40),
              ),
            );
            setState(() {});
          },
        ),
      ),
    );
  }
}
