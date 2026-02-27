import 'package:carousel_slider/carousel_slider.dart';
import 'package:core_package/core_package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/ad_banner/presentation/cubit/ad_banner_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/injection.dart';
import 'package:url_launcher/url_launcher.dart';

class AdBannerWidget extends StatefulWidget {
  const AdBannerWidget({super.key});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  var cubit = getIt<AdBannerCubit>()..get();

  @override
  Widget build(BuildContext context) {
    return ConsumerWidget(
      cubit: cubit,
      autoDispose: false,
      loadingBuilder: (context) => const SizedBox.shrink(),
      errorBuilder: (fail) => const SizedBox.shrink(),
      childBuilder: (context, state) {
        if (state.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 230,
          child: CarouselSlider(
            items: state
                .map(
                  (e) => ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: InkWellWithoutFeedback(
                        onTap: () {
                          if (e.url != null) {
                            launchUrl(Uri.parse(e.url!));
                          }
                        },
                        child: ImageWidget(
                          borderRadius: BorderRadius.circular(6),
                          width: MediaQuery.of(context).size.width,
                          height: 230,
                          url: e.image.getUrl,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 230,
              viewportFraction: 1,
              enlargeCenterPage: false,
              autoPlay: kReleaseMode,
            ),
          ),
        );
      },
      onRetry: () => cubit.get(),
    );
  }
}
