import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_state/features/core/presentation/utils/ext/format_to_normal.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/user_builder.dart';
import 'package:real_state/features/core/presentation/widget/fields/city_field.dart';
import 'package:real_state/features/core/presentation/widget/fields/form_widget.dart';
import 'package:real_state/features/core/presentation/widget/fields/phone_input_field.dart';
import 'package:real_state/features/core/presentation/widget/lable_widget.dart';
import 'package:real_state/features/core/presentation/widget/map_widget.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate_location.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';

import '../../../../../generated/generated_assets/assets.gen.dart';
import '../../../../core/presentation/utils/input_validator.dart';

class RealEstateMainInfoForm extends StatefulWidget {
  final RealEstateParams params;

  const RealEstateMainInfoForm({super.key, required this.params});

  @override
  State<RealEstateMainInfoForm> createState() => _RealEstateMainInfoFormState();
}

class _RealEstateMainInfoFormState extends State<RealEstateMainInfoForm> {
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          LabelWidget(
            title: context.translation.title,
            svgGenImage: Assets.icons.title,
            child: TextFormField(
              initialValue: widget.params.title,
              onChanged: (v) {
                widget.params.title = v;
                setState(() {});
              },
              decoration: InputDecoration(hintText: context.translation.title),
              validator: RequiredValidator(
                errorText: context.translation.fieldRequiredMessage,
              ).call,
            ),
          ),
          16.height(),
          LabelWidget(
            title: context.translation.description,
            svgGenImage: Assets.icons.textDescription,
            child: TextFormField(
              initialValue: widget.params.description,
              onChanged: (v) {
                widget.params.description = v;
                setState(() {});
              },
              decoration: InputDecoration(
                hintText:
                    "${context.translation.description} (${context.translation.optional}) ",
              ),
              minLines: 1,
              maxLines: 4,
              validator: RequiredValidator(
                errorText: context.translation.fieldRequiredMessage,
              ).call,
            ),
          ),
          16.height(),
          UserBuilder(
            builder: (context, user) {
              return LabelWidget(
                instructions: context.translation.phoneNumberRealEstate,
                title: context.translation.phoneNumber,
                svgGenImage: Assets.icons.phone,
                child: PhoneInputFieldWidget(
                  filled: true,
                  onChanged: (v) {
                    widget.params.phoneNumber = v;
                  },
                  initialPhoneNumber: user.phoneNumber,
                ),
              );
            },
          ),
          16.height(),
          LabelWidget(
            title: context.translation.price,
            svgGenImage: Assets.icons.dollar,
            child: TextFormField(
              initialValue: widget.params.price?.toStringAsFixed(0),
              onChanged: (v) {
                widget.params.price = double.tryParse(v);
                setState(() {});
              },
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText:
                    "${context.translation.price} (${context.translation.inDollar}) ",
              ),
              minLines: 1,
              maxLines: 4,
              validator: (x) {
                if (x?.valOrNull == null) {
                  return context.translation.fieldRequiredMessage;
                }
                if (num.tryParse(x!) == null) {
                  return context.translation.fieldRequiredMessage;
                }
                return null;
              },
            ),
          ),

          16.height(),
          LabelWidget(
            title: context.translation.neighborhood,
            svgGenImage: Assets.icons.neighbourhood,
            child: TextFormField(
              initialValue: widget.params.neighborhood,
              onChanged: (v) {
                widget.params.neighborhood = v;
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: context.translation.neighborhood,
              ),
              validator: RequiredValidator(
                errorText: context.translation.fieldRequiredMessage,
              ).call,
            ),
          ),

          16.height(),
          LabelWidget(
            title: context.translation.city,
            svgGenImage: Assets.icons.city,
            child: CityField(
              required: true,
              onChanged: (v) {
                widget.params.city = v;
                setState(() {});
              },
              initial: widget.params.city,
            ),
          ),
          16.height(),
          LabelWidget(
            title: context.translation.propertyAge,
            svgGenImage: Assets.icons.realEstateAgent,
            child: TextFormField(
              initialValue: widget.params.propertyAge?.toStringAsFixed(0),
              onChanged: (v) {
                widget.params.propertyAge = int.tryParse(v);
                setState(() {});
              },
              decoration: InputDecoration(
                hintText:
                    "${context.translation.propertyAgeInYears} (${context.translation.optional})",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          16.height(),
          FormWidget(
            valid: widget.params.location != null,
            child: LabelWidget(
              title: context.translation.location,
              instructions:
                  context.translation.pressOnTheMapAndUseExpandIconForBiggerMap,
              svgGenImage: Assets.icons.mapMarker,
              child: MapWidget(
                width: MediaQuery.of(context).size.width,
                zoomControls: false,
                latLng: widget.params.location != null
                    ? LatLng(
                        widget.params.location!.lat,
                        widget.params.location!.lng,
                      )
                    : null,
                withExpand: true,
                onTap: (val) {
                  widget.params.location = RealEstateLocation(
                    lat: val.latitude,
                    lng: val.longitude,
                  );
                  setState(() {});
                },
                height: 300,
              ),
            ),
          ),
          16.height(),
        ],
      ),
    );
  }
}
