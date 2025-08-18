import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/page/map_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/map_utils.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/map_cluster_widget.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class MapWidget extends StatefulWidget {
  final ValueChanged<GoogleMapController>? onCreate;
  final LatLng? latLng;
  final MarkerData? icon;
  final bool ignore;
  final bool zoomControls;
  final ValueChanged<LatLng>? onTap;
  final double? width, height;
  final BorderRadius? radius;
  final bool withExpand;
  final bool withBackButton;

  const MapWidget({
    super.key,
    this.latLng,
    this.width,
    this.height,
    this.onCreate,
    this.icon,
    this.ignore = false,
    this.zoomControls = true,
    this.onTap,
    this.radius,
    this.withExpand = true,
    this.withBackButton = false,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  BitmapDescriptor bitmapDescriptor = BitmapDescriptor.defaultMarker;
  Marker? marker;
  Marker? selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: widget.radius ?? BorderRadius.circular(8),
      ),
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              ignoring: widget.ignore,
              child: GoogleMap(
                tiltGesturesEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: widget.latLng ?? LatLng(35, 38),
                  zoom: widget.latLng == null ? 6 : 14,
                ),
                zoomControlsEnabled: widget.zoomControls,
                style: MapUtils.getTheme(context),
                markers: marker == null ? {} : {marker!},
                onMapCreated: (c) async {
                  widget.onCreate?.call(c);
                  bitmapDescriptor =
                      await widget.icon?.getIcon() ??
                      BitmapDescriptor.defaultMarker;
                  if (widget.latLng != null) {
                    marker = Marker(
                      markerId: MarkerId('Pos'),
                      icon: bitmapDescriptor,
                      position: widget.latLng!,
                    );
                    setState(() {});
                  }
                },
                onTap: (latLng) {
                  marker = Marker(
                    markerId: const MarkerId('Sel'),
                    position: latLng,
                  );
                  setState(() {});
                  widget.onTap?.call(latLng);
                },
              ),
            ),
          ),
          if (widget.withExpand)
            PositionedDirectional(
              top: 8,
              end: 8,
              child: InkWellWithoutFeedback(
                onTap: () {
                  if (widget.latLng != null) {
                    context.push(MapPage.path, extra: widget.latLng!);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Assets.icons.expand.dynamicSVGColor(context),
                ),
              ),
            ),
          if (widget.withBackButton)
            PositionedDirectional(
              top: 8,
              start: 8,
              child: InkWellWithoutFeedback(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
