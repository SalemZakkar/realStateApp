import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/contact_us_phone_buttons.dart';
import 'package:real_state/injection.dart';

class CallUsDialog extends StatefulWidget {
  const CallUsDialog({super.key});

  @override
  State<CallUsDialog> createState() => _CallUsDialogState();
}

class _CallUsDialogState extends State<CallUsDialog> {
  var cubit = getIt<AboutUsCubit>()..start();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      title: Text(context.translation.contactUs),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: ConsumerWidget(
          autoDispose: false,
          cubit: cubit,
          childBuilder: (context, state) {
            return ListView.builder(
              itemCount: state.phones.length,
              itemBuilder: (context, index) {
                return TileButton(
                  title: state.phones[index],
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.end,
                  trailing: ContactUsPhoneButtons(phone: state.phones[index]),
                );
              },
            );
          },
          onRetry: cubit.start,
        ),
      ),
    );
  }
}
