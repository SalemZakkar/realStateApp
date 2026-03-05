// import 'package:core_package/core_package.dart';
// import 'package:core_package/generated/generated_assets/assets.gen.dart';
// import 'package:flutter/material.dart';
//
// class MapViewWidget extends StatefulWidget {
//   final LatLng? latLng;
//   final MarkerData? icon;
//   final bool root;
//
//   const MapViewWidget({super.key, this.latLng, this.icon, this.root = true});
//
//   @override
//   State<MapViewWidget> createState() => _MapViewWidgetState();
// }
//
// class _MapViewWidgetState extends State<MapViewWidget> {
//   BitmapDescriptor bitmapDescriptor = BitmapDescriptor.defaultMarker;
//   Marker? marker;
//   LatLng? latLng;
//   late GoogleMapController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     latLng = widget.latLng;
//   }
//
//   @override
//   void didUpdateWidget(covariant MapViewWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.latLng != widget.latLng && marker != null) {
//       setState(() {
//         latLng = widget.latLng;
//         marker = marker!.copyWith(positionParam: widget.latLng);
//       });
//       controller.animateCamera(CameraUpdate.newLatLngZoom(widget.latLng!, 18));
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWellWithoutFeedback(
//       onTap: widget.root
//           ? () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Scaffold(
//                     body: SafeArea(
//                       child: MapViewWidget(
//                         latLng: latLng,
//                         icon: widget.icon,
//                         root: false,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           : null,
//       child: Stack(
//         children: [
//           Positioned.fill(
//             child: IgnorePointer(
//               ignoring: widget.root,
//               child: GoogleMap(
//                 rotateGesturesEnabled: false,
//                 mapType: MapType.normal,
//                 tiltGesturesEnabled: false,
//                 initialCameraPosition: CameraPosition(
//                   target: widget.latLng ?? LatLng(34.8021, 38.9968),
//                   zoom: widget.latLng != null ? 19 : 6,
//                 ),
//                 zoomControlsEnabled: false,
//                 // style: MapUtils.getTheme(context),
//                 markers: marker == null ? {} : {marker!},
//                 onMapCreated: (c) async {
//                   controller = c;
//                   bitmapDescriptor =
//                       await widget.icon?.getIcon() ??
//                       BitmapDescriptor.defaultMarker;
//                   marker = Marker(
//                     markerId: MarkerId('Pos'),
//                     icon: bitmapDescriptor,
//                   );
//                   if (latLng != null) {
//                     marker = marker!.copyWith(positionParam: latLng!);
//                   }
//                   setState(() {});
//                 },
//               ),
//             ),
//           ),
//           if (widget.root)
//             PositionedDirectional(
//               top: 8,
//               end: 8,
//               child: Container(
//                 padding: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: CoreAssets.icons.expand.dynamicSVGColor(
//                   context,
//                   package: 'core_package',
//                 ),
//               ),
//             ),
//           if (!widget.root)
//             PositionedDirectional(
//               top: 8,
//               start: 8,
//               child: InkWellWithoutFeedback(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).scaffoldBackgroundColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     Icons.arrow_back_ios_new,
//                     color: Theme.of(context).iconTheme.color,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }
