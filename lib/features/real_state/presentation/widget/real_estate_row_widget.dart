import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/core/presentation/widget/text/icon_text.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_featured_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_details_page.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';

class RealEstateRowWidget extends StatefulWidget {
  const RealEstateRowWidget({super.key});

  @override
  State<RealEstateRowWidget> createState() => _RealEstateRowWidgetState();
}

class _RealEstateRowWidgetState extends State<RealEstateRowWidget> {
  var cubit = getIt<RealEstateFeaturedListCubit>()..get();

  @override
  Widget build(BuildContext context) {
    return ConsumerWidget(
      errorBuilder: (context, error) => const SizedBox.shrink(),
      loadingBuilder: (context) => const SizedBox.shrink(),

      cubit: cubit,
      childBuilder: (context, data) {
        return Column(
          children: [
            HeaderText(title: context.translation.featured),
            8.height(),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisExtent: 250,
              ),
              itemBuilder: (context, index) {
                return InkWellWithoutFeedback(
                  onTap: (){
                    context.push(RealEstateDetailsPage.path , extra: data[index]);
                  },
                  child: CustomCardWidget(
                    borderRadius: BorderRadius.circular(8),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Expanded(
                          child: ImageWidget(
                            borderRadius: BorderRadius.circular(4),
                            width: double.infinity,

                            // height: 160,
                            url: data[index].images.first,
                          ),
                        ),
                        8.height(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconText(
                              icon: Assets.icons.info,
                              text: data[index].title,
                              maxLines: 1,
                            ),
                            6.height(),
                            IconText(
                              icon: Assets.icons.maps,
                              text: data[index].neighborhood,
                              maxLines: 1,
                            ),
                            6.height(),
                            IconText(
                              icon: Assets.icons.dollar,
                              text: data[index].price.formatPrice(context),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: data.length,
            ),
          ],
        );
      },
      onRetry: () {
        cubit.get();
      },
    );
  }
}
