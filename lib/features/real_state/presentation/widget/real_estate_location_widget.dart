import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:real_state/features/core/presentation/page/map_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateLocationWidget extends StatefulWidget {
  final RealEstate realEstate;

  const RealEstateLocationWidget({super.key, required this.realEstate});

  @override
  State<RealEstateLocationWidget> createState() =>
      _RealEstateLocationWidgetState();
}

class _RealEstateLocationWidgetState extends State<RealEstateLocationWidget> {
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
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(
                    widget.realEstate.location.lat,
                    widget.realEstate.location.lng,
                  ),
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
                        point: LatLng(
                          widget.realEstate.location.lat,
                          widget.realEstate.location.lng,
                        ),
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
