import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/core/presentation/widget/bloc_consumers/consumer_widget.dart';
import 'package:real_state/features/tutorial/presentation/cubit/tutorial_cubit.dart';
import 'package:real_state/features/tutorial/presentation/widget/tutorial_card.dart';
import 'package:real_state/injection.dart';

class TutorialPage extends StatefulWidget {
  static const String path = "/TutorialPage";

  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  var cubit = getIt<TutorialCubit>()..get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.translation.tutorial)),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),

        child: ConsumerWidget(
          cubit: cubit,
          childBuilder: (context, data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TutorialCard(tutorial: data[index]),
                    8.height(),
                  ],
                );
              },
            );
          },
          onRetry: cubit.get,
        ),
      ),
    );
  }
}
