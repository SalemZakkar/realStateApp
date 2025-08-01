import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/core/presentation/utils/ext/tr.dart';
import 'package:real_state/features/real_state/presentation/widget/real_state_card.dart';


class RealStateListPage extends StatefulWidget {
  static String path = '/real_state_list_page';

  const RealStateListPage({super.key});

  @override
  State<RealStateListPage> createState() => _RealStateListPageState();
}

class _RealStateListPageState extends State<RealStateListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.translation.realStates),
        // centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              8.height(),
              RealStateCard(),
              8.height(),
              RealStateCard(),
              8.height(),
              RealStateCard(),
              8.height(),
              RealStateCard(),
              8.height(),
              RealStateCard(),
              8.height(),
              RealStateCard(),
              8.height(),
              RealStateCard(),
              64.height(),
            ],
          ),
        ),
      ),
    );
  }
}
