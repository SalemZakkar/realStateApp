import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/ad_banner/presentation/widget/ad_banner_widget.dart';
import 'package:real_state/features/home/presentation/widget/home_buttons_widget.dart';


class HomePage extends StatefulWidget {
  static const String path = "/homePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final featuredCubit = getIt<RealEstateGetListCubit>();
  // final featuredParams = RealEstateGetParams(
  //   skip: 0,
  //   limit: 10,
  //   isFeatured: true,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maison"), centerTitle: true),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AdBannerWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    16.height(),
                    HomeButtonsWidget(),

                    // 16.height(),
                    // RealEstateGridWidget(
                    //   params: featuredParams,
                    //   cubit: featuredCubit,
                    //   pageParams: RealEstateListPageParams.featured(context),
                    //   title: context.translation.featured,
                    // ),
                    120.height(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
