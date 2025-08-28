import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/log_in_widget.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_get_list_cubit.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_list_widget.dart';
import 'package:real_state/injection.dart';

class RealEStateSavedPage extends StatefulWidget {
  static String path = '/real_state_saved_page';

  const RealEStateSavedPage({super.key});

  @override
  State<RealEStateSavedPage> createState() => _RealEStateSavedPageState();
}

class _RealEStateSavedPageState extends State<RealEStateSavedPage> {
  var cubit = getIt<RealEstateGetListCubit>();
  var params = RealEstateGetParams(page: 1, limit: 10, isFavourite: true);

  @override
  void initState() {
    super.initState();
    cubit.get(params: params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogInWidget(
        child: RealEstateListWidget(
          params: RealEstateListPageParams(
            title: context.translation.savedProperties,
            params: params,
            bloc: cubit,
          ),
        ),
      ),
    );
  }
}
