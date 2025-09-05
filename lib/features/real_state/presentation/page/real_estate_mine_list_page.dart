import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_mine_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_list_widget.dart';
import 'package:real_state/injection.dart';

class RealEstateMineListPage extends StatefulWidget {
  static String path = "/RealEstateMineListPage";

  const RealEstateMineListPage({super.key});

  @override
  State<RealEstateMineListPage> createState() => _RealEstateMineListPageState();
}

class _RealEstateMineListPageState extends State<RealEstateMineListPage> {
  var params = RealEstateGetParams(page: 1, limit: 10);
  var cubit = getIt<RealEstateGetMineListCubit>();

  @override
  void initState() {
    super.initState();
    cubit.get(params: params);
  }

  @override
  Widget build(BuildContext context) {
    return RealEstateListWidget(
      params: RealEstateListPageParams(
        title: context.translation.myProperties,
        params: params,
        bloc: cubit,
        autoDispose: false,
      ),
    );
  }
}
