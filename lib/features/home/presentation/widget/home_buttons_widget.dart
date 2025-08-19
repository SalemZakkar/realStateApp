import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/dynamic_svg_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_list_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_map_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_state_saved_page.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

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
        HeaderText(title: context.translation.fastAccess),
        8.height(),
        CustomCardWidget(
          borderRadius: BorderRadius.circular(8),
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
                          context.go(RealStateMapPage.path);
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
                        icon: Assets.icons.building.dynamicSVGColor(
                          context,
                          width: 40,
                          height: 40,
                          color: Colors.red,
                        ),
                        title: context.translation.propertiesList,
                        onTap: () {
                          context.go(RealStateListPage.path);
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
                        icon: Assets.icons.bookmark.dynamicSVGColor(
                          context,
                          width: 40,
                          height: 40,
                          color: Colors.purple,
                        ),
                        title: context.translation.savedProperties,
                        onTap: () {
                          context.go(RealStateSavedPage.path);
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
                          context.go(RealStateSavedPage.path);
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
