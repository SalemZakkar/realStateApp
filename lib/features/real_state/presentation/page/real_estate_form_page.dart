import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/stepper_form_widget.dart';
import 'package:real_state/features/core/presentation/widget/stepper_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_create_cubit.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_edit_cubit.dart';
import 'package:real_state/features/real_state/presentation/page/real_estate_details_page.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_image_mange_widget.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_main_info_form.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_property_info_form.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_size_info_form.dart';
import 'package:real_state/injection.dart';

class RealEstateFormPage extends StatefulWidget {
  static const path = '/real_estate_add';
  final RealEstate? realEstate;

  const RealEstateFormPage({super.key, this.realEstate});

  @override
  State<RealEstateFormPage> createState() => _RealEstateFormPageState();
}

class _RealEstateFormPageState extends State<RealEstateFormPage> {
  late RealEstateParams params;
  final key = GlobalKey<FormState>();

  StepperFormWidgetController controller = StepperFormWidgetController();

  var addCubit = getIt<RealEstateCreateCubit>();
  var editCubit = getIt<RealEstateEditCubit>();

  RealEstate? realEstate;

  @override
  void initState() {
    super.initState();
    if (widget.realEstate != null) {
      params = RealEstateParams.fromRealEstate(realEstate: widget.realEstate!);
    } else {
      params = RealEstateParams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.addNewProperty)),
      body: ScreenLoader(
        cubit: editCubit,
        withSuccess: false,
        onSuccess: (v) {
          context.replace(RealEstateDetailsPage.path, extra: v);
        },

        child: ScreenLoader(
          cubit: addCubit,
          onSuccess: (v) {
            params.id = v.id;
            setState(() {
              realEstate = v;
            });
            controller.next();
          },
          child: Form(
            key: key,
            child: StepperFormWidget(
              canBack: (v) {
                return v <= 2;
              },
              controller: controller,
              onDone: () {
                if (key.currentState!.validate()) {
                  editCubit.edit(
                    params: RealEstateParams(
                      id: params.id,
                      images: params.images,
                    ),
                  );
                }
              },
              onNext: (v) {
                if (key.currentState!.validate()) {
                  if (v == 2) {
                    addCubit.add(params: params);
                  } else {
                    controller.next();
                  }
                }
              },
              pages: [
                RealEstateMainInfoForm(params: params),
                RealEstateSizeInfoForm(params: params),
                RealEstatePropertyInfoForm(params: params),
                if (realEstate != null) ...[
                  RealEstateImageManageWidget(
                    realEstate: realEstate!,
                    imageChanged: (v) {
                      params.images = v;
                    },
                  ),
                ],
              ],
              stepTitles: [
                StepperItem(context.translation.mainInfo),
                StepperItem(context.translation.sizeInfo),
                StepperItem(context.translation.propertyInfo),
                StepperItem(context.translation.images),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
