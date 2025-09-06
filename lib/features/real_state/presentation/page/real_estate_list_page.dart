import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_list_widget.dart';
import 'package:real_state/injection.dart';

class RealEStateListPage extends StatefulWidget {
  static String path = '/real_state_list_page';
  static String extPath = '/real_state_list_page_ext';

  final RealEstateListPageParams? params;

  const RealEStateListPage({super.key,  this.params});

  @override
  State<RealEStateListPage> createState() => _RealEStateListPageState();
}

class _RealEStateListPageState extends State<RealEStateListPage> {
  var cubit = getIt<RealEstateGetListCubit>();
  var params = RealEstateGetParams(skip: 0, limit: 10);

  @override
  void initState() {
    super.initState();
    cubit.get(params: params);
  }

  @override
  Widget build(BuildContext context) {
    return RealEstateListWidget(
      params:
          widget.params ??
          RealEstateListPageParams(
            title: context.translation.properties,
            params: params,
            bloc: cubit,
          ),
    );
  }
}
