// import 'package:flutter/material.dart';
// import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
// import 'package:real_state/features/core/presentation/widget/video_player_widget.dart';
//
// class PlayVideoPage extends StatefulWidget {
//   static String path = "/PlayVideoPage";
//   final String file;
//
//   const PlayVideoPage({super.key, required this.file});
//
//   @override
//   State<PlayVideoPage> createState() => _PlayVideoPageState();
// }
//
// class _PlayVideoPageState extends State<PlayVideoPage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(context.translation.theVideo)),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16),
//         constraints: const BoxConstraints.expand(),
//         child: SingleChildScrollView(
//           child: Column(
//             spacing: 16,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               VideoPlayerWidget(
//                 url: widget.file,
//                 size: Size(MediaQuery.of(context).size.width, 300),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
