import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/chips_widget.dart';
import 'package:real_state/features/core/presentation/widget/main_map_page.dart';
import 'package:real_state/features/properties/domain/enum/property_enum.dart';
import 'package:real_state/features/properties/domain/params/property_create_params.dart';
import 'package:real_state/injection.dart';

class PropertyMainDataWidget extends StatefulWidget {
  const PropertyMainDataWidget({super.key, required this.params});

  final PropertyAddEditParams params;

  @override
  State<PropertyMainDataWidget> createState() => _PropertyMainDataWidgetState();
}

class _PropertyMainDataWidgetState extends State<PropertyMainDataWidget> {
  var city = getIt<CityCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        LabelWidget(
          title: "${context.translation.price} (${context.translation.dollar})",
          child: TextFormField(
            onChanged: (v) {
              widget.params.price = int.tryParse(v);
            },
            initialValue: widget.params.price?.toString(),
            validator: RequiredValidator(
              errorText: context.translation.fieldRequiredMessage,
            ).call,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText:
                  "${context.translation.price} (${context.translation.dollar})",
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        LabelWidget(
          title: context.translation.city,
          child: DropDownBlocWidget(
            bloc: city,
            required: true,
            onChanged: (v) {
              widget.params.city = v;
            },
            hint: context.translation.city,
            value: widget.params.city,
            autoDispose: false,
            getValue: (v) => v.name,
            callBloc: () => city.start(),
          ),
        ),
        LabelWidget(
          title: context.translation.neighborhood,
          child: TextFormField(
            onChanged: (v) {
              widget.params.neighborhood = v;
            },
            initialValue: widget.params.neighborhood,
            validator: RequiredValidator(
              errorText: context.translation.fieldRequiredMessage,
            ).call,
            decoration: InputDecoration(
              hintText: context.translation.neighborhood,
            ),
          ),
        ),
        LabelWidget(
          title: context.translation.address,

          child: TextFormField(
            onChanged: (v) {
              widget.params.address = v;
            },
            initialValue: widget.params.address,
            validator: RequiredValidator(
              errorText: context.translation.fieldRequiredMessage,
            ).call,
            decoration: InputDecoration(hintText: context.translation.address),
          ),
        ),
        LabelWidget(
          title: "${context.translation.size} (${context.translation.m2})",
          child: TextFormField(
            onChanged: (v) {
              widget.params.size = int.tryParse(v);
            },
            initialValue: widget.params.size?.toString(),
            validator: RequiredValidator(
              errorText: context.translation.fieldRequiredMessage,
            ).call,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText:
                  "${context.translation.size} (${context.translation.m2})",
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
        LabelWidget(
          title: context.translation.stocks2400,
          child: TextFormField(
            onChanged: (v) {
              widget.params.stocks = int.tryParse(v);
            },
            initialValue: widget.params.stocks?.toString(),
            validator: RequiredValidator(
              errorText: context.translation.fieldRequiredMessage,
            ).call,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: context.translation.stocks2400,
            ),

            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.isEmpty) return newValue;

                final intValue = int.tryParse(newValue.text);
                if (intValue == null) return oldValue;

                if (intValue > 2400) {
                  return TextEditingValue(
                    text: '2400',
                    selection: TextSelection.collapsed(offset: 4),
                  );
                }

                return newValue;
              }),
            ],
          ),
        ),
        FormWidget(
          valid: widget.params.category != null,
          child: LabelWidget(
            title: context.translation.buyRentSwap,
            child: ChipsWidget(
              onSelect: (v) {
                widget.params.category = v;
                setState(() {});
              },
              spacing: 16,
              selected: widget.params.category,
              getString: (v) => context.translation.categoryE(v.name),
              items: PropertyCategory.values,
            ),
          ),
        ),
        FormWidget(
          valid: widget.params.propertyDeedType != null,
          child: LabelWidget(
            title: context.translation.propertyDeed,
            child: ChipsWidget(
              onSelect: (v) {
                widget.params.propertyDeedType = v;
                setState(() {});
              },
              spacing: 16,
              selected: widget.params.propertyDeedType,
              getString: (v) => context.translation.propertyDeedE(v.name),
              items: PropertyDeedType.values,
            ),
          ),
        ),
        FormWidget(
          valid: widget.params.propertyType != null,
          child: LabelWidget(
            title: context.translation.propertyType,
            child: ChipsWidget(
              onSelect: (v) {
                widget.params.propertyType = v;
                setState(() {});
              },
              spacing: 16,
              selected: widget.params.propertyType,
              getString: (v) => context.translation.propertyTypeE(v.name),
              items: PropertyType.values,
            ),
          ),
        ),
        FormWidget(
          valid: widget.params.room != null,
          child: LabelWidget(
            title: context.translation.rooms,
            child: ChipsWidget(
              onSelect: (v) {
                widget.params.room = v;
                setState(() {});
              },
              spacing: 16,
              selected: widget.params.room,
              items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14],
            ),
          ),
        ),
        FormWidget(
          valid: widget.params.bathrooms != null,
          child: LabelWidget(
            title: context.translation.bathrooms,
            child: ChipsWidget(
              onSelect: (v) {
                widget.params.bathrooms = v;
                setState(() {});
              },
              spacing: 16,
              selected: widget.params.bathrooms,
              items: [1, 2, 3, 4, 5, 6, 7, 8],
            ),
          ),
        ),
        FormWidget(
          valid: widget.params.floor != null,
          child: LabelWidget(
            title: context.translation.floor,
            child: ChipsWidget(
              onSelect: (v) {
                widget.params.floor = v;
                setState(() {});
              },
              spacing: 16,
              selected: widget.params.floor,
              items: List.generate(20, (e) => e + 1),
            ),
          ),
        ),
        FormWidget(
          valid: widget.params.latLng != null,
          child: LabelWidget(
            title: context.translation.location,
            child: MainMapWidget(
              onChanged: (v) {
                widget.params.latLng = v;
              },
              isField: true,
              size: Size(MediaQuery.of(context).size.width, 300),
              radius: BorderRadius.circular(12),
              initial: widget.params.latLng,
            ),
          ),
        ),
      ],
    );
  }
}
