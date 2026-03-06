import 'package:core_package/core_package.dart';
import 'package:core_package/generated/generated_assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:real_state/features/core/presentation/page/map_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class MainMapWidget extends StatefulWidget {
  final bool root;
  final Size size;
  final BorderRadius? radius;
  final ValueChanged<LatLng>? onChanged;
  final LatLng? initial;
  final MapType mapType;
  final bool isField;

  const MainMapWidget({
    super.key,
    this.root = true,
    required this.size,
    this.radius,
    this.onChanged,
    this.initial,
    this.mapType = MapType.normal,
    this.isField = false,
  });

  @override
  State<MainMapWidget> createState() => _MainMapWidgetState();
}

class _MainMapWidgetState extends State<MainMapWidget> {
  LatLng? selectedLatLng;
  late GoogleMapController controller;
  BitmapDescriptor descriptor = BitmapDescriptor.defaultMarker;
  MapType mapType = MapType.normal;
  LatLng center = LatLng(34.8021, 38.9968);

  @override
  void initState() {
    super.initState();
    if (widget.initial != null) {
      selectedLatLng = widget.initial;
      center = selectedLatLng!;
    }
    if (selectedLatLng == null && !widget.root) {
      Geolocator.requestPermission().then((e) {
        if (e == LocationPermission.always ||
            e == LocationPermission.whileInUse) {
          Geolocator.getCurrentPosition().then((e) {
            controller.animateCamera(
              CameraUpdate.newLatLngZoom(LatLng(e.latitude, e.longitude), 18),
            );
          });
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant MainMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial && widget.initial != null) {
      setState(() {
        selectedLatLng = widget.initial;
        center = widget.initial!;
      });
      controller.animateCamera(CameraUpdate.newLatLngZoom(widget.initial!, 18));
    }
    if (oldWidget.initial != widget.initial && widget.initial == null) {
      selectedLatLng = null;
      center = LatLng(34.8021, 38.9968);
      controller.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(34.8021, 38.9968), 6),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWellWithoutFeedback(
      onTap: !widget.root
          ? null
          : () async {
              LatLng? latLng;
              latLng = await context.push(
                MapPage.path,
                extra: () => MainMapWidget(
                  size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                  isField: widget.isField,
                  initial: selectedLatLng,
                  root: false,
                ),
              );
              if (latLng != null) {
                setState(() {
                  selectedLatLng = latLng;
                });
                controller.animateCamera(
                  CameraUpdate.newLatLngZoom(selectedLatLng!, 18),
                );
                widget.onChanged?.call(latLng);
              }
            },
      child: IgnorePointer(
        ignoring: widget.root,
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: widget.root
              ? widget.size.width
              : MediaQuery.of(context).size.width,
          height: widget.root
              ? widget.size.height
              : MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: widget.root ? widget.radius : null,
          ),
          child: Stack(
            children: [
              GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,

                mapType: mapType,
                markers: selectedLatLng != null
                    ? <Marker>{
                        Marker(
                          markerId: MarkerId('pos'),
                          icon: descriptor,
                          position: selectedLatLng!,
                        ),
                      }
                    : <Marker>{},
                zoomControlsEnabled: false,
                rotateGesturesEnabled: false,
                onCameraMove: (v) {
                  center = v.target;
                },
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: selectedLatLng != null ? 19 : 6,
                ),
                onMapCreated: (c) async {
                  controller = c;
                  descriptor = await MarkerData.fromWidget(
                    child: Assets.icons.mapMarker.svg(width: 32, height: 32),
                    size: Size(32, 32),
                  ).getIcon();
                  if (selectedLatLng != null) {
                    controller.animateCamera(
                      CameraUpdate.newLatLngZoom(selectedLatLng!, 18),
                    );
                  }
                  setState(() {});
                },
                onTap: (v) {
                  // if (widget.isField) {
                  //   setState(() {
                  //     selectedLatLng = v;
                  //   });
                  // }
                },
              ),

              if (widget.root) ...[
                PositionedDirectional(
                  top: 8,
                  end: 8,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CoreAssets.icons.expand.dynamicSVGColor(
                      context,
                      package: 'core_package',
                    ),
                  ),
                ),
                if (widget.isField) ...[
                  PositionedDirectional(
                    bottom: 8,
                    end: 8,
                    start: 8,
                    child: CustomCardWidget(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          context.translation.pressHereToSelectLocation,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
              if (!widget.root) ...[
                // Center(
                //   child: Container(
                //     height: MediaQuery.of(context).size.height,
                //     width: 4,
                //     color: Colors.yellow,
                //   ),
                // ),
                // Center(
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     height: 4,
                //     color: Colors.yellow,
                //   ),
                // ),
                PositionedDirectional(
                  end: 8,
                  top: 8,
                  child: InkWellWithoutFeedback(
                    onTap: () {
                      if (mapType == MapType.hybrid) {
                        mapType = MapType.normal;
                      } else {
                        mapType = MapType.hybrid;
                      }
                      setState(() {});
                    },
                    child: CustomCardWidget(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Switch(
                            value: mapType == MapType.hybrid,
                            onChanged: (v) {
                              if (!v) {
                                mapType = MapType.normal;
                              } else {
                                mapType = MapType.hybrid;
                              }
                              setState(() {});
                            },
                          ),
                          16.width(),
                          Text(context.translation.satellite),
                        ],
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 8,
                  start: 8,
                  child: InkWellWithoutFeedback(
                    onTap: () {
                      Navigator.pop(context);
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
                if (selectedLatLng != null && !widget.isField)
                  PositionedDirectional(
                    bottom: 8,
                    start: 8,
                    end: 8,
                    child: ElevatedButton(
                      onPressed: () {
                        MapUtils.launchMap(selectedLatLng!);
                      },
                      child: Text(context.translation.goToLocation),
                    ),
                  ),
                if (widget.isField) ...[
                  Center(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withValues(alpha: 0.3),
                        ),

                        child: Icon(
                          Icons.gps_fixed_outlined,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: CustomCardWidget(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        spacing: 8,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              context
                                  .translation
                                  .movePointerToTheWantedLocations,
                            ),
                          ),
                          // if (selectedLatLng != null)
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                context.pop(center);
                              },
                              child: Text(context.translation.save),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
