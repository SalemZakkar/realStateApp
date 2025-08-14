import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/themes/app_theme.dart';

class MapPage extends StatefulWidget {
  static String path = '/map_page';
  final LatLng latLng;

  const MapPage({super.key, required this.latLng});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.map)),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: widget.latLng,
            initialZoom: 19,
            interactionOptions: InteractionOptions(
              flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
            ),
            // initialCenter:
          ),
          children: [
            TileLayer(
              urlTemplate:
                  "https://api.maptiler.com/maps/streets-v2/{z}/{x}/{y}.png?key=Vh5c6lyPtjPEifTfOL9W",
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  // height: 30,
                  // width: 50,
                  point: widget.latLng,
                  child: Icon(
                    Icons.location_on,
                    size: 34,
                    color: context.appColorSchema.primaryColor,
                  ),
                ),
              ],
            ),

            // MarkerLayer(markers: markers)
          ],
        ),
      ),
    );
  }
}
