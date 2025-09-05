import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_edit_cubit.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_image_mange_widget.dart';
import 'package:real_state/injection.dart';

class RealEstateImagePage extends StatefulWidget {
  static const String path = "/RealEstateImagePage";
  final RealEstate realEstate;

  const RealEstateImagePage({super.key, required this.realEstate});

  @override
  State<RealEstateImagePage> createState() => _RealEstateImagePageState();
}

class _RealEstateImagePageState extends State<RealEstateImagePage> {
  late RealEstateParams params;
  late RealEstateEditCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<RealEstateEditCubit>();
    params = RealEstateParams(
      images: widget.realEstate.images,
      id: widget.realEstate.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.images)),
      body: ScreenLoader(
        cubit: cubit,
        onSuccess: (v) {
          context.pop();
        },
        withSuccess: false,
        child: Container(
          constraints: const BoxConstraints.expand(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: RealEstateImageManageWidget(
            realEstate: widget.realEstate,
            imageChanged: (v) {
              params.images = v;
              setState(() {});
            },
          ),
        ),
      ),
      bottomNavigationBar: params.images!.isNotEmpty
          ? Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () {
                  cubit.edit(params: params);
                },
                child: Text(context.translation.save),
              ),
            )
          : null,
    );
  }
}
