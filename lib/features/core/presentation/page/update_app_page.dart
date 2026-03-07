import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:platform_identity/platform_identity.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/page/about_us_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart'
    show Assets;
import 'package:real_state/injection.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppPage extends StatefulWidget {
  static String path = '/updateAppPage';

  const UpdateAppPage({super.key});

  @override
  State<UpdateAppPage> createState() => _UpdateAppPageState();
}

class _UpdateAppPageState extends State<UpdateAppPage> {
  var cubit = getIt<AboutUsCubit>()..start();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ConsumerWidget(
        cubit: cubit,
        childBuilder: (context, state) => Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          constraints: const BoxConstraints.expand(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme.of(context).brightness == Brightness.dark
                    ? Assets.images.icLauncherDark.image(width: 130)
                    : Assets.images.icLauncher.image(width: 130),
                32.height(),
                Text(
                  context.translation.pleaseUpdateTheApp,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                16.height(),
                Text(
                  "${context.translation.currentVersion} ${PlatformIdentity.getAppVersion()}",
                ),
                32.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      launchUrl(Uri.parse(state.googlePlay!));
                    },
                    child: Text(context.translation.update),
                  ),
                ),
                8.height(),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OutlinedButton(
                    onPressed: () {
                      context.push(AboutUsPage.path);
                    },
                    child: Text(context.translation.contactUs),
                  ),
                ),
              ],
            ),
          ),
        ),
        onRetry: cubit.start,
      ),
    );
  }
}
