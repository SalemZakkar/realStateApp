import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/city_builder.dart';
import 'package:real_state/features/core/presentation/widget/map_cluster_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_get_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_map_get.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_details_page.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_filter_page.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_map_bloc_widget.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_marker_widget.dart';
import 'package:real_state/injection.dart';
import 'package:real_state/themes/app_theme.dart';

class RealStateMapPage extends StatefulWidget {
  static String path = '/real_state_map_page';

  const RealStateMapPage({super.key});

  @override
  State<RealStateMapPage> createState() => _RealStateMapPageState();
}

class _RealStateMapPageState extends State<RealStateMapPage> {
  var cubit = getIt<RealEstateMapGetCubit>();
  RealEstateGetParams params = RealEstateGetParams();

  MapClusterController<RealEstate> controller =
      MapClusterController<RealEstate>(
        getPosition: (e) {
          return LatLng((e).location.lat, (e).location.lng);
        },
        animationDuration: Duration(seconds: 5),
        identical: (k, a) => k.id == a.id,
      );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: CityBuilder(
          onInit: (v) {
            params.city = v.first;
            cubit.get(params: params);
          },
          builder: (c) {
            return Stack(
              children: [
                Positioned.fill(
                  child: MapClusterWidget<RealEstate>(
                    threshold: 7,
                    padding: 130,
                    mapClusterController: controller,
                    normalMarkerBuilder: (context, item) {
                      Size size = Size(70, 60);
                      return MarkerData.fromWidget(
                        child: RealEstateMarkerWidget(
                          realEstate: item,
                          size: size,
                        ),
                        size: size,
                      );
                    },
                    onItemTap: (item) {
                      context.push(RealEstateDetailsPage.path, extra: item);
                    },
                    clusterMarkerBuilder: (context, items) {
                      return MarkerData.fromWidget(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            items.items.length.toString(),
                            style: TextStyle(
                              color: context.appColorSchema.white,
                            ),
                          ),
                        ),
                        size: Size(40, 40),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 48,
                  left: 16,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                    ),
                    child: InkWellWithoutFeedback(
                      onTap: () {
                        context.push(
                          RealEstateFilterPage.path,
                          extra: RealEstateFilterPageParams(
                            params: params,
                            onChanged: (v) {
                              setState(() {
                                params = v;
                              });
                              params.page = null;
                              params.limit = null;
                              setState(() {});
                              cubit.get(params: params);
                            },
                          ),
                        );
                      },
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: context.translation.search,
                        ),
                        readOnly: true,
                        ignorePointers: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 76,
                  child: RealEstateMapBlocWidget(
                    cubit: cubit,
                    onSuccess: (v) async {
                      controller.addPoints(v);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
