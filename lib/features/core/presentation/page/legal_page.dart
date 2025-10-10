import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/legal_cubit.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/injection.dart';

class LegalPage extends StatefulWidget {
  static String path = "/LegalPage";

  const LegalPage({super.key});

  @override
  State<LegalPage> createState() => _LegalPageState();
}

class _LegalPageState extends State<LegalPage> {
  var cubit = getIt<LegalCubit>()..get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: ConsumerWidget(
          cubit: cubit,
          childBuilder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  //
                ],
              ),
            );
          },
          onRetry: cubit.get,
        ),
      ),
    );
  }
}
