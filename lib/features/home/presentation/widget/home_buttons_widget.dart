import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_mine_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_form_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_list_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_map_page.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_list_widget.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_mine_card.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class HomeButtonsWidget extends StatefulWidget {
  const HomeButtonsWidget({super.key});

  @override
  State<HomeButtonsWidget> createState() => _HomeButtonsWidgetState();
}

class _HomeButtonsWidgetState extends State<HomeButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    var h = 240;
    return Column(
      children: [
        // HeaderText(title: context.translation.fastAccess),
        // 8.height(),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).cardColor,
            boxShadow: [context.appColorSchema.shadows.cardShadow],
          ),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: h / 2,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _Button(
                        icon: Assets.icons.maps.dynamicSVGColor(
                          context,
                          width: 40,
                          height: 40,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: context.translation.propertiesMap,
                        onTap: () {
                          context.go(RealEStateMapPage.path);
                        },
                      ),
                    ),
                    Container(
                      height: h / 2,
                      color: Theme.of(context).dividerColor,
                      width: 0,
                    ),
                    Expanded(
                      child: _Button(
                        icon: Assets.icons.bookmark.dynamicSVGColor(
                          context,
                          width: 40,
                          height: 40,
                          color: Colors.red,
                        ),
                        title: context.translation.savedProperties,
                        onTap: () {
                          context.pushNamed(
                            RealEStateListPage.extPath,
                            extra: RealEstateListPageParams(
                              title: context.translation.savedProperties,
                              withFilter: false,
                              autoDispose: false,
                              params: RealEstateGetParams(
                                skip: 0,
                                limit: 10,
                                isFeatured: true,
                              ),
                              bloc: getIt<RealEstateGetListCubit>(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: h / 2,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _Button(
                        icon: Icon(Icons.add, color: Colors.purple, size: 40),
                        title: context.translation.addNewProperty,
                        onTap: () {
                          context.push(RealEstateFormPage.path);
                        },
                      ),
                    ),
                    Container(
                      height: h / 2,
                      color: Theme.of(context).dividerColor,
                      width: 0,
                    ),
                    Expanded(
                      child: _Button(
                        icon: Icon(
                          Icons.library_books_outlined,
                          size: 40,
                          color: Colors.green,
                        ),
                        title: context.translation.myProperties,
                        onTap: () {
                          context.pushNamed(
                            RealEStateListPage.extPath,
                            extra: RealEstateListPageParams(
                              title: context.translation.myProperties,
                              withFilter: false,
                              cardBuilder: (data) =>
                                  RealEstateMineCard(realEstate: data),
                              autoDispose: false,
                              params: RealEstateGetParams(skip: 0, limit: 10),
                              bloc: getIt<RealEstateGetMineListCubit>(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;

  const _Button({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWellWithoutFeedback(
      onTap: () {
        onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [icon, 16.height(), Text(title)],
      ),
    );
  }
}
