import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/format_to_normal.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/chips_widget.dart';
import 'package:real_state/features/core/presentation/widget/city_builder.dart';
import 'package:real_state/features/core/presentation/widget/range_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/real_state/domain/enum/category_type.dart';
import 'package:real_state/features/real_state/domain/enum/property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/property_type.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/injection.dart';

class RealEstateFilterPageParams {
  final RealEstateGetParams? params;
  final ValueChanged<RealEstateGetParams> onChanged;

  RealEstateFilterPageParams({this.params, required this.onChanged});
}

class RealEstateFilterPage extends StatefulWidget {
  static String path = '/realEstateFilterPage';
  final RealEstateFilterPageParams params;

  const RealEstateFilterPage({super.key, required this.params});

  @override
  State<RealEstateFilterPage> createState() => _RealEstateFilterPageState();
}

class _RealEstateFilterPageState extends State<RealEstateFilterPage> {
  @override
  void initState() {
    super.initState();
    if (widget.params.params != null) {
      params.city = widget.params.params!.city;
      params.title = widget.params.params!.title;
      params.maxPrice = widget.params.params!.maxPrice;
      params.minPrice = widget.params.params!.minPrice;
      params.propertyDeedType = widget.params.params!.propertyDeedType;
      params.propertyType = widget.params.params!.propertyType;
      params.category = widget.params.params!.category;
      params.minSize = widget.params.params!.minSize;
      params.maxSize = widget.params.params!.maxSize;
      WidgetsBinding.instance.addPostFrameCallback((e) {
        setState(() {});
      });
    }
  }

  late double minPrice, maxPrice;
  late RangeValues priceRange;
  final cityCubit = getIt<CityCubit>()..start();

  RealEstateGetParams params = RealEstateGetParams(page: 1, limit: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.search)),
      body: CityBuilder(
        builder: (state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  8.height(),
                  if (state.length > 1) ...[
                    HeaderText(title: context.translation.city),
                    8.height(),
                    DropdownButtonFormField(
                      items: state
                          .map(
                            (e) =>
                                DropdownMenuItem(value: e, child: Text(e.name)),
                          )
                          .toList(),
                      hint: Text(context.translation.city),
                      value: params.city,
                      onChanged: (v) {
                        setState(() {
                          params.city = v;
                        });
                      },
                    ),
                    16.height(),
                  ],

                  HeaderText(title: context.translation.category),
                  8.height(),
                  ChipsWidget(
                    onSelect: (b) {
                      params.category = b;
                      setState(() {});
                    },
                    selected: params.category,
                    spacing: 8,
                    items: RealEstateCategory.values,
                    getString: (v) {
                      return context.translation.categoryE(v.name);
                    },
                  ),
                  16.height(),
                  HeaderText(title: context.translation.propertyType),
                  8.height(),
                  ChipsWidget(
                    onSelect: (b) {
                      params.propertyType = b;
                      setState(() {});
                    },
                    selected: params.propertyType,
                    spacing: 8,
                    items: RealEstatePropertyType.values,
                    getString: (v) {
                      return context.translation.propertyTypeE(v.name);
                    },
                  ),
                  16.height(),
                  HeaderText(
                    title: context.translation.propertyDeed,
                    textStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                  8.height(),
                  ChipsWidget(
                    onSelect: (b) {
                      params.propertyDeedType = b;
                      setState(() {});
                    },
                    selected: params.propertyDeedType,
                    spacing: 8,
                    items: RealEstatePropertyDeedType.values,
                    getString: (v) {
                      return context.translation.propertyDeedE(v.name);
                    },
                  ),
                  const Divider(),
                  InkWell(
                    onTap: (){
                      setState(() {
                        params.isFeatured = !(params.isFeatured ?? false);
                      });
                    },
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                      child: Row(
                        children: [
                          Icon(params.isFeatured == true ? Icons.check_box : Icons.check_box_outline_blank, color: Theme.of(context).primaryColor,),
                          8.width(),
                          Text(context.translation.featured , style: Theme.of(context).textTheme.titleMedium,)
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  HeaderText(title: context.translation.price),
                  8.height(),
                  RangeWidget(
                    max: 2e5,
                    min: 0,
                    division: 1000,
                    initial: RangeValues(
                      params.minPrice ?? 0,
                      params.maxPrice ?? 2e5,
                    ),
                    onChanged: (min, max) {
                      params.minPrice = min;
                      params.maxPrice = max;
                    },
                    readValue: (v) {
                      return v.formatPrice(context);
                    },
                  ),
                  16.height(),
                  HeaderText(title: context.translation.area),
                  8.height(),
                  RangeWidget(
                    max: 1000,
                    min: 0,
                    division: 100,
                    initial: RangeValues(
                      params.minSize ?? 0,
                      params.maxSize ?? 1000,
                    ),
                    onChanged: (min, max) {
                      params.minSize = min;
                      params.maxSize = max;
                    },
                    readValue: (v) {
                      return "${v.toStringAsFixed(0).formatNum()} ${context.translation.m2}";
                    },
                  ),
                  16.height(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              context.pop();
              widget.params.onChanged(params);
            },
            child: Text(context.translation.search),
          ),
        ),
      ),
    );
  }
}
