import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/city_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/properties/domain/params/property_create_params.dart';
import 'package:real_state/features/properties/presentation/cubits/properties_details_cubit.dart';
import 'package:real_state/features/properties/presentation/cubits/property_add_edit_cubit.dart';
import 'package:real_state/features/properties/presentation/page/properties_details_page.dart';
import 'package:real_state/features/properties/presentation/widget/form/property_main_data_widget.dart';
import 'package:real_state/injection.dart';

class PropertyFormPage extends StatefulWidget {
  final String? id;
  static String path = "/PropertyFormPage";

  const PropertyFormPage({super.key, this.id});

  @override
  State<PropertyFormPage> createState() => _PropertyFormPageState();
}

class _PropertyFormPageState extends State<PropertyFormPage> {
  PropertyAddEditParams? params;
  var cubit = getIt<PropertiesDetailsCubit>();
  var addEdit = getIt<PropertyAddEditCubit>();
  var city = getIt<CityCubit>();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      cubit.get(widget.id!);
    }
    if (widget.id == null) {
      params = PropertyAddEditParams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id != null
              ? context.translation.edit
              : context.translation.postYourProperty,
        ),
      ),
      body: ScreenLoader(
        cubit: addEdit,
        onSuccess: (v) {
          if (widget.id == null) {
            context.replaceNamed(PropertyDetailsPage.path, extra: v.id);
          } else {
            context.pop();
          }
        },
        child: FormFieldWidget(
          builder: (form) => Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            constraints: BoxConstraints.expand(),
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  if (widget.id != null) ...[
                    ConsumerWidget(
                      onDataReceived: (v) {
                        params = PropertyAddEditParams.fromProperty(v);
                        setState(() {});
                      },
                      cubit: cubit,
                      childBuilder: (context, state) {
                        if (params == null) {
                          return const SizedBox();
                        }
                        return PropertyMainDataWidget(params: params!);
                      },
                      onRetry: () => cubit.get(widget.id!),
                    ),
                  ],
                  if (widget.id == null) ...[
                    PropertyMainDataWidget(params: params!),
                  ],
                  if (widget.id == null && params != null) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            addEdit.add(params!);
                          }
                        },
                        child: Text(context.translation.save),
                      ),
                    ),
                  ],
                  if (widget.id != null) ...[
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          if (form.currentState!.validate()) {
                            addEdit.edit(widget.id!, params!);
                          }
                        },
                        child: Text(context.translation.save),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _D extends StatefulWidget {
//   final StepperFormWidgetController controller;
//   final PropertyAddEditParams params;
//   final VoidCallback onDone;
//
//   const _D({
//     super.key,
//     required this.params,
//     required this.controller,
//     required this.onDone,
//   });
//
//   @override
//   State<_D> createState() => _DState();
// }
//
// class _DState extends State<_D> {
//   @override
//   Widget build(BuildContext context) {
//     return FormFieldWidget(
//       builder: (form) =>
//           StepperFormWidget(
//               stepTitles: [
//                 StepperItem(context.translation.mainInfo),
//                 StepperItem(context.translation.images),
//               ],
//               pages: [
//               ,
//               PropertyImageFormWidget(),
//               ],
//               onDone: () {},
//       onNext: (v) {
//         if (v == 0) {
//           if (form.currentState!.validate()) {
//             widget.onDone();
//           }
//         }
//       },
//       // isEnabled: {0: false},
//       onBack: (v) {
//         print(v);
//       },
//       controller: widget.controller,
//     ),);
//   }
// }
