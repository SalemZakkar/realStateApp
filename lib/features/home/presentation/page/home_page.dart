import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/utils/ext/num_ext.dart';
import 'package:real_state/features/home/presentation/widget/home_buttons_widget.dart';
import 'package:real_state/features/real_state/presentation/widget/real_estate_row_widget.dart';

class HomePage extends StatefulWidget {
  static const String path = "/homePage";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Maison Hub"), centerTitle: true),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              8.height(),
              HomeButtonsWidget(),
              9.height(),
              RealEstateRowWidget(),
              120.height(),

            ],
          ),
        ),
      ),
    );
  }
}
