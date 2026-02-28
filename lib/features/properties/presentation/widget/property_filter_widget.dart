import 'package:flutter/material.dart';
import 'package:real_state/features/core/domain/params/base_pagination_params.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/city_filter_dialog.dart';
import 'package:real_state/features/core/presentation/widget/dialogs/filter_dialog.dart';

class PropertyFilterWidget extends StatefulWidget {
  final PropertyGetParams params;
  final VoidCallback onFilter;

  const PropertyFilterWidget({
    super.key,
    required this.params,
    required this.onFilter,
  });

  @override
  State<PropertyFilterWidget> createState() => _PropertyFilterWidgetState();
}

class _PropertyFilterWidgetState extends State<PropertyFilterWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _isInitialAnimationDone = false;

  @override
  void initState() {
    super.initState();
    _startInitialAnimation();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _startInitialAnimation() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isInitialAnimationDone && _scrollController.hasClients) {
        _isInitialAnimationDone = true;

        final maxScrollExtent = _scrollController.position.maxScrollExtent;

        Future.delayed(Duration(milliseconds: 500)).then(
          (_) => _scrollController
              .animateTo(
                maxScrollExtent,
                duration: const Duration(milliseconds: 2000),
                curve: Curves.linear,
              )
              .then((_) {
                if (mounted && _scrollController.hasClients) {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.linear,
                  );
                }
              }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 16,
          children: [
            FilterChip(
              label: Text(context.translation.city),
              onSelected: (v) {
                showDialog(
                  context: context,
                  builder: (context) => CityFilterDialog(
                    onSelected: (v) {
                      widget.params.city = v?.id;
                      setState(() {});
                      widget.onFilter();
                    },
                    city: widget.params.city,
                  ),
                );
              },
              selected: widget.params.city != null,
            ),
            FilterChip(
              label: Text(context.translation.featured),
              onSelected: (v) {
                if (widget.params.isFeature != true) {
                  widget.params.isFeature = true;
                } else {
                  widget.params.isFeature = null;
                }
                setState(() {});
                widget.onFilter();
              },
              selected: widget.params.isFeature == true,
            ),

            FilterChip(
              label: Text(context.translation.mostExpensive),
              onSelected: (v) {
                widget.params.size = null;
                if (widget.params.price != BaseParamsSortType.desc) {
                  widget.params.price = BaseParamsSortType.desc;
                } else {
                  widget.params.price = null;
                }
                setState(() {});
                widget.onFilter();
              },
              selected: widget.params.price == BaseParamsSortType.desc,
            ),
            FilterChip(
              label: Text(context.translation.lessExpensive),
              onSelected: (v) {
                widget.params.size = null;
                if (widget.params.price != BaseParamsSortType.asc) {
                  widget.params.price = BaseParamsSortType.asc;
                } else {
                  widget.params.price = null;
                }
                setState(() {});
                widget.onFilter();
              },
              selected: widget.params.price == BaseParamsSortType.asc,
            ),
            FilterChip(
              label: Text(context.translation.biggest),
              onSelected: (v) {
                widget.params.price = null;
                if (widget.params.size != BaseParamsSortType.desc) {
                  widget.params.size = BaseParamsSortType.desc;
                } else {
                  widget.params.size = null;
                }
                setState(() {});
                widget.onFilter();
              },
              selected: widget.params.size == BaseParamsSortType.desc,
            ),
            FilterChip(
              label: Text(context.translation.smallest),
              onSelected: (v) {
                widget.params.price = null;
                if (widget.params.size != BaseParamsSortType.asc) {
                  widget.params.size = BaseParamsSortType.asc;
                } else {
                  widget.params.size = null;
                }
                setState(() {});
                widget.onFilter();
              },
              selected: widget.params.size == BaseParamsSortType.asc,
            ),
            FilterDialog<PropertyCategory>(
              onSelected: (v) {
                widget.params.category = v;
                setState(() {});
                widget.onFilter();
              },
              getName: (v) => context.translation.categoryE(v.name),
              selected: widget.params.category,
              height: 230,
              equal: (a, b) => a == b,
              title: context.translation.sellBuySwap,
              data: PropertyCategory.values,
            ),
            FilterDialog<PropertyDeedType>(
              onSelected: (v) {
                widget.params.propertyDeedType = v;
                setState(() {});
                widget.onFilter();
              },
              getName: (v) => context.translation.propertyDeedE(v.name),
              selected: widget.params.propertyDeedType,
              height: 350,
              equal: (a, b) => a == b,
              title: context.translation.propertyDeed,
              data: PropertyDeedType.values,
            ),
            FilterDialog<PropertyType>(
              onSelected: (v) {
                widget.params.propertyType = v;
                setState(() {});
                widget.onFilter();
              },
              getName: (v) => context.translation.propertyTypeE(v.name),
              selected: widget.params.propertyType,
              height: 400,
              equal: (a, b) => a == b,
              title: context.translation.propertyType,
              data: PropertyType.values,
            ),
          ],
        ),
      ),
    );
  }
}
