import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RealStateMapPage extends StatefulWidget {
  static String path = '/real_state_map_page';

  const RealStateMapPage({super.key});

  @override
  State<RealStateMapPage> createState() => _RealStateMapPageState();
}

class _RealStateMapPageState extends State<RealStateMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(35.1408, 36.7553),
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
                  point: LatLng(35.1408, 36.7553),
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(shape: BoxShape.circle,
                    color: Colors.blue
                    ),
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
