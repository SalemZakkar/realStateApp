import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/cubit/pagination_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/list_view_pagination_widget.dart';
import 'package:real_state/features/core/presentation/widget/fields/search_text_filed.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_filter_page.dart';
import 'package:real_state/features/real_state/presentation/widget/real_state_card.dart';
import 'package:real_state/injection.dart';

class RealEstateListPageParams {
  Widget Function(RealEstate)? cardBuilder;
  PaginationCubit<RealEstate, RealEstateGetParams>? bloc;
  RealEstateGetParams? params;
  String? title;
  bool autoDispose;

  RealEstateListPageParams({
    required this.title,
    required this.params,
    required this.bloc,
    this.cardBuilder,
    this.autoDispose = false,
  });
}

class RealEstateListWidget extends StatefulWidget {
  const RealEstateListWidget({super.key, required this.params});

  final RealEstateListPageParams params;

  @override
  State<RealEstateListWidget> createState() => _RealEstateListWidgetState();
}

class _RealEstateListWidgetState extends State<RealEstateListWidget> {
  late RealEstateGetParams params;
  late PaginationCubit<RealEstate, RealEstateGetParams> bloc;

  @override
  void initState() {
    super.initState();
    params = widget.params.params ?? RealEstateGetParams(page: 1, limit: 10);
    bloc = widget.params.bloc ?? getIt<RealEstateGetListCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.params.title ?? context.translation.properties),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 48 + 16),
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: SearchTextField(
              onChanged: (v) {
                params.title = v.trim().isEmpty ? null : v.trim();
                params.page = 1;
                bloc.get(params: params);
              },
              onPressedFilter: () {
                context.push(
                  RealEstateFilterPage.path,
                  extra: RealEstateFilterPageParams(
                    onChanged: (v) {
                      params = v;
                      setState(() {});
                      bloc.get(params: v);
                    },
                    params: params,
                  ),
                );
              },
            ),
          ),
        ),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16
        ),
        constraints: const BoxConstraints.expand(),
        child: ListViewPaginationWidget<RealEstate>(
          paginationCubit: bloc,
          params: params,
          autoDispose: widget.params.autoDispose,
          itemBuilder: (data) {
            return Column(
              children: [
                RealStateCard(realEstate: data),
                8.height(),
              ],
            );
          },
        ),
      ),
    );
  }
}
