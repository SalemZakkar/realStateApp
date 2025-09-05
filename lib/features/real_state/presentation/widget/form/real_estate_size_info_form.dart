import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/fields/chips_field.dart';
import 'package:real_state/features/core/presentation/widget/lable_widget.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';

import '../../../../../generated/generated_assets/assets.gen.dart';
import '../../../../core/presentation/utils/input_validator.dart';

class RealEstateSizeInfoForm extends StatefulWidget {
  final RealEstateParams params;

  const RealEstateSizeInfoForm({super.key, required this.params});

  @override
  State<RealEstateSizeInfoForm> createState() => _RealEstateSizeInfoFormState();
}

class _RealEstateSizeInfoFormState extends State<RealEstateSizeInfoForm> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          16.height(),
          LabelWidget(
            title: context.translation.size,
            svgGenImage: Assets.icons.size,
            child: TextFormField(
              initialValue: widget.params.propertySize?.toStringAsFixed(0),
              onChanged: (v) {
                widget.params.propertySize = double.tryParse(v);
              },
              decoration: InputDecoration(hintText: context.translation.sizeM2),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: MultiValidator([
                RequiredValidator(
                  errorText: context.translation.fieldRequiredMessage,
                ),
              ]).call,
            ),
          ),

          16.height(),

          ChipsSingleField(
            title: context.translation.rooms,
            required: true,

            onChanged: (v) {
              widget.params.room = v;
              setState(() {});
            },
            initial: widget.params.room,
            values: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
          ),
          16.height(),
          ChipsSingleField(
            initial: widget.params.bathrooms,

            title: context.translation.bathrooms,
            required: true,

            onChanged: (v) {
              widget.params.bathrooms = v;
              setState(() {});
            },
            values: [1, 2, 3, 4, 5, 6, 7],
          ),
          16.height(),
          ChipsSingleField(
            onChanged: (v) {
              widget.params.floor = v;
              setState(() {});
            },
            initial: widget.params.floor,
            title: context.translation.floor,
            required: true,
            values: List.generate((40), (i) => i + 1),
          ),
          16.height(),
        ],
      ),
    );
  }
}
