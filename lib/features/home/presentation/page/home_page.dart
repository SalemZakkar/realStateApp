import 'package:flutter/material.dart';
import 'package:real_state/features/core/presentation/cubit/contact_cubit.dart';
import 'package:real_state/features/home/presentation/widget/bottom_bar.dart';
import 'package:real_state/injection.dart';

class HomePage extends StatefulWidget {
  static String path = "/home";
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getIt<ContactCubit>().start();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(children: [Positioned.fill(child: widget.child),
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(),
          ),
        )
        ,]),
      ),
    );
  }
}
