import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cl;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/utils/map_utils.dart';

class MapClusterWidget<T> extends StatefulWidget {
  final LatLng? initialLocation;
  final double? maxClusterZoom;
  final double threshold;
  final void Function(int)? onClusterTap;
  final void Function(T)? onItemTap;
  final MarkerData Function(BuildContext, cl.Cluster<Place<T>>)?
  clusterMarkerBuilder;
  final MarkerData Function(BuildContext, T)? normalMarkerBuilder;
  final ValueChanged<GoogleMapController>? onCreate;
  final double? distanceFilter;
  final void Function(LatLng latLng, double radius)? onCameraMove;
  final bool viewMapFromPage;
  final InfoWindow Function(T)? infoWindowBuilder;
  final bool hideExpand;
  final double? padding;

  final MapClusterController<T> mapClusterController;

  MapClusterWidget({
    super.key,
    required this.mapClusterController,
    this.clusterMarkerBuilder,
    this.normalMarkerBuilder,
    this.onClusterTap,
    this.onItemTap,
    this.initialLocation,
    this.maxClusterZoom,
    this.onCreate,
    this.onCameraMove,
    this.distanceFilter,
    this.viewMapFromPage = true,
    this.threshold = 10,
    this.infoWindowBuilder,
    this.hideExpand = false,
    this.padding,
  }) {
    assert(threshold >= 0, 'threshold INF >= X >= 0 got $threshold');
  }

  @override
  State<MapClusterWidget<T>> createState() => _MapClusterWidgetState<T>();
}

