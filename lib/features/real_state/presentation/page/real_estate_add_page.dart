import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/stepper_form_widget.dart';
import 'package:real_state/features/core/presentation/widget/stepper_widget.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_add_params.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_main_info_form.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_property_info_form.dart';
import 'package:real_state/features/real_state/presentation/widget/form/real_estate_size_info_form.dart';

class RealEstateAddPage extends StatefulWidget {
  static const path = '/real_estate_add';

  const RealEstateAddPage({super.key});

  @override
  State<RealEstateAddPage> createState() => _RealEstateAddPageState();
}

class _RealEstateAddPageState extends State<RealEstateAddPage> {
  RealEstateAddParams params = RealEstateAddParams();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.addNewProperty)),
      body: Form(
        key: key,
        child: StepperFormWidget(
          onDone: () {},
          pages: [
            RealEstateMainInfoForm(params: params),
            RealEstateSizeInfoForm(params: params),
            RealEstatePropertyInfoForm(params: params),
          ],
          onPageChanged: (i) {},
          pageCanNext: (i) {
            return key.currentState?.validate() == true;
          },
          stepTitles: [
            StepperItem(context.translation.mainInfo),
            StepperItem(context.translation.sizeInfo),
            StepperItem(context.translation.propertyInfo),
          ],
        ),
      ),
    );
  }
}
