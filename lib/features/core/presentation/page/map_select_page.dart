import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/map_field_widget.dart';

class MapSelectPage extends StatefulWidget {
  static String path = "/MapSelectPage";
  final LatLng? latLng;

  const MapSelectPage({super.key, this.latLng});

  @override
  State<MapSelectPage> createState() => _MapSelectPageState();
}

class _MapSelectPageState extends State<MapSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.location)),
      body: MapFieldWidget(
        latLng: widget.latLng,
        onChanged: (v) {
          context.pop(v);
        },
        view: false,
      ),
    );
  }
}
