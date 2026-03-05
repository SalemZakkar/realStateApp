import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_map_params.dart';
import 'package:real_state/features/properties/presentation/cubits/property_map_cubit.dart';
import 'package:real_state/features/properties/presentation/page/properties_details_page.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';

class PropertyMapPage extends StatefulWidget {
  static String path = "/PropertyMapPage";

  const PropertyMapPage({super.key});

  @override
  State<PropertyMapPage> createState() => _PropertyMapPageState();
}

class _PropertyMapPageState extends State<PropertyMapPage> {
  MapClusterController<Property> mapClusterController =
      MapClusterController<Property>(
        getPosition: (v) => v.coordinates,
        animationDuration: Duration(seconds: 2),
        identical: (a, b) => a == b,
      );
  List<Property> data = [];
  var cubit = getIt<PropertyMapCubit>();

  LatLng? last;

  MapType mapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    cubit.get(
      PropertyMapParams(
        east: 41.04803524911404,
        north: 38.878757545501,
        south: 30.826963438577568,
        west: 36.38049468398094,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          BlocListener<PropertyMapCubit, BaseState<List<Property>>>(
            bloc: cubit,
            listener: (context, state) {
              if (state.isSuccess && state.item?.isEmpty == false) {
                int old = data.length;
                bool isEmpty = data.isEmpty;
                data.addAll(state.item ?? []);
                data = data.toSet().toList();
                if (old == data.length) {
                  return;
                }
                mapClusterController.addPoints(data, animate: isEmpty);
              }
            },
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: MapClusterWidget(
                type: mapType,
                normalMarkerBuilder: (context, property) {
                  return MarkerData.fromWidget(
                    child: property.isFeature
                        ? Assets.icons.mapFeaturedMarker.svg()
                        : Assets.icons.mapMarker.svg(),
                    size: Size(40, 40),
                  );
                },
                onItemTap: (v) {
                  context.push(PropertyDetailsPage.path, extra: v.id);
                },
                clusterMarkerBuilder: (_, l) {
                  return MarkerData.fromWidget(
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(l.count.toString()),
                    ),
                    size: Size(40, 40),
                  );
                },
                mapClusterController: mapClusterController,
                forceLightTheme: true,
                onCameraMove: (pos, radius, bounds) {
                  final south = bounds.southwest.latitude;
                  final west = bounds.southwest.longitude;
                  final north = bounds.northeast.latitude;
                  final east = bounds.northeast.longitude;

                  // radius is in meters (visible map radius)
                  // Clamp between 100m and 5000m
                  final double dynamicThreshold = (radius * 0.3).clamp(
                    100.0,
                    5000.0,
                  );

                  if (last == null) {
                    last = pos;
                    cubit.get(
                      PropertyMapParams(
                        east: east,
                        north: north,
                        south: south,
                        west: west,
                      ),
                    );
                    return;
                  }

                  final distance = MapUtils.haversine(last!, pos);

                  if (distance > dynamicThreshold) {
                    last = pos;
                    cubit.get(
                      PropertyMapParams(
                        east: east,
                        north: north,
                        south: south,
                        west: west,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
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
        ],
      ),
    );
  }
}