class _MapClusterWidgetState<T> extends State<MapClusterWidget<T>>
    with TickerProviderStateMixin {
  String? darkStyle;

  Future<void> _loadStyles() async {
    darkStyle = await rootBundle.loadString('assets/maps/map_dark_style.json');
    setState(() {});
  }

  List<T> get items => widget.mapClusterController.data;

  LatLng getPosition(int i) =>
      widget.mapClusterController.getPosition(items[i]);

  Map<int, List<Completer<bool>>> animatingTable = {};

  void setAnimationTable(int i, Completer<bool> c) {
    if (animatingTable[i] == null) {
      animatingTable[i] = [];
    }
    animatingTable[i]!.add(c);
  }

  bool hasAnimation() {
    return animatingTable.values
        .where((e) => e.where((k) => !k.isCompleted).isNotEmpty)
        .isNotEmpty;
  }

  Set<Marker> markers = {};

  late cl.ClusterManager<Place<T>> clusterManager;

  GoogleMapController? controller;

  LatLng? lastLatLng, pos;

  bool clEnabled = false;

  Map<int, double> angleTable = {};

  String markerId(int i) {
    return 'marker-$i';
  }

  LatLng? goingTo;

  @override
  void didUpdateWidget(covariant MapClusterWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.threshold != oldWidget.threshold) {
      initCluster(controller);
    }
    if (widget.maxClusterZoom != oldWidget.maxClusterZoom) {
      initCluster(controller);
    }
  }

  List<Place<T>> places = [];

  void initCluster(GoogleMapController? controller, {bool anim = true}) async {
    if (controller == null) {
      return;
    }
    // angleTable.clear();
    animatingTable.clear();
    clEnabled = false;
    places.clear();
    markers.clear();
    for (int i = 0; i < widget.mapClusterController.data.length; i++) {
      places.add(Place<T>(widget.mapClusterController.data[i], getPosition(i)));
    }
    clusterManager = cl.ClusterManager(
      places,
      (markers) {
        this.markers = markers;
        setState(() {});
      },
      clusterAlgorithm: cl.ClusterAlgorithm.maxDist,
      maxDistParams: cl.MaxDistParams(widget.threshold),
      extraPercent: 0.2,
      stopClusteringZoom: widget.maxClusterZoom,

      markerBuilder: (cluster) async {
        MarkerData markerData;
        if (cluster.isMultiple) {
          markerData =
              widget.clusterMarkerBuilder?.call(context, cluster) ??
              MarkerData.fromBitmap();
        } else {
          markerData =
              widget.normalMarkerBuilder?.call(
                context,
                cluster.items.first.item,
              ) ??
              MarkerData.fromBitmap();
        }
        int idx = widget.mapClusterController.data.indexWhere(
          (e) => widget.mapClusterController.identical(
            e,
            cluster.items.first.item,
          ),
        );
        String id = cluster.isMultiple
            ? cluster.location.toString()
            : markerId(idx);
        double angle = 0;
        if (!cluster.isMultiple) {
          angle = angleTable[idx] ?? markerData.angle ?? 0;
          angleTable[idx] = angle;
        }
        return Marker(
          onTap: () {
            if (cluster.isMultiple) {
              controller.animateCamera(
                CameraUpdate.newLatLngBounds(
                  MapUtils.getBounds(
                    cluster.items.map((e) => e.location).toList(),
                  ),
                  widget.padding ?? 80,
                ),
              );
              widget.onClusterTap?.call(cluster.items.length);
            } else {
              if (widget.onItemTap != null) {
                widget.onItemTap?.call(cluster.items.first.item);
              }
            }
          },
          infoWindow: cluster.isMultiple
              ? const InfoWindow()
              : (widget.infoWindowBuilder?.call(cluster.items.first.item) ??
                    const InfoWindow()),
          markerId: MarkerId(id),
          position: cluster.location,
          rotation: angle,
          anchor: const Offset(0.5, 0.5),
          icon: await markerData.getIcon(),
        );
      },
    );
    await clusterManager.setMapId(controller.mapId);
    setState(() {});
    if (anim) {
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          MapUtils.getBounds(places.map((e) => e.location).toList()),
          widget.padding ?? 80,
        ),
      );
    }
    clEnabled = true;
  }

  @override
  void initState() {
    super.initState();
    pos = widget.initialLocation ?? const LatLng(0, 0);
    widget.mapClusterController.addListener(() {
      if (widget.mapClusterController.isAddPoints) {
        angleTable.clear();
        initCluster(controller, anim: true);
      }
      if (widget.mapClusterController.isChanged &&
          widget.mapClusterController.animationObject != null) {
        animate(widget.mapClusterController.animationObject!);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    animatingTable.clear();
  }

  @override
  void setState(VoidCallback fn) {
    if (!mounted) {
      return;
    }
    super.setState(fn);
  }

  void animate(_AnimationObject<T> a) async {
    var item = a.data;
    int i = a.i;
    LatLng dest = a.latLng;
    Completer<bool> completer = Completer();
    setAnimationTable(i, completer);
    for (var e in animatingTable[i] ?? <Completer<bool>>[]) {
      if (e.hashCode == completer.hashCode) {
        continue;
      }
      if (e.isCompleted) {
        continue;
      }
      await e.future;
    }
    AnimationController animationController = AnimationController(
      vsync: this,
      duration: widget.mapClusterController.animationDuration,
    );
    LatLng pos = getPosition(i);
    _LatLngTween tween = _LatLngTween(begin: pos, end: dest);
    String id = markerId(i);
    markers.removeWhere((e) => e.markerId.value == id);
    BitmapDescriptor icon;
    if (widget.normalMarkerBuilder == null) {
      icon = BitmapDescriptor.defaultMarker;
    } else {
      // ignore: use_build_context_synchronously
      icon = await widget.normalMarkerBuilder!.call(context, item).getIcon();
    }
    double angle = MapUtils.angleFromCoordinate(pos, dest);
    angleTable[i] = angle;
    Marker marker = Marker(
      markerId: MarkerId(id),
      position: pos,
      anchor: const Offset(0.5, 0.5),
      rotation: angle,
      icon: icon,
    );
    markers.add(marker);
    setState(() {});
    Animation<LatLng> animation = tween.animate(animationController);
    widget.mapClusterController.data[i] = item;
    setState(() {});
    animation.addListener(() {
      if (animatingTable.isEmpty) {
        markers.clear();
        animationController.dispose();
        return;
      }
      if (animationController.isCompleted) {
        completer.complete(true);
        animationController.dispose();
        if (!hasAnimation()) {
          initCluster(controller, anim: false);
        }
        setState(() {});
        return;
      }
      markers.removeWhere((e) => e.markerId.value == id);
      marker = marker.copyWith(positionParam: animation.value);
      markers.add(marker);
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onTap: (v) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          myLocationEnabled: true,
          style: Theme.of(context).brightness == Brightness.dark
              ? darkStyle
              : null,
          mapToolbarEnabled: false,
          rotateGesturesEnabled: false,
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
              () => EagerGestureRecognizer(),
            ),
          },
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          onCameraMove: (data) {
            if (!clEnabled) return;
            if (hasAnimation()) {
              return;
            }
            clusterManager.onCameraMove(data);
            pos = data.target;
          },
          onCameraIdle: () async {
            double radius = 0;
            if (controller != null) {
              var bounds = await controller!.getVisibleRegion();
              radius = MapUtils.haversine(
                bounds.northeast,
                bounds.southwest,
              ).toDouble();
            }
            if (lastLatLng == null) {
              lastLatLng = pos;
              widget.onCameraMove?.call(pos!, radius);
            } else {
              double dist = MapUtils.haversine(lastLatLng!, pos!).toDouble();
              if (dist > (widget.distanceFilter ?? double.maxFinite)) {
                lastLatLng = pos!;
                widget.onCameraMove?.call(pos!, radius);
              }
            }
            if (!clEnabled) return;
            if (hasAnimation()) return;
            clusterManager.updateMap();
          },
          markers: markers,
          onMapCreated: (controller) async {
            this.controller = controller;
            await _loadStyles();
            initCluster(controller);
            widget.onCreate?.call(controller);
            setState(() {});
          },
          initialCameraPosition: CameraPosition(
            target: widget.initialLocation ?? const LatLng(0, 0),
            zoom: 1,
          ),
        ),
      ],
    );
  }
}

