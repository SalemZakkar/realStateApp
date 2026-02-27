import 'package:core_package/core_package.dart';
import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/injection.dart';

class LegalPage extends StatefulWidget {
  static String path = "/LegalPage";
  final int type;

  const LegalPage({super.key, required this.type});

  @override
  State<LegalPage> createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  var cubit = getIt<AboutUsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type == 0
              ? context.translation.privacyPolicy
              : context.translation.termsAndConditions,
        ),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: ConsumerWidget(
          cubit: cubit,
          childBuilder: (context, data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    widget.type == 0
                        ? data.privacyPolicy!
                        : data.termsAndConditions!,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
          onRetry: cubit.start,
        ),
      ),
    );
  }
}
