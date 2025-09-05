import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/utils/input_validator.dart';
import 'package:real_state/features/core/presentation/widget/fields/chips_field.dart';
import 'package:real_state/features/core/presentation/widget/lable_widget.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_category_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_deed_type.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_property_type.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/generated/generated_assets/assets.gen.dart';

class RealEstatePropertyInfoForm extends StatefulWidget {
  final RealEstateParams params;

  const RealEstatePropertyInfoForm({super.key, required this.params});

  @override
  State<RealEstatePropertyInfoForm> createState() =>
      _RealEstatePropertyInfoFormState();
}

class _RealEstatePropertyInfoFormState
    extends State<RealEstatePropertyInfoForm> {
  final key = GlobalKey<FormState>();

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.params.stock?.toStringAsFixed(0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ChipsSingleField<RealEstateCategory>(
            title: context.translation.category,
            required: true,
            initial: widget.params.category,
            onChanged: (v) {
              widget.params.category = v;
              setState(() {});
            },
            getString: (v) {
              return context.translation.categoryE(v.name);
            },
            values: RealEstateCategory.values,
          ),
          16.height(),
          ChipsSingleField<RealEstatePropertyDeedType>(
            title: context.translation.propertyDeed,
            required: true,

            onChanged: (v) {
              widget.params.deedType = v;
              setState(() {});
            },
            initial: widget.params.deedType,
            getString: (v) {
              return context.translation.propertyDeedE(v.name);
            },
            values: RealEstatePropertyDeedType.values,
          ),
          16.height(),
          LabelWidget(
            title: context.translation.stock,
            svgGenImage: Assets.icons.stocks,
            child: TextFormField(
              controller: controller,
              onChanged: (v) {
                widget.params.stock = int.tryParse(v);
                int? k = int.tryParse(v);
                if (k != null && k > 2400) {
                  widget.params.stock = 2400;
                  controller.text = '2400';
                }
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: context.translation.stocks2400,
              ),
              keyboardType: TextInputType.number,
              validator: RequiredValidator(
                errorText: context.translation.fieldRequiredMessage,
              ).call,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          16.height(),
          ChipsSingleField<RealEstatePropertyType>(
            title: context.translation.propertyType,
            required: true,
            initial: widget.params.propertyType,
            onChanged: (v) {
              widget.params.propertyType = v;
              setState(() {});
            },
            getString: (v) {
              return context.translation.propertyTypeE(v.name);
            },
            values: RealEstatePropertyType.values,
          ),
          16.height(),
        ],
      ),
    );
  }
}