class Place<T> with cl.ClusterItem {
  // final Marker marker;
  final LatLng latLng;
  final T item;

  Place(this.item, this.latLng);

  @override
  LatLng get location => latLng;

  // @override
  // LatLng get location {
  //   return marker.position;
  // }
}

class MapClusterController<T> extends ChangeNotifier {
  bool get isAddPoints {
    bool t = _isAddPoints;
    _isAddPoints = false;
    return t;
  }

  bool get isChanged {
    bool t = _isChanged;
    _isChanged = false;
    return t;
  }

  bool _isAddPoints = false;
  bool _isChanged = false;
  List<T> data = [];
  LatLng Function(dynamic) getPosition;
  bool Function(dynamic, dynamic) identical;
  Duration animationDuration;

  // ignore: library_private_types_in_public_api
  _AnimationObject<T>? animationObject;

  MapClusterController({
    required this.getPosition,
    required this.animationDuration,
    required this.identical,
  });

  void addPoints(List<T> points) {
    _isAddPoints = true;
    this.data = [];
    this.data.addAll(points);
    notifyListeners();
  }

  void changeData({required T item}) {
    animationObject = null;
    int changedIndex = data.indexWhere((e) => identical(e, item));
    if (changedIndex != -1) {
      LatLng changePos = getPosition(item);
      // T changed = data[changedIndex];
      animationObject = _AnimationObject(
        latLng: changePos,
        data: item,
        i: changedIndex,
      );
      _isChanged = true;
      notifyListeners();
    }
  }
}

class _LatLngTween extends Tween<LatLng> {
  _LatLngTween({required LatLng begin, required LatLng end})
    : super(begin: begin, end: end);

  @override
  LatLng lerp(double t) => LatLng(
    begin!.latitude + (end!.latitude - begin!.latitude) * t,
    begin!.longitude + (end!.longitude - begin!.longitude) * t,
  );
}

class _AnimationObject<T> {
  T data;
  LatLng latLng;
  int i;

  _AnimationObject({required this.latLng, required this.data, required this.i});
}

class MarkerData {
  Widget? child;
  Size? size;
  BitmapDescriptor? icon;
  double? angle;

  MarkerData._({this.child, this.icon, this.size, this.angle});

  factory MarkerData.fromBitmap({BitmapDescriptor? icon, double? angle}) {
    return MarkerData._(icon: icon, angle: angle);
  }

  factory MarkerData.fromWidget({
    required Widget child,
    required Size size,
    double? angle,
  }) {
    return MarkerData._(child: child, size: size, angle: angle);
  }

  Future<BitmapDescriptor> getIcon() async {
    return child != null
        ? await MapUtils.createMarkerFromWidget(child: child!, size: size!)
        : (icon ?? BitmapDescriptor.defaultMarker);
  }
}
