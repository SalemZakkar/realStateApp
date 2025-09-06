import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/utils/map_utils.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
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
  final bool root;

  const MapWidget({
    super.key,
    this.latLng,
    this.width,
    this.height,
    this.onCreate,
    this.icon,
    this.ignore = false,
    this.zoomControls = false,
    this.onTap,
    this.radius,
    this.withExpand = true,
    this.withBackButton = false,
    this.root = true,
  });

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  BitmapDescriptor bitmapDescriptor = BitmapDescriptor.defaultMarker;
  Marker? marker;
  Marker? selected;

  LatLng? latLng;

  late GoogleMapController controller;

  @override
  void initState() {
    super.initState();
    latLng = widget.latLng;
  }

  @override
  void didUpdateWidget(covariant MapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.latLng != widget.latLng && marker != null) {
      setState(() {
        marker = marker!.copyWith(positionParam: widget.latLng);
      });
      controller.animateCamera(CameraUpdate.newLatLngZoom(widget.latLng!, 14));
    }
  }

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
                  controller = c;
                  widget.onCreate?.call(c);
                  bitmapDescriptor =
                      await widget.icon?.getIcon() ??
                      BitmapDescriptor.defaultMarker;
                  // if (widget.latLng != null) {
                  marker = Marker(
                    markerId: MarkerId('Pos'),
                    icon: bitmapDescriptor,
                  );
                  if (latLng != null) {
                    marker = marker!.copyWith(positionParam: latLng!);
                  }
                  setState(() {});
                  // }
                },
                onTap: (latLng) {
                  if (widget.onTap == null) {
                    return;
                  }
                  this.latLng = latLng;
                  marker = Marker(
                    markerId: const MarkerId('Sel'),
                    position: latLng,
                  );
                  setState(() {});
                  if (widget.root == false) {
                    return;
                  }
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
                onTap: () async {
                  // if (latLng != null) {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        body: SafeArea(
                          child: MapWidget(
                            latLng: latLng,
                            icon: widget.icon,
                            ignore: false,
                            root: false,
                            withExpand: false,
                            withBackButton: true,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,

                            onTap: widget.onTap == null
                                ? null
                                : (latLng) {
                                    this.latLng = latLng;
                                    marker = marker?.copyWith(
                                      positionParam: latLng,
                                    );
                                    controller.animateCamera(
                                      CameraUpdate.newLatLngZoom(latLng, 14),
                                    );
                                    widget.onTap?.call(latLng);
                                    setState(() {});
                                  },
                          ),
                        ),
                      ),
                    ),
                  );

                  setState(() {});
                  // }
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
          if (widget.onTap != null) ...[
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomCardWidget(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        context.translation.pressOnTheMapToSetTheMarker,
                      ),
                    ),
                  ),
                  if (widget.root == false &&
                      latLng != null &&
                      widget.onTap != null)
                    ...[
                      8.height(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pop();
                            widget.onTap?.call(latLng!);
                          },
                          child: Text(context.translation.save),
                        ),
                      ),
                    ]
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
