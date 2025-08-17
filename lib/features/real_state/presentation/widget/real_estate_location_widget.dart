import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/page/map_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/map_utils.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class RealEstateLocationWidget extends StatefulWidget {
  final RealEstate realEstate;

  const RealEstateLocationWidget({super.key, required this.realEstate});

  @override
  State<RealEstateLocationWidget> createState() =>
      _RealEstateLocationWidgetState();
}

class _RealEstateLocationWidgetState extends State<RealEstateLocationWidget> {
  Marker? marker;

  String? darkStyle;

  Future<void> _loadStyles() async {
    darkStyle = await rootBundle.loadString('assets/maps/map_dark_style.json');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: GoogleMap(
                zoomControlsEnabled: false,
                style: Theme.of(context).brightness == Brightness.light
                    ? null
                    : darkStyle,
                markers: marker == null ? {} : {marker!},
                initialCameraPosition: CameraPosition(
                  target: widget.realEstate.location.latLng,
                  zoom: 18,
                ),
                onMapCreated: (c) async {
                  await _loadStyles();

                  marker = Marker(
                    markerId: const MarkerId('1'),
                    position: widget.realEstate.location.latLng,
                    icon: await MapUtils.createMarkerFromWidget(
                      child: Assets.icons.mapMarker.svg(width: 40, height: 40),
                      size: Size(40, 40),
                    ),
                  );
                  setState(() {});
                },
              ),
            ),
          ),
          PositionedDirectional(
            end: 8,
            top: 8,
            child: InkWell(
              onTap: () {
                context.pushNamed(
                  MapPage.path,
                  extra: LatLng(
                    widget.realEstate.location.lat,
                    widget.realEstate.location.lng,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).cardColor,
                ),
                child: Assets.icons.expand.dynamicSVGColor(
                  context,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
