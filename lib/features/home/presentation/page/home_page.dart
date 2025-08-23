import 'package:flutter/material.dart';
import 'package:real_state/features/ad_banner/presentation/widget/ad_banner_widget.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/home/presentation/widget/home_buttons_widget.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/injection.dart';

import '../../../real_state/presentation/widget/real_estate_featured_widget.dart';

class HomePage extends StatefulWidget {
  static const String path = "/homePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final featuredCubit = getIt<RealEstateGetListCubit>();
  final featuredParams = RealEstateGetParams(page: 1, limit: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maison Hub"), centerTitle: true),
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
                    16.height(),
                    RealEstateRowWidget<RealEstateGetParams>(
                      params: featuredParams,
                      cubit: featuredCubit,
                      title: context.translation.featured,
                    ),
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
