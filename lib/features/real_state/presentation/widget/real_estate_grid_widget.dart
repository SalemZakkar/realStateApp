import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/cubit/base_states/base_paginated_list_state.dart';
import 'package:real_state/features/core/presentation/cubit/pagination_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/string.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/core/presentation/widget/image_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/core/presentation/widget/text/icon_text.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_details_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_list_page.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class RealEstateGridWidget extends StatefulWidget {
  final String title;
  final PaginationCubit<RealEstate, RealEstateGetParams> cubit;
  final RealEstateGetParams params;

  const RealEstateGridWidget({
    super.key,
    required this.params,
    required this.cubit,
    required this.title,
  });

  @override
  State<RealEstateGridWidget> createState() => _RealEstateGridWidgetState();
}

class _RealEstateGridWidgetState extends State<RealEstateGridWidget> {
  @override
  void initState() {
    super.initState();
    widget.cubit.get(params: widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      PaginationCubit<RealEstate, RealEstateGetParams>,
      BasePaginatedListState<RealEstate>
    >(
      bloc: widget.cubit,
      builder: (context, state) {
        if (state.isInProgress || state.isPaginateInProgress) {
          return const SizedBox.shrink();
        }
        if (state.isFailure || state.isPaginateFailure) {
          return const SizedBox.shrink();
        }
        if (state.isSuccess) {
          if (state.items.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            children: [
              InkWellWithoutFeedback(
                onTap: () {
                  context.push(
                    RealEStateListPage.extPath,
                    extra: RealEstateListPageParams.featured(context),
                  );
                },
                child: Row(
                  children: [
                    Expanded(child: HeaderText(title: widget.title)),
                    8.width(),
                    IconButton(
                      onPressed: () {
                        context.push(
                          RealEStateListPage.extPath,
                          extra: RealEstateListPageParams(
                            title: context.translation.featured,
                            withFilter: false,
                            params: RealEstateGetParams(isFeatured: true),
                            autoDispose: false,
                            bloc: getIt<RealEstateGetListCubit>(),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ],
                ),
              ),
              16.height(),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  mainAxisExtent: 250,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                itemBuilder: (context, index) {
                  return InkWellWithoutFeedback(
                    onTap: () {
                      context.push(
                        RealEstateDetailsPage.path,
                        extra: state.items[index],
                      );
                    },
                    child: CustomCardWidget(
                      borderRadius: BorderRadius.circular(8),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ImageWidget(
                                    borderRadius: BorderRadius.circular(4),
                                    width: double.infinity,
                                    url: state.items[index].images.first.getUrl,
                                  ),
                                ),
                                if (state.items[index].isFeature)
                                  PositionedDirectional(
                                    top: 4,
                                    end: 4,
                                    child: Icon(
                                      Icons.star,
                                      color: context.appColorSchema.gold,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          8.height(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconText(
                                icon: Assets.icons.info,
                                text: state.items[index].title,
                                maxLines: 1,
                              ),
                              6.height(),
                              IconText(
                                icon: Assets.icons.maps,
                                text: state.items[index].neighborhood,
                                maxLines: 1,
                              ),
                              6.height(),
                              IconText(
                                icon: Assets.icons.dollar,
                                text: state.items[index].price.formatPrice(
                                  context,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: state.items.length,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
