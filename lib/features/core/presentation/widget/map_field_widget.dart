// import 'package:core_package/core_package.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
// import 'package:real_state/generated/generated_assets/assets.gen.dart';
//
// class MapFieldWidget extends StatefulWidget {
//   final ValueChanged<LatLng> onChanged;
//   final LatLng? latLng;
//   final bool view;
//
//   const MapFieldWidget({
//     super.key,
//     this.latLng,
//     required this.onChanged,
//     required this.view,
//   });
//
//   @override
//   State<MapFieldWidget> createState() => _MapFieldWidgetState();
// }
//
// class _MapFieldWidgetState extends State<MapFieldWidget> {
//   LatLng? selectedLatLng;
//   late GoogleMapController controller;
//   BitmapDescriptor descriptor = BitmapDescriptor.defaultMarker;
//
//   @override
//   void initState() {
//     selectedLatLng = widget.latLng;
//     if (selectedLatLng == null && !widget.view) {
//       Geolocator.requestPermission().then((e) {
//         if (e == LocationPermission.always ||
//             e == LocationPermission.whileInUse) {
//           Geolocator.getCurrentPosition().then((e) {
//             controller.animateCamera(
//               CameraUpdate.newLatLngZoom(LatLng(e.latitude, e.longitude), 12),
//             );
//           });
//         }
//       });
//     }
//     super.initState();
//   }
//
//   @override
//   void didUpdateWidget(covariant MapFieldWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.latLng != oldWidget.latLng) {
//       selectedLatLng = widget.latLng;
//       if (selectedLatLng != null) {
//         controller.animateCamera(
//           CameraUpdate.newLatLngZoom(selectedLatLng!, 19),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWellWithoutFeedback(
//       child: IgnorePointer(
//         ignoring: widget.view,
//         child: Stack(
//           children: [
//             GoogleMap(
//               rotateGesturesEnabled: false,
//               zoomControlsEnabled: false,
//               // style: MapUtils.getTheme(context),
//               initialCameraPosition: CameraPosition(
//                 target: selectedLatLng ?? LatLng(34.8021, 38.9968),
//                 zoom: selectedLatLng != null ? 19 : 6,
//               ),
//               myLocationEnabled: true,
//               onMapCreated: (v) async {
//                 controller = v;
//                 selectedLatLng = widget.latLng;
//                 descriptor = await MarkerData.fromWidget(
//                   child: Assets.icons.mapMarker.svg(width: 32, height: 32),
//                   size: Size(32, 32),
//                 ).getIcon();
//                 setState(() {});
//               },
//               markers: selectedLatLng != null
//                   ? {
//                       Marker(
//                         markerId: const MarkerId('selected_location'),
//                         position: selectedLatLng!,
//                         icon: descriptor,
//                       ),
//                     }
//                   : {},
//               onTap: widget.view
//                   ? null
//                   : (LatLng latLng) {
//                       setState(() {
//                         selectedLatLng = latLng;
//                       });
//                     },
//             ),
//             if (widget.view) ...[
//               if (selectedLatLng != null) ...[
//                 Positioned(
//                   bottom: 8,
//                   left: 16,
//                   right: 16,
//                   child: CustomCardWidget(
//                     child: Text(context.translation.pressHereToChangeLocation),
//                   ),
//                 ),
//               ],
//               if (selectedLatLng == null) ...[
//                 Positioned(
//                   bottom: 8,
//                   left: 16,
//                   right: 16,
//                   child: CustomCardWidget(
//                     child: Text(context.translation.pressHereToSelectLocation),
//                   ),
//                 ),
//               ],
//             ],
//             if (!widget.view) ...[
//               Positioned(
//                 bottom: 8,
//                 left: 8,
//                 right: 8,
//                 child: CustomCardWidget(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     mainAxisSize: MainAxisSize.min,
//                     spacing: 8,
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width,
//                         child: Text(
//                           context
//                               .translation
//                               .pressOnThePlaceYouWantToSetYourPropertyLocation,
//                         ),
//                       ),
//                       if (selectedLatLng != null)
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               widget.onChanged(selectedLatLng!);
//                             },
//                             child: Text(context.translation.save),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
