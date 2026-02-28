import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/page/legal_page.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/contact_us_phone_buttons.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection.dart';

class AboutUsPage extends StatefulWidget {
  static String path = '/aboutUs_page';

  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var cubit = getIt<AboutUsCubit>()..start();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.aboutUs), centerTitle: true),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ConsumerWidget(
          cubit: cubit,
          childBuilder: (context, data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Theme.of(context).brightness == Brightness.dark
                      ? Assets.images.icLauncherDark.image(width: 200)
                      : Assets.images.icLauncher.image(width: 200),
                  if (data.description != null) ...[
                    Text(data.description ?? '', textAlign: TextAlign.center),
                    16.height(),
                  ],
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Column(
                      children: [
                        if (data.facebookLink != null) ...[
                          InkWellWithoutFeedback(
                            onTap: () {
                              launchUrl(Uri.parse(data.facebookLink!));
                            },
                            child: TileButton(
                              title: 'Facebook',
                              leadingWidth: 40,
                              leading: Assets.images.facebook.image(width: 56),
                            ),
                          ),
                        ],
                        if (data.instagramLink != null) ...[
                          InkWellWithoutFeedback(
                            onTap: () {
                              launchUrl(Uri.parse(data.instagramLink!));
                            },
                            child: TileButton(
                              title: 'Instagram',
                              leadingWidth: 40,
                              leading: Assets.images.instagram.image(width: 56),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  16.height(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        InkWellWithoutFeedback(
                          onTap: () {
                            context.push(LegalPage.path, extra: 0);
                          },
                          child: TileButton(
                            title: context.translation.privacyPolicy,
                          ),
                        ),
                        InkWellWithoutFeedback(
                          onTap: () {
                            context.push(LegalPage.path, extra: 1);
                          },
                          child: TileButton(
                            title: context.translation.termsAndConditions,
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.height(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      children: [
                        for (var e in data.phones) ...[
                          TileButton(
                            title: e,
                            trailing: ContactUsPhoneButtons(phone: e),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ],
                    ),
                  ),

                  120.height(),
                ],
              ),
            );
          },
          onRetry: cubit.start,
          autoDispose: false,
        ),
      ),
    );
  }
}
