import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart'
    show Assets;

class UpdateAppPage extends StatefulWidget {
  static String path = '/updateAppPage';

  const UpdateAppPage({super.key});

  @override
  State<UpdateAppPage> createState() => _UpdateAppPageState();
}

class _UpdateAppPageState extends State<UpdateAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme.of(context).brightness == Brightness.dark
                  ? Assets.images.icLauncherDark.image(width: 200, height: 200)
                  : Assets.images.icLauncher.image(width: 200, height: 200),
              32.height(),
              Text(
                context.translation.pleaseUpdateApp,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              32.height(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(context.translation.update),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
