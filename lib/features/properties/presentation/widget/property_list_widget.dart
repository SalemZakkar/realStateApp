import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/entity/property.dart';
import 'package:real_state/features/properties/domain/params/property_get_params.dart';
import 'package:real_state/features/properties/presentation/cubits/properties_get_list_cubit.dart';
import 'package:real_state/features/properties/presentation/widget/propery_card.dart';
import 'package:real_state/injection.dart';

class PropertyListWidget extends StatefulWidget {
  const PropertyListWidget({
    super.key,
    required this.params,
    this.bloc,
    this.title,
  });

  final PropertyGetParams params;
  final PaginationCubit<Property, PropertyGetParams>? bloc;
  final String? title;

  @override
  State<PropertyListWidget> createState() => _PropertyListWidgetState();
}

class _PropertyListWidgetState extends State<PropertyListWidget> {
  late PropertyGetParams params;
  late PaginationCubit<Property, PropertyGetParams> bloc;

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
        // bottom: !widget.params.withFilter
        //     ? null
        //     : PreferredSize(
        //         preferredSize: Size(MediaQuery.of(context).size.width, 48 + 16),
        //         child: Padding(
        //           padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        //           child: SearchTextField(
        //             onChanged: (v) {
        //               params.title = v.trim().isEmpty ? null : v.trim();
        //               params.skip = 1;
        //               bloc.get(params: params);
        //             },
        //             onPressedFilter: () {
        //               context.push(
        //                 RealEstateFilterPage.path,
        //                 extra: RealEstateFilterPageParams(
        //                   onChanged: (v) {
        //                     params = v;
        //                     setState(() {});
        //                     bloc.get(params: v);
        //                   },
        //                   params: params,
        //                 ),
        //               );
        //             },
        //           ),
        //         ),
        //       ),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: ListViewPaginationWidget<Property>(
          padding: EdgeInsets.only(bottom: 90),
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
    );
  }
}
