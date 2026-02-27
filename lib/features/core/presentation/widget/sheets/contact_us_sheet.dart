// import 'package:core_package/core_package.dart';
// import 'package:flutter/material.dart';
// import 'package:real_state/features/core/domain/enum/contact_type.dart';
// import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
// import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
// import '../../../../../injection.dart';
// import '../contact_us_card.dart';
//
// class ContactUsSheet extends StatefulWidget {
//   const ContactUsSheet({super.key});
//
//   @override
//   State<ContactUsSheet> createState() => _ContactUsSheetState();
// }
//
// class _ContactUsSheetState extends State<ContactUsSheet> {
//   final cubit = getIt<ContactCubit>();
//
//   @override
//   Widget build(BuildContext context) {
//     return RegularBottomSheetLayout(
//       title: context.translation.contactUs,
//
//       body: ConsumerWidget(
//         cubit: cubit,
//         childBuilder: (context, state) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               8.height(),
//               for (var type in ContactType.values) ...[
//                 for (var e in state) ...[
//                   if (e.type == type) ...[
//                     ContactUsCard(contactItem: e),
//                     16.height(),
//                   ],
//                 ],
//               ],
//             ],
//           );
//         },
//         onRetry: () {
//           cubit.start();
//         },
//       ),
//     );
//   }
// }
