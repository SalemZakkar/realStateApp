import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' hide MapType;
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  static LatLngBounds getBounds(List<LatLng> list) {
    assert(list.isNotEmpty);
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
        northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }

  static LatLngBounds calcBoundsForCircle(double radius, LatLng center) {
    return getBounds(
      [
        moveLatLng(center, radius, 0),
        moveLatLng(center, radius, 180),
      ],
    );
  }

  static LatLng moveLatLng(
      LatLng startLatLng, double distanceInMeters, double bearing) {
    const earthRadius = 6378137; // in meters

    double lat1 = startLatLng.latitude * pi / 180;
    double lon1 = startLatLng.longitude * pi / 180;
    double brng = bearing * pi / 180;
    double d = distanceInMeters;

    double lat2 = asin(sin(lat1) * cos(d / earthRadius) +
        cos(lat1) * sin(d / earthRadius) * cos(brng));
    double lon2 = lon1 +
        atan2(sin(brng) * sin(d / earthRadius) * cos(lat1),
            cos(d / earthRadius) - sin(lat1) * sin(lat2));

    lat2 = lat2 * 180 / pi;
    lon2 = lon2 * 180 / pi;

    return LatLng(lat2, lon2);
  }

  static num haversine(LatLng l1, LatLng l2) {
    double startLatitude = 0,
        startLongitude = 0,
        endLatitude = 0,
        endLongitude = 0;
    startLatitude = l1.latitude * pi / 180;
    startLongitude = l1.longitude * pi / 180;
    endLatitude = l2.latitude * pi / 180;
    endLongitude = l2.longitude * pi / 180;

    double dLon = endLongitude - startLongitude;
    double dLat = endLatitude - startLatitude;
    double a = pow(sin(dLat / 2), 2) +
        cos(startLatitude) * cos(endLatitude) * pow(sin(dLon / 2), 2);
    double c = 2 * asin(sqrt(a));

    double r = 6378137;

    return (c * r);
  }

  static Future<Offset> latLngToPixels(
      LatLng latLng, GoogleMapController controller) async {
    ScreenCoordinate s = (await controller.getScreenCoordinate(latLng));
    return Offset(s.x.toDouble(), s.y.toDouble());
  }

  static Future<double> distanceInPx(
      LatLng start, LatLng dest, GoogleMapController controller) async {
    double dist = 0;
    Offset c1 = await latLngToPixels(start, controller);
    Offset c2 = await latLngToPixels(dest, controller);
    double pixelSize = pow(2, -(await controller.getZoomLevel())).toDouble();
    dist = (sqrt((c1.dx - c2.dx) * (c1.dx - c2.dx) +
            (c1.dy - c2.dy) * (c1.dy - c2.dy))) /
        pixelSize;
    return dist;
  }

  static LatLng calcCenterOfLATLNGS(List<LatLng> data) {
    double lat = 0, lng = 0;
    LatLng latLng = LatLng(lat, lng);
    int n = data.length;
    if (n == 0) {
      return latLng;
    }
    for (int i = 0; i < n; i++) {
      lat += data[i].latitude;
      lng += data[i].longitude;
    }
    return LatLng(lat / n, lng / n);
  }

  static double angleFromCoordinate(LatLng l1, LatLng l2) {
    final lat1 = l1.latitude * (pi / 180);
    final lon1 = l1.longitude * (pi / 180);
    final lat2 = l2.latitude * (pi / 180);
    final lon2 = l2.longitude * (pi / 180);

    final dLon = lon2 - lon1;

    final y = sin(dLon) * cos(lat2);
    final x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    final bearing = atan2(y, x);

    return (bearing * (180 / pi) + 360) % 360;
  }

  static Future<Uint8List> getUnit8ListFromWidget(Widget widget,
      {required Duration waitToRender}) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();
    final view = ui.PlatformDispatcher.instance.views.first;
    Size logicalSize = view.physicalSize / view.devicePixelRatio;
    Size imageSize = view.physicalSize;

    // assert(logicalSize.aspectRatio == imageSize.aspectRatio);

    final RenderView renderView = RenderView(
      view: view,
      child: RenderPositionedBox(
          alignment: Alignment.center, child: repaintBoundary),
      configuration: ViewConfiguration(
        logicalConstraints: BoxConstraints(
            maxHeight: logicalSize.height, minWidth: logicalSize.width),
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner(focusManager: FocusManager());

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: widget,
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

    await Future.delayed(waitToRender);

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(
        pixelRatio: imageSize.width / logicalSize.width);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  static Future<BitmapDescriptor> createMarkerFromWidget({
    required Widget child,
    Duration waitToRender = const Duration(milliseconds: 100),
    TextDirection textDirection = TextDirection.ltr,
    required Size size,
  }) async {
    final widget = RepaintBoundary(
      child: MediaQuery(
          data: const MediaQueryData(),
          child:
              Directionality(textDirection: TextDirection.ltr, child: child)),
    );
    final pngBytes = await getUnit8ListFromWidget(
      widget,
      waitToRender: waitToRender,
    );
    return BitmapDescriptor.bytes(pngBytes,
        width: size.width, height: size.height);
  }

  static Future<void> launchMap(LatLng latLng) async {
    if(kIsWeb){
      launchMapWeb(latLng);
      return;
    }
    MapType? type = (await getMaps()).firstOrNull?.mapType;
    if (type == null) {
      launchMapWeb(latLng);
      return;
    }
    await MapLauncher.showDirections(
      mapType: type,
      destination: Coords(
        latLng.latitude,
        latLng.longitude,
      ),
    );
  }

  static Future<List<AvailableMap>> getMaps() {
    return MapLauncher.installedMaps;
  }

  static Future<void> launchMapWeb(LatLng latLng) async {
    launchUrl(Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${latLng.latitude},${latLng.longitude}'));
  }
}
