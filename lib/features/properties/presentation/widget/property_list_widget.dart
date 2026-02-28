import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/presentation/cubits/properties_get_list_cubit.dart';
import 'package:real_state/features/properties/presentation/widget/property_filter_widget.dart';
import 'package:real_state/features/properties/presentation/widget/propery_card.dart';
import 'package:real_state/injection.dart';

class PropertyListWidget extends StatefulWidget {
  const PropertyListWidget({
    super.key,
    required this.params,
    this.bloc,
    this.title,
    this.withFilter = true,
  });

  final PropertyGetParams params;
  final PaginationCubit<Property, PropertyGetParams>? bloc;
  final String? title;
  final bool withFilter;

  @override
  State<PropertyListWidget> createState() => _PropertyListWidgetState();
}

class _PropertyListWidgetState extends State<PropertyListWidget> {
  late PropertyGetParams params;
  late PaginationCubit<Property, PropertyGetParams> bloc;
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    params = widget.params.clone();
    bloc = widget.bloc ?? getIt<PropertiesGetListCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        title: Text(widget.title ?? context.translation.properties),
      ),

      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            if (widget.withFilter) ...[
              SliverAppBar(
                floating: true,
                flexibleSpace: PropertyFilterWidget(
                  params: params,
                  onFilter: () {
                    params.reset();
                    bloc.get(params: params);
                  },
                ),
              ),
            ],
            SliverToBoxAdapter(
              child: ListViewPaginationWidget<Property>(
                shrinkWrap: true,
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
                        bloc.get(params: params);
                      },
                    ),
                  );
                },
                scrollPhysics: NeverScrollableScrollPhysics(),
                scrollController: controller,
                padding: EdgeInsets.only(bottom: 90, left: 16, right: 16),
                paginationCubit: bloc,
                params: params,
                itemBuilder: (data) {
                  return Column(
                    children: [
                      PropertyCard(realEstate: data),
                      8.height(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
