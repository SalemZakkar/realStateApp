import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/ad_banner/presentation/widget/ad_banner_widget.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/presentation/cubits/properties_get_list_cubit.dart';
import 'package:real_state/features/properties/presentation/widget/property_filter_widget.dart';
import 'package:real_state/features/properties/presentation/widget/property_grid_card_widget.dart';
import 'package:real_state/injection.dart';

class HomePage extends StatefulWidget {
  static const String path = "/homePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = getIt<PropertiesGetListCubit>();
  final params = PropertyGetParams(skip: 0, limit: 10);

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maison"), centerTitle: true),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverToBoxAdapter(child: AdBannerWidget()),
            SliverAppBar(

              floating: true,
              pinned: true,
              flexibleSpace: PropertyFilterWidget(
                params: params,
                onFilter: () {
                  params.reset();
                  cubit.get(params: params);
                },
              ),
            ),
            SliverToBoxAdapter(child: 2.height(),),
            SliverToBoxAdapter(
              child: GridViewPaginationWidget<Property>(
                paginationCubit: cubit,
                shrinkWrap: true,
                params: params,
                controller: controller,
                padding: EdgeInsets.only(bottom: 150, left: 16, right: 16),
                delegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  mainAxisExtent: 310,
                ),
                emptyState: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  alignment: Alignment.center,
                  child: NoDataWidget(),
                ),
                loading: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: CircularProgressIndicator(),
                ),
                error: (v) {
                  return Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: ErrorView(
                      failure: v,
                      onRetry: () {
                        cubit.get(params: params);
                      },
                    ),
                  );
                },
                itemBuilder: (data) {
                  return PropertyGridCardWidget(property: data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
