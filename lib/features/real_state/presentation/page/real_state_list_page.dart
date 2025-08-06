import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/list_view_pagination_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/widget/real_state_card.dart';
import 'package:real_state/injection.dart';

class RealStateListPage extends StatefulWidget {
  static String path = '/real_state_list_page';

  const RealStateListPage({super.key});

  @override
  State<RealStateListPage> createState() => _RealStateListPageState();
}

class _RealStateListPageState extends State<RealStateListPage> {
  var cubit = getIt<RealEstateGetListCubit>();
  var params = RealEstateGetParams(skip: 0, limit: 10);
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    cubit.get(params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translation.realStates),
        // centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              8.height(),
              ListViewPaginationWidget<RealEstate>(
                paginationCubit: cubit,
                params: params,
                scrollController: scrollController,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (data) {
                  return Column(
                    children: [
                      RealStateCard(realEstate: data),
                      8.height(),
                    ],
                  );
                },
              ),
              128.height(),
            ],
          ),
        ),
      ),
    );
  }
}
