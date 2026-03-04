import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';

class PropertyMapPage extends StatefulWidget {
  static String path = "/PropertyMapPage";

  const PropertyMapPage({super.key});

  @override
  State<PropertyMapPage> createState() => _PropertyMapPageState();
}

class _PropertyMapPageState extends State<PropertyMapPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(32, 32)),
            ),
          ],
        ),
      ),
    );
  }
}
