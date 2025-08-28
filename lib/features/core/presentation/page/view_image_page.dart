import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:platform_identity/platform_identity.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';

class ViewImagePage extends StatefulWidget {
  static const String path = "/view_image";
  final String url;

  const ViewImagePage({super.key, required this.url});

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.images)),
      body: Container(
        constraints: const BoxConstraints.expand(),
        alignment: Alignment.center,
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          // minScale: 2,
          imageProvider: NetworkImage(
            headers: {
              "appVersion" : PlatformIdentity.getAppVersion()
            },
            widget.url.getUrl!,
          ),
        ),
      ),
    );
  }
}
