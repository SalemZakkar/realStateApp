import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/log_in_widget.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_list_widget.dart';

import '../../../../injection.dart';
import '../../../core/presentation/cubit/pagination_cubit.dart';
import '../../domain/entity/real_estate.dart';
import '../cubit/real_estate_get_list_cubit.dart';
import '../cubit/real_estate_get_mine_list_cubit.dart';
import '../widget/real_estate_mine_card.dart';

class RealEstateListPageParams {
  Widget Function(RealEstate)? cardBuilder;
  PaginationCubit<RealEstate, RealEstateGetParams>? bloc;
  RealEstateGetParams? params;
  String? title;
  bool autoDispose;
  bool withFilter;
  bool shouldAuth;

  RealEstateListPageParams({
    required this.title,
    required this.params,
    required this.bloc,
    this.cardBuilder,
    this.autoDispose = false,
    this.withFilter = true,
    this.shouldAuth = false,
  });

  factory RealEstateListPageParams.mine(BuildContext context) =>
      RealEstateListPageParams(
        params: RealEstateGetParams(skip: 0, limit: 10),
        title: context.translation.myProperties,
        bloc: getIt<RealEstateGetMineListCubit>(),
        cardBuilder: (v) => RealEstateMineCard(realEstate: v),
        shouldAuth: true,
        withFilter: false,
      );

  factory RealEstateListPageParams.saved(BuildContext context) =>
      RealEstateListPageParams(
        params: RealEstateGetParams(skip: 0, limit: 10, isFavourite: true),
        title: context.translation.savedProperties,
        bloc: getIt<RealEstateGetListCubit>(),
        shouldAuth: true,
        withFilter: false,
      );

  factory RealEstateListPageParams.featured(BuildContext context) =>
      RealEstateListPageParams(
        params: RealEstateGetParams(skip: 0, limit: 10, isFeatured: true),
        title: context.translation.featured,
        bloc: getIt<RealEstateGetListCubit>(),
        shouldAuth: true,
        withFilter: false,
      );

  factory RealEstateListPageParams.normal(BuildContext context) =>
      RealEstateListPageParams(
        params: RealEstateGetParams(skip: 0, limit: 10),
        title: context.translation.properties,
        bloc: getIt<RealEstateGetListCubit>(),
      );
}

class RealEStateListPage extends StatefulWidget {
  static String path = '/real_state_list_page';
  static String extPath = '/real_state_list_page_ext';

  final RealEstateListPageParams? params;

  const RealEStateListPage({super.key, this.params});

  @override
  State<RealEStateListPage> createState() => _RealEStateListPageState();
}

class _RealEStateListPageState extends State<RealEStateListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((E) {
      params = widget.params ?? RealEstateListPageParams.normal(context);
      setState(() {
        initiated = true;
      });
    });
  }

  bool initiated = false;

  late RealEstateListPageParams params;

  @override
  Widget build(BuildContext context) {
    return !initiated
        ? const SizedBox.shrink()
        : UserBuilder(
            builder: (context, user) => RealEstateListWidget(params: params),
            unAuthWidget: params.shouldAuth
                ? Scaffold(
                    appBar: AppBar(title: Text(params.title ?? '')),
                    body: LogInWidget(
                      child: RealEstateListWidget(params: params),
                    ),
                  )
                : RealEstateListWidget(params: params),
          );
  }
}
