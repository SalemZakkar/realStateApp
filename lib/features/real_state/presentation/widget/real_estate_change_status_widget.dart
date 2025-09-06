import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/screen_loader.dart';
import 'package:real_state/features/core/presentation/widget/buttons/inkwell_without_feedback.dart';
import 'package:real_state/features/core/presentation/widget/custom_card_widget.dart';
import 'package:real_state/features/core/presentation/widget/text/header_text.dart';
import 'package:real_state/features/real_state/domain/entity/real_estate.dart';
import 'package:real_state/features/real_state/domain/enum/real_estate_status.dart';
import 'package:real_state/features/real_state/domain/params/real_estate_params.dart';
import 'package:real_state/features/real_state/presentation/cubit/real_estate_edit_cubit.dart';
import 'package:real_state/injection.dart';

class RealEstateChangeStatusWidget extends StatefulWidget {
  final RealEstate realEstate;
  final ValueChanged<RealEstateStatus> onChanged;

  const RealEstateChangeStatusWidget({
    super.key,
    required this.realEstate,
    required this.onChanged,
  });

  @override
  State<RealEstateChangeStatusWidget> createState() =>
      _RealEstateChangeStatusWidgetState();
}

class _RealEstateChangeStatusWidgetState
    extends State<RealEstateChangeStatusWidget> {
  var cubit = getIt<RealEstateEditCubit>();

  @override
  Widget build(BuildContext context) {
    return ScreenLoader(
      cubit: cubit,
      withSuccess: false,
      onSuccess: (v) {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText(title: context.translation.status),
            8.height(),
            Text(context.translation.pressToChangePropertyStatus),
            16.height(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Wrap(
                runSpacing: 8,
                spacing: 8,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runAlignment: WrapAlignment.start,
                children: [
                  ...(widget.realEstate.status != RealEstateStatus.available
                          ? [widget.realEstate.status]
                          : RealEstateStatus.values)
                      .map(
                        (e) => InkWellWithoutFeedback(
                          onTap: () {
                            if (widget.realEstate.status == e) {
                              return;
                            }
                            cubit.edit(
                              params: RealEstateParams(
                                id: widget.realEstate.id,
                                status: e,
                              ),
                            );
                          },
                          child: CustomCardWidget(
                            backgroundColor: widget.realEstate.status == e
                                ? Theme.of(context).primaryColor
                                : null,
                            padding: EdgeInsets.all(8),
                            borderRadius: BorderRadius.circular(4),
                            child: Text(
                              context.translation.realEstateStatusE(e.name),
                              style: TextStyle(
                                color: widget.realEstate.status == e
                                    ? Colors.white
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
