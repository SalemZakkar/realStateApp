import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/features/tutorial/domain/entity/tutorial.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialCard extends StatefulWidget {
  final Tutorial tutorial;

  const TutorialCard({super.key, required this.tutorial});

  @override
  State<TutorialCard> createState() => _TutorialCardState();
}

class _TutorialCardState extends State<TutorialCard> {
  @override
  Widget build(BuildContext context) {
    return InkWellWithoutFeedback(
      onTap: (){
        launchUrl(Uri.parse(widget.tutorial.url));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
        child: Stack(
          children: [
            ImageWidget(
              width: MediaQuery.of(context).size.width,
              height: 220,
              url: widget.tutorial.image.getUrl,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    alignment: AlignmentDirectional.centerStart,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: Text(
                      widget.tutorial.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CustomCardWidget(
// padding: EdgeInsets.all(8),
// borderRadius: BorderRadius.circular(8),
// child: SizedBox(
// width: MediaQuery.of(context).size.width,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// ImageWidget(
// width: MediaQuery.of(context).size.width,
// height: 200,
// borderRadius: BorderRadius.circular(4),
// url: widget.tutorial.image.getUrl,
// ),
// 8.height(),
// Text(widget.tutorial.title, style: TextStyle(fontSize: 22)),
// ],
// ),
// ),
// )
