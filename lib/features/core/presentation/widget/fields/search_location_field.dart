// import 'package:flutter/material.dart';
// import 'package:google_services/google_services.dart';
// import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
// import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
// import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
// import 'package:real_state/features/core/presentation/widget/fields/search_text_filed.dart';
//
// class SearchLocationField extends StatefulWidget {
//   const SearchLocationField({super.key});
//
//   @override
//   State<SearchLocationField> createState() => _SearchLocationFieldState();
// }
//
// // context.push(
// // RealEstateFilterPage.path,
// // extra: RealEstateFilterPageParams(
// // params: params,
// // onChanged: (v) {
// // setState(() {
// // params = v;
// // });
// // params.page = null;
// // params.limit = null;
// // setState(() {});
// // cubit.get(params: params);
// // },
// // ),
// // );
// class _SearchLocationFieldState extends State<SearchLocationField> {
//   TextEditingController controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWellWithoutFeedback(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (context) => _SearchDialog(onChanged: (v) {}),
//         );
//       },
//       child: TextFormField(
//         readOnly: true,
//         controller: controller,
//         ignorePointers: true,
//         decoration: InputDecoration(hintText: context.translation.search),
//       ),
//     );
//   }
// }
//
// class _SearchDialog extends StatefulWidget {
//   final ValueChanged<PlaceAutocompleteResult?> onChanged;
//
//   const _SearchDialog({super.key, required this.onChanged});
//
//   @override
//   State<_SearchDialog> createState() => _SearchDialogState();
// }
//
// class _SearchDialogState extends State<_SearchDialog> {
//   var cubit = PlacesAutocompleteCubit();
//   String x = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [Text(context.translation.search), CloseButton()],
//       ),
//       insetPadding: EdgeInsets.symmetric(horizontal: 16),
//       content: Container(
//         constraints: const BoxConstraints(maxHeight: 400),
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             SearchTextField(
//               onChanged: (v) {
//                 x = v;
//                 cubit.get(params: PlacesAutocompleteParams(input: x));
//               },
//             ),
//             16.height(),
//             GoogleServicesBlocWidget(
//               cubit: cubit,
//               childBuilder: (context, state) {
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     return ListTile(title: Text(state[index].name));
//                   },
//                   itemCount: state.length,
//                 );
//               },
//               onRetry: () {
//                 cubit.get(params: PlacesAutocompleteParams(input: x));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
